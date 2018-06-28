
import Foundation
import Alamofire;

enum APIError: APIErrorDescrible {
    
    case networkError(URLError);
    case invalidResponse
    case unauthenticated
    case serverErrorMessage(String)
    case tokenFail
    case serverError;
    
    static func instance(forAlamofireDataResponse dataResponse: DataResponse<Any>) -> APIError? {
        
        let code = statusCode(in: dataResponse)
        let message = errorMessage(for: dataResponse)
        
        if let code = code {
            
            switch code {
            case .invalidInput:
                return .serverErrorMessage(message ?? unknownMessage())
            
            case .notAuthorized:
                return .unauthenticated;
            
            case .serverError:
                if let theMessage = message {
                    return .serverErrorMessage(theMessage);
                }else{
                    return .serverError;
                }
            
            case .success:
                if let message = message {
                    return .serverErrorMessage(message)
                } else {
                    return nil
                }
            case .tokenFail:
                App().onReLogin()
                return .tokenFail
            }
        
        } else {
            
            guard let networkError = dataResponse.error as? URLError else {
                return .invalidResponse
            }
            
            return .networkError(networkError);
        }
        
    }
    
    static func instanceForInvalidResponse() -> APIError {
        return .invalidResponse;
    }

    func getMessage() -> String {
        
        switch(self) {
        case .networkError(let error):
            return APIError.message(forNetworkError: error)
            
        case .invalidResponse:
            return MessageKeys.APIs.APIErrors.APIError.invalidResponse
            
        case .unauthenticated:
            return MessageKeys.APIs.APIErrors.APIError.unauthenticated
            
        case .serverErrorMessage(let message):
            return message
            
        case .serverError:
            return APIError.unknownMessage()
        case .tokenFail:
            return   MessageKeys.APIs.APIErrors.APIError.tokenFail
        }
    }
}

fileprivate extension APIError {
    
    static func statusCode(in dataResponse: DataResponse<Any>) -> APIService.StatusCode? {
        guard let statusCode = dataResponse.response?.statusCode else {
            return nil
        }
        
        return APIService.StatusCode(rawValue: statusCode)
    }
    
    static func errorMessage(for dataResponse: DataResponse<Any>) -> String? {
        guard let object = dataResponse.value as? ResponseDictionary else {
            return nil
        }
        
        var message = object["ErrorMessage"] as? String
        
        if message == nil {
            message = object["message"] as? String
        }
        
        return message
    }
}

extension APIError {
    /*
    func toNetworkError() -> NetworkError {
        
        switch self {
        case .networkError(let error):
            if error.code == .notConnectedToInternet {
                return .noNetworkConnection;
            }else if error.code == .timedOut {
                return .requestTimedOut;
            }else{
                return .invalidResponse;
            }
            
        case .invalidResponse:
            return .invalidResponse
            
        case .unauthenticated:
            return .userNotAuthenticated
            
        case .serverErrorMessage(let message):
            return .generalServerError(message: message)
            
        case .serverError:
            return .serverError;
        }
        
    }*/
}
 
