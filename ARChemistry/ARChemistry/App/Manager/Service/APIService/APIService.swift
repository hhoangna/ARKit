import Foundation
import Alamofire;
import ObjectMapper

fileprivate var __identifier: UInt = 0;

enum APIOutput<T, E> {
    case object(T);
    case error(E);
}

enum APIInput {
    case empty;
    case dto(BaseDto); //dto: DataObject
    case json(Any); //dic: Dictionary
    case str(String, in: String?); //str: String
    case data(Data); //dic: Dictionary
}

protocol APIDataPresentable {
    var rawData: Data {get set}
}

typealias APIParams = [String: Any];
typealias APICallback<RESULT> = GenericAPICallback<RESULT, APIError>;
typealias GenericAPICallback<RESULT, ERROR> = (_ result: APIOutput<RESULT, ERROR>) -> Void;

class APIService {
    
    struct Static {
        static var sharedAPI:APIService?
    }
    
    enum StatusCode: Int {
        case success = 200
        case invalidInput = 400
        case notAuthorized = 401
        case serverError = 721
        case tokenFail = 603
    }
        
    fileprivate let sessionManager: SessionManager;
    fileprivate let responsedCallbackQueue: DispatchQueue;
    
    
   static func shared() -> APIService {
        if APIService.Static.sharedAPI == nil {
            let smConfig = URLSessionConfiguration.default
            let sessionMgr: SessionManager = SessionManager(configuration: smConfig);
            APIService.Static.sharedAPI = APIService(sessionMgr: sessionMgr);
        }
        return APIService.Static.sharedAPI!;
    }

    
    init(sessionMgr:SessionManager) {
        sessionManager = sessionMgr;
        responsedCallbackQueue = DispatchQueue.init(label: "api_responsed_callback_queue");
    }
    
    func jsonApplicationHeader() -> Dictionary<String, String> {
        return ["Content-Type": "application/json"];
    }
    
    func requestHeader(url: String, method: ParamsMethod, bodyData: Data?, bodyString: String?) -> HTTPHeaders {
        //fatalError("\(#function) should be implemented in \(ClassName(self))");
        var headers = jsonApplicationHeader();
        
        // setToken

        if let token = Config().user?.token {
            headers["token"] = token;
        }
        
        return headers;
    }
    
    func request<RESULT : BaseDto, ERROR: APIErrorDescrible>(method: ParamsMethod,
                 serverURL:String,
                 path: String,
                 query: [String: String] = [:],
                 input: APIInput,
                 callback:@escaping GenericAPICallback<RESULT, ERROR>) -> APIRequest{
        
        __identifier += 1;
        
        let identifier = __identifier;
        
        let path = preparePath(path, with: query);
        let url = MURL(serverURL, path);
        
        var alarmofireMethod: HTTPMethod;
        switch method {
        case .POST:
            alarmofireMethod = .post;
            break;
        case .PUT:
            alarmofireMethod = .put;
            break;
        case .PATCH:
            alarmofireMethod = .patch;
            break;
        case .DELETE:
            alarmofireMethod = .delete;
            break;
        default:
            alarmofireMethod = .get;
            break;
        }
        
        func APILog(_ STATUS: String, _ MSG: String?) {            
            print(">>> [API]  [\( String(format: "%04u", identifier) )] [\( method )] [\( path )] \( STATUS )");
            if let msg = MSG { print("\( msg )\n\n"); }
        }
        
        let encoding = APIEncoding(input, method: method);
        
        let headers = requestHeader(url: url, method: method, bodyData: encoding.bodyDataValue, bodyString: encoding.bodyStringValue);
        
        let request: DataRequest;
        
        request = sessionManager.request(url,
                                         method: alarmofireMethod,
                                         parameters: [:],
                                         encoding: encoding,
                                         headers: headers);
        
        APILog("REQUEST", encoding.bodyStringValue);
        
        request.responseJSON(queue: responsedCallbackQueue, options: .allowFragments) { (dataResponse) in
            
            let result: APIOutput<RESULT, ERROR>;
            
            let logResult = dataResponse.data != nil ? String(data: dataResponse.data!, encoding: .utf8) : "<empty>";
            var logStatus : String;
            
            if let statusCode = dataResponse.response?.statusCode {
                logStatus = String(statusCode);
            }else if let anError = dataResponse.error {
                logStatus = "\(anError)";
            }else{
                logStatus = "Unexpected Error!";
            }
            
            APILog("RESPONSE-\(logStatus)", logResult);
            
            switch dataResponse.result {
            case .success(let object):
                result = self.handleResponse(dataResponse: dataResponse, object: object)
                
            case .failure(let error):
                result = self.handleFailure(dataResponse: dataResponse, error: error)
            }
            
            DispatchQueue.main.async {
                callback(result);
            }
        };
        
        return APIRequest(alarmofireDataRequest: request);
    }
    
    
    func requestAPIServer<RESULT : BaseDto, ERROR: APIErrorDescrible>(method: ParamsMethod,
                                                                      path: String,
                                                                      input: APIInput,
                                                                      callback: @escaping GenericAPICallback<RESULT, ERROR>) ->APIRequest {
        return request( method: .POST,
                        serverURL: SERVER_API(),
                        path: path,
                        input: input,
                        callback: callback);
        
    }
    
    func requestFileServer<RESULT : BaseDto, ERROR: APIErrorDescrible>(method: ParamsMethod,
                                                                       path: String,
                                                                       input: APIInput,
                                                                       callback: @escaping GenericAPICallback<RESULT, ERROR>) ->APIRequest {
        return request( method: .POST,
                        serverURL: SERVER_FILE(),
                        path: path,
                        input: input,
                        callback: callback);
        
    }
}

fileprivate extension APIService{
    
    func handleResponse<RESULT:BaseDto, ERROR: APIErrorDescrible>(dataResponse: DataResponse<Any>, object: Any) -> APIOutput<RESULT, ERROR> {
        
        if let err = ERROR.instance(forAlamofireDataResponse: dataResponse) {
            return .error(err);
            
        } else {
            if let dic = object as? [String:Any] {
                let success = dic["success"] as? Bool
                if success == true {
                    let results = dic["results"]
                    var dic:ResponseDictionary = [:]

                    if results != nil {
                        if let object = results as? ResponseArray{
                            dic = ["list": object]
                        }else {
                            dic = results as! ResponseDictionary
                        }
                    }else {
                        dic = [:]
                    }
                    let obj = RESULT(JSON: dic)!
                    return .object(obj);

                }
            }
            
            return .error(.instanceForInvalidResponse());
        }
    }
    
    func handleFailure<RESULT : BaseDto, ERROR: APIErrorDescrible>(dataResponse: DataResponse<Any>, error: Error) -> APIOutput<RESULT, ERROR>  {
        if let err = ERROR.instance(forAlamofireDataResponse: dataResponse) {
            return .error(err);
            
        } else if let afErr = error as? AFError {
            switch afErr {
            case .responseSerializationFailed(reason: .inputDataNil),
                 .responseSerializationFailed(reason: .inputDataNilOrZeroLength),
                 .responseSerializationFailed(reason: .inputFileNil):
                let obj:RESULT =  RESULT(JSON: [:])!
                return .object(obj);
   
            default:
                break;
            }
        }
        
        return .error( .instanceForInvalidResponse() );
    }
    
    func preparePath(_ path: String, with query: [String: String]) -> String {
        
        if var components = URLComponents(string: path),
            query.count > 0{
            
            var arrQueries:[URLQueryItem] = components.queryItems ?? [];
            for (key, val) in query {
                let query = URLQueryItem(name: key, value: val);
                arrQueries.append(query);
            }
            components.queryItems = arrQueries;
            
            if let newUrl = components.url {
                return newUrl.absoluteString;
            }
        }
        
        return path;
    }
}

//MARK: - Encoding

extension APIService {
    
    struct APIEncoding: ParameterEncoding {
        
        let bodyStringValue: String?;
        let bodyDataValue: Data?;
        
        init(_ theInput: APIInput, method: ParamsMethod) {
            
            func parseJson(_ rawObject: Any) -> (data: Data, string: String)? {
                
                guard let jsonData = (try? JSONSerialization.data(withJSONObject: rawObject, options: .init(rawValue: 0))) else {
                    print("Couldn't parse [\(rawObject)] to JSON");
                    return nil;
                }
                
                let jsonString = String(data: jsonData, encoding: .utf8)!;
                return (data: jsonData, string: jsonString);
            }
        
            switch theInput {
            case .empty:
                bodyStringValue = nil;
                bodyDataValue = nil;
                
            case .dto(let info):
                let params = info.getJsonObject(method: method)
                let jsonValues = parseJson(params);
                bodyStringValue = jsonValues?.string;
                bodyDataValue = jsonValues?.data;
                
            case .json(let jsonObject):
                let jsonValues = parseJson(jsonObject);
                bodyStringValue = jsonValues?.string;
                bodyDataValue = jsonValues?.data;
                
            case .str(let string, let inString):
                let sideString = inString ?? "";
                bodyStringValue = "\(sideString)\(string)\(sideString)";
                bodyDataValue = bodyStringValue?.data(using: .utf8, allowLossyConversion: true);
                
            case .data(let data):
                bodyStringValue = String.init(data: data, encoding: .utf8);
                bodyDataValue = data;
                
            }
            
        }
        
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var request = try urlRequest.asURLRequest();
            request.httpBody = bodyDataValue;
            return request;
        }
    }
}

//MARK: - API Request

class APIRequest {
    
    private var alarmofireDataRequest: DataRequest? = nil;
    
    required init(alarmofireDataRequest request: DataRequest){
        alarmofireDataRequest = request;
    }
    
    func cancel() {
        if let request = alarmofireDataRequest {
            request.cancel();
        }
    }
    
}
