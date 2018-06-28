
import Foundation
import Alamofire;


protocol APIErrorDescrible: Error {
    static func instance(forAlamofireDataResponse dataResponse: Alamofire.DataResponse<Any>) -> Self?;
    static func instanceForInvalidResponse() -> Self;
    func getMessage() -> String
}

extension APIErrorDescrible{
    
    static func message(forNetworkError networkError: URLError) -> String {
        if networkError.code == .notConnectedToInternet {
            return MessageKeys.APIs.APIErrors.BaseAPIError.networkError;
        } else {
            return unknownMessage();
        }
    }
    
    static func unknownMessage() -> String {
        return MessageKeys.APIs.APIErrors.BaseAPIError.unknownMessage
    }
}

class APIErrorDescribledInstance: APIErrorDescrible {
    let message: String;
    
    init(_ message: String) {
        self.message = message;
    }
    
    func getMessage() -> String {
        return message;
    }
    
    static func instance(forAlamofireDataResponse dataResponse: DataResponse<Any>) -> Self? {
        fatalError("Wrong calling")
    }
    
    static func instanceForInvalidResponse() -> Self {
        fatalError("Wrong calling")
    }
}
