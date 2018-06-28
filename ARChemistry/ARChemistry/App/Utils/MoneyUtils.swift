
import Foundation

enum Currency {
    case USDollars;
    case VND;

    
    func info() -> (locale: NSLocale, name: String, sign: String, fractionDirgits: Int16) {
        switch self {
        case .USDollars:
            return (NSLocale(localeIdentifier: "en_US") ,"USD", "$", 2);
        case .VND:
            return (NSLocale(localeIdentifier: "vi_VN"), "VND", "đ", 2);
        }
    }
}

class MoneyUtils {
    
    let currencyName: String;
    let currencySign: String;
    let fractionDigits: Int16;
    let roundingBehaviors: NSDecimalNumberBehaviors;
    let numberFormatter: NumberFormatter
    let numberWithSignFormatter: NumberFormatter

    static let USDollars = MoneyUtils(currency: .USDollars);
    static let VND = MoneyUtils(currency: .VND);

    
    init(currency: Currency) {
        let info = currency.info();
        currencyName = info.name;
        currencySign = info.sign;
        fractionDigits = info.fractionDirgits;
        
        roundingBehaviors = NSDecimalNumberHandler(roundingMode: .bankers,
                                                   scale: info.fractionDirgits,
                                                   raiseOnExactness: false,
                                                   raiseOnOverflow: false,
                                                   raiseOnUnderflow: false,
                                                   raiseOnDivideByZero: false);
        
        numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency;
        numberFormatter.generatesDecimalNumbers = true;
        numberFormatter.minimumFractionDigits = Int(fractionDigits);
        numberFormatter.maximumFractionDigits = Int(fractionDigits);
        
        numberWithSignFormatter = numberFormatter.copy() as! NumberFormatter
        //numberWithSignFormatter.currencyCode  = currencySign
        numberWithSignFormatter.locale = info.locale as Locale?
    }
    
    func round(_ amount: Decimal) -> Decimal {
        let amountNumber = NSDecimalNumber(decimal: amount)
        let roundedAmountNumber = amountNumber.rounding(accordingToBehavior: roundingBehaviors)
        return  roundedAmountNumber.decimalValue
    }
    
    func format(justNumber amount: NSNumber) -> String {
        numberFormatter.currencySymbol  = ""
        return numberFormatter.string(from: amount) ?? "";
    }
    
    func format(withSign amount: NSNumber) -> String {
        return numberWithSignFormatter.string(from: amount) ?? ""
    }

}
