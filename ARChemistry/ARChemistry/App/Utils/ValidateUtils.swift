
import Foundation

protocol ValidateUtils_ {
 
    static func validateEmail(_ email: String) -> Bool;
}


class ValidateUtils : ValidateUtils_ {
    
    
    static func validateEmail(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%'+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}";
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx);
        return predicate.evaluate(with: email);
    }
    
}
