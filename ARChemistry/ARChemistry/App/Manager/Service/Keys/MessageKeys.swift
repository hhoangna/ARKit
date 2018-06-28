

import Foundation
struct MessageKeys {
    
    struct Register {
        static let invalidEmail                   = "Invalid Email"
        static let invalidVerifyEmail             = "Emails do not match"
        static let invalidPhoneNumber             = "Invalid Phone Number"
        static let invalidAltPhoneNumber          = "Invalid Alt Phone Number"
        static let lengthPassword                 = "Password must be at least 8 characters"
        static let requimentPassword              = "Passwords must include at least one letter and one number "
        static let invalidConfirmPassword         = "Passwords do not match"
        static let titlePrivacyPolicy             = "Privacy Policy"
        static let titleTermsofUse                = "Terms of Use"
        static let btnShowPriacyPolicy            = "Privacy Policy"
        static let btnShowTermsAndConditions      = "Terms of Use"
        static let text                           = "We see cookies in your future"
        static let btnCreateProfile               = "Create Profile"
    }
    
    
    struct ForgotPassword {
        static let emptyEmail                     = "Email cannot be empty."
        static let invalidEmail                   = "Invalid Email"
        static let text                           = "Reset password"
    }
    
    
    struct ResetPassword {
        static let lengthPassword                 = "Password must be at least 8 characters"
        static let requimentPassword              = "Passwords must include at least one letter and one number "
        static let invalidConfirmPassword         = "Passwords do not match"
        static let emptyPassword                  = " Password cannot be empty "
        static let emptyComfirmPassword           = "Confirm Password cannot be empty"
        static let title                          = "Reset Password"
    }
    
    
    struct PersonalInfoEdit {
        static let emptyPhoneNumber               = "Phone Number cannot be empty"
        static let invalidPhoneNumber             = "Invalid Phone Number"
        static let emptyFirstName                 = "First Name cannot be empty"
        static let emptyLastName                  = "Last Name cannot be empty"
        static let invalidAltPhoneNumber          = "Invalid Alt Phone Number"
    }
    
    
    struct CorporateAccountEditor {
        static let emptyCardNumber                = "Card Number can't be empty."
        static let requimentCardNumber            = "There is a 3 character mininmum and 30 character max."
        static let emptyBillingPostalCode         = "Billing Zip/ Postal Code can't be empty."
        static let requimentBillingPostalCode     = "There is a 5 character mininmum and 30 character max."
        static let title                          = "Add Corporate Account"
    }
    
    
    struct CreditCardEditor {
        static let emptyCardNumber                = "Card Number can't be empty."
        static let emptyExpDate                   = "Expiration Date can't be empty."
        static let expDate                        = "Invalid Expiration Date"
        static let invalidExpDate                 = "Invalid Date."
        static let emptySecCode                   = "Sec. Code can't be empty."
        static let emptyBillingPostalCode         = "Billing Zip/ Postal Code can't be empty."
        static let requimentBillingPostalCodeNew  = "Billing Zip/ Postal Code must be five characters."
        static let title                          = "Add Credit Card"
    }
    
    
    struct Placehoder {
        static let verifyEmail                    = "Verify Email Address*"
        static let confirmPassword                = "Confirm Password*"
        static let newPassword                    = "New Password*"
        static let comfirmNewPassword             = "Confirm New Password*"
        static let cardAccountNumber              = "Corporate Account Number*"
        static let billingPostalCode              = "Billing Zip / Postal Code*"
        static let cardNumber                     = "Card Number*"
        static let expDate                        = "MM/YY*"
        static let expDateAlterForEditing         = "Exp Date MM/YY*"
        static let secCode                        = "Sec.Code*"
        static let giftCart                       = "Gift Card Number*"
        static let cVV                            = "CVV"
        
        
        struct FormTextFieldType {
            static let firstName                  = "First Name*"
            static let lastName                   = "Last Name*"
            static let phoneNumber                = "Phone #*"
            static let altPhoneNumber             = "Alt Phone #"
            static let apartmentNumber            = "Apt, Unit #"
            static let gateCode                   = "Gate Code"
            static let company                    = "Company"
            static let email                      = "Email*"
            static let password                   = "Password*"
            static let expiredDate                = "Exp Date MM/YY*"
        }
        
    }
    
    
    struct Alert {
        static let errFindStoreAndCity            = "Cannot find the Store and City."
        static let errAddress                     = "The address is no longer valid. Please select another address."
        static let errRemoveCreditCard            = "Remove credit card failed."
        static let errCreditCard                  = "Credit card has expired."
        static let errDeleteAddress               = "Delete address failed."
        static let errInvalidCard                 = "Invalid Card Information."
        static let errAddingCredit                = "Adding Credit Card failed."
        static let errResetPassword               = "Reset password failed."
        static let errDelete                      = "Delete Failed."
        static let errAddressInvalidate           = "The Address is invalid"
        static let errStore                       = "No stores fall within that 50 mile radius."
        static let showLogoutConfirmation         = "Are you sure you want to log out?"
        static let showAlertConfirmationCreatProfile = "Your GrabWork profile is shared across our mobile app and our online ordering site. If you already have an online ordering profile with us, simply log in with your credentials to access your account. Would you like to continue to create a new GrabWork profile?"
        static let showCannotTrackOrder           = "Order tracking is not available for this order."
        static let showAccessDeniedLocationAlertTile     = "Allow GrabWork access to your location in Settings"
        static let showAccessDeniedLocationMessage   = "Location will be used to map your location to get workings near you"
        static let notifiedNewVersion             = "In order to continue using the app, please update the app by tapping below"
        static let restartOrderMessage            = "You have an order in progress already. Do you want to clear this order and start a new one?"
        static let resetPassword                  = "An email has been sent to your address. In order to reset your password, please go to your email to complete reset password."
        
        static func deleteCreditCard(_ cardNumberLastFourDigits: String)-> String{
            return "Are you sure want to remove credit card '\(cardNumberLastFourDigits)'from profile?"
        }
        static func deleteCorporateAccount(_ accountNum: String)-> String{
            return "Are you sure want to delete corporate account '\(accountNum)'from profile?"
        }
        static func tipAmount(_ accountNum: Decimal)-> String{
            return "The tip amount cannot be greater than $\(accountNum)."
        }
        static func showDeleteConfirmationCreditCard(_ cardNumberLastFourDigits: String)->String{
            return "Remove Credit Card #\(cardNumberLastFourDigits) from payment options?"
        }
        static func showDeleteConfirmationCorporateAccount(_ accountNumber: String)->String{
            return "Remove Corporate Account #\(accountNumber) from payment options?"
        }
        static func showDeleteConfirmationGiftCard(_ cardNumber: String)->String{
            return "Remove Gift Card #\(cardNumber)?"
        }
        static let showConfirmationTime           = "There are no available times for the selected date. Please choose another date."
        
        struct ButtonAlert {
            static let settingsAction             = "Settings"
            static let cancelAction               = "Not Now"
            static let viewAction                 = "View"
            static let onDismiss                  = "Dismiss"
            static let appUpdate                  = "App Update"
            static let okString                   = "OK"
            static let cancelString               = "Cancel"
            static let yesString                  = "Yes"
            static let yesStartOverString         = "Yes, Start Over"
            static let noKeepGoingString          = "No, Keep Going"
            static let continueString             = "Continue"
            
        }
        
    }
    
    struct Button {
        static let done                           = "Done"
    }
    
    struct AddressLabel {
        static let myHome                         = "My Home"
        static let myWork                         = "My Work"
        static let home                           = "Home"
        static let work                           = "Work"
        
    }
    
    struct Message {
        static let messageDate                    = "There are no available times for the date selected."
        
    }
    struct CartItem {
        static let formatStringBrownies           = "%.0fx %@"
        static let formatStringDozenCookies       = "%.1f %@"
    }
    
    
    struct DriverTrackingStorageService {
        static let missingProfile                 = "There is no Profile.  Did you log in?"
        static let missingFirebaseInstanceIDToken = "There is no Firebase Instance ID Token.  Have you authorized with the Firebase server?"
        static let alreadyObservingOrder          = "Only one order can be observed at a time!"
        static let unexpectedEventValue           = "The value for the change event was unexpected."
        
        static func permissionDenied(error: Error) -> String{
            return "Permission Denied: \(error)"
        }
        
        static let unknownError                   = "An unknown error occurred."
    }
    
    struct CartFactory {
        static let titleInstructionsScreen        = "ENTER SPECIAL INSTRUCTIONS:"
        static let titleGiftMessageScreen         = "GIFT MESSAGE:"
        static let subTitleText                   = "Don't forget to sign your name to your message - otherwise, your name will not appear."
        static let defaultTitle                   = "Edit My Order"
        
    }
    
    struct ProductCatalogFactory {
        static let titleInstructionsScreen        = "ENTER SPECIAL INSTRUCTIONS:"
    }
    
    struct PreviousOrdersCoordinator {
        static let titleOrderHistory              = "Order History"
        static let titleTrackOrders               = "Track Orders"
        
    }
    
    struct ButtonOrderCell {
        static let btnRepeatOrder                 = "Repeat Order"
        static let btnNewRecipientOrder           = "New Recipient"
        
    }
    
    struct OrderDetailsVC {
        static let volumeDiscount                 = "Volume Discount"
        static let coupon                         = "Coupon"
        static let subTotal                       = "Sub-Total"
        static let taxAmount                      = "Sales Tax"
        static let totalAmount                    = "Total"
        static let amountPaid                     = "Amount Paid"
        static let invalidDate                    = "Invalid-Date"
        
        static func displayTime(_ completedTime: String)-> String{
            return "Left Store At: \(completedTime))"
        }
        static func displayOrder(_ orderId: Int)-> String{
            return "ORDER #\(orderId)"
        }
        
    }
    
    struct PlaceOrderConfirmed  {
        static let header                         = "Order Confirmed"
        
        static func oderId(orderId: String)-> String{
            return  "ORDER #\( orderId )"
        }
        
        static let labelTypeOrderPickUp           = "PICK UP:"
        static let labelTypeOrderDelivery         = "DELIVERY TO:"
        static let noDate                         = "No Date"
        static let noHours                        = "No Hours"
        static let InvalidDate                    = "Invalid date data."
    }
    
    struct MyPaymentsVC {
        static let title = "My Payments"
        
        
        
    }
    
    struct GiftAddressDetailsVC {
        static let title                            = "Address Details"
        static let header                           = "Confirm Address"
        static let buttonContinue                   = "Continue"
        
        static func labelApt(_ apartmentNumber: String)->String{
            return "Apt \(apartmentNumber)"
        }
        static func labelGateCode(_ gateCode: String)->String{
            return "Gate Code \(gateCode)"
        }
        static func labelCompanyName(_ company : String)->String{
            return "Company: \(company)"
        }
        static func alert(_ name: String,_ addressType: String,_ addressString: String)->String{
            return  "Remove \(name) \(addressType) address \(addressString) from Gift Addresses?"
        }
        
    }
    
    struct MyAddressDetails {
        static let title                            = "Address Details"
        static let header                           = "Confirm Address"
        static let buttonContinue                   = "Continue"
        
        static func labelApt(_ apartmentNumber: String)->String{
            return "Apt \(apartmentNumber)"
        }
        static func labelGateCode(_ gateCode: String)->String{
            return "Gate Code \(gateCode)"
        }
        static func labelCompanyName(_ company : String)->String{
            return "Company: \(company)"
        }
        static func alert(_ name: String,_ addressType: String,_ addressString: String)->String{
            return  "Remove \(name) \(addressType) address \(addressString) from Gift Addresses?"
        }
        
    }
    
    struct ProfileVC {
        static let title                            = "My Profile"
        static let toMe                             = "To Me"
        static let toSomeoneElse                    = "To Someone Else"
        static let btnAddCreditCard                 = " Add Credit Card"
        static let lblTitleHome                     = "Home"
        static let lblSubTitle                      = "Tap To Add"
        static let lblTitleWork                     = "Work"
        static let btnAddAddress                    = " Add New Address"
        static let titleTermsofUse                  = "Terms of Use"
        static let titlePrivacyPolicy               = "Privacy Policy"
        static let actionCancel                     = "Cancel"
        
        struct PersonalInfoEditVC {
            static let title = "Edit Personal Info"
        }
        
    }
    
    struct AddressEntryType {
        static let toMe                             = "To Me"
        static let toSomeoneElse                    = "To Someone Else"
        static let home                             = "My Home Address"
        static let work                             = "My Work Address"
    }
    
    struct CouponViewController {
        static let headerLabel                      = "Add Coupon"
        static let text                             = "Coupon Code*"
        
    }
    
    struct UnitOfMeasure {
        static let dozen                            = "doz"
        static let each                             = "ea"
        
    }
    
    struct AddressForm {
        static let actionButtonTitleSave            = "Save"
        static let actionButtonTitleContinue        = "Continue"
        static let actionButtonTwoTitle             = "Select Different Address"
        static let navigationBarTitleAdd            = "Add New Address"
        static let navigationBarTitleEdit           = "Edit Address Details"
        
        struct DeliveryInstructionField {
            static let setUpTitleLabel              = "Delivery Instructions:"
        }
        
        struct AddressFormContentView {
            static let placeholderAddressLabel      = "Delivery Address*"
            static let deliveryTypeRadioButtonView  = "Type of Delivery:*"
            static let addressLabelRadioButtonView  = "Save Address As:"
            static let deliveryInstructionsLabel    = "i.e. Use side door, etc."
        }
        
    }
    
    struct AddressSearch {
        static let header                           = "My Address Book"
        static let placeholder                      = "Search My Addresses"
        
    }
    
    struct AddressSuggestion {
        static let networkError                     = "Please connect to the internet and try again."
        static let streetAddressNotFound            = "No street address found for suggestion"
        static let missingId                        = "A GooglePlaceAddressSuggestion must have an id in order to look up the street address"
        
        struct AddressSuggestionViewController {
            static let placeholder                  = "Enter Delivery Address"
        }
        
    }
   
    
    struct DriverTracking {
        
        struct DriverTrackingPresenter {
            static let singleMinute                 = "Treats arriving in about 1 minute"
            static let pluralMinutes                = "Your order will arrive in about %d minutes"
            static let stringDisplayed              = "Your order has arrived!"
        }
        
    }
    
    struct GiftRecipient {
        
        struct GiftRecipientContentView {
            static let useNewAddress                = "Use New Address"
            static let searchMyAddresses            = "Search My Addresses"
            static let header                       = "To Someone Else"
            
        }
        
        struct GiftRecipientViewController {
            static let header                       = "Where To?"
            
        }
        
    }
    
    struct LandingPage {
        
        struct LandingPageViewController {
            static let headerView                   = "Cookie Delivery"
            static let signInButton                 = "Sign In"
            static let createProfileButton          = "Create Profile"
            
        }
        
    }
    
    struct Login {
        
        struct LoginViewController {
            static let signInButton                  = "Sign In"
            static let forgotPasswordButton          = "Forgot Password"
            static let headerView                    = "You're Getting Warmer"
        }
        static let invalidUsernameAndPassword    = "Incorrect email or password";
    }
    
    struct Menu {
        
        struct MenuItemType {
            static let startOrder                    = "Start Order"
            static let trackOrders                   = "Track Order"
            static let orderHistory                  = "Order History"
            static let logOut                        = "Log Out"
            static let catalog                       = "Catalog"
            static let profile                       = "Profile"
            
        }
        
        struct SideMenuViewController {
            static let headerView                    = "View Profile"
            
        }
        
    }
    
    struct OrderFlow {
        
        struct OrderType {
            static let pickup                        = "Select Pick Up Date"
            static let delivery                      = "Select Delivery Date"
            static let pickupTime                    = "Select Pick Up Time"
            static let deliveryTime                  = "Select Delivery Time"
        }
        
    }
    struct PickUpCity {
        struct PickUpCityViewController {
            static let headerText                    = "Select City for Pick Up"
        }
        
    }
    struct PickUpStore {
        
        struct PickUpStoreLocation {
            
            struct PickUpStoreLocationVC {
                static let titleToNavigationBar      = "Stores Near You"
            }
            
        }
        struct PickUpStoreViewController {
            static let headerText                    = "Select Store for Pick Up"
            
        }
        
    }
    
    struct PrePlace {
        
        struct PrePlacePresenter {
            static let contentForDelivery            = "Delivery Info"
            static let contentForPickUp              = "Pick Up Info"
            static let locationLine1                 = "Tiff's Treats"
            static let giftCart                      = "GIFT CARD"
            static let giftCarts                     = "GIFT CARDS"
            
            static func giftCart(_ accountPaymentDisplayText: String)-> String{
                return "GIFT CARD/\(accountPaymentDisplayText)"
            }
            static func giftCarts(_ accountPaymentDisplayText: String)-> String{
                return "GIFT CARDS/\(accountPaymentDisplayText)"
            }
            
            static let textViewTitle                 = "INVOICE NOTES"
            static let textViewController            = "Add notes here to appear on the invoice associated with this order, such as a PO Number."
        }
        
        struct PrePlaceSectionFooterCollectionReusableView {
            static let placeOrderButton              = "Place My Order"
            static let specialOffersRadioButtonView  = "Email news / special offers"
            
        }
        
        struct PrePlaceCollectionViewController {
            static let titleToNavigationBar          = "Checkout"
            static let specialOffersRadioButtonView  = "Email news / special offers"
            
        }
        
        struct PrePlaceCollectionViewCell {
            static let titleLabelPayment             = "PAYMENT"
        }
        
    }
    
    struct Product {
        
        struct ProductPresenter {
            static let showSpecialInstructions       = "Some instructions may lead to an incidental upcharge (for example: cutting brownies in half). You will be notified by phone if this is the case."
        }
        
        struct ProductStyle {
            static let price                         = "%@/%@"
            static let limitedTimeMessage            = "%@ - %@"
            static let specialsLimitedTimeMessage    = "Limited Time! | %@ - %@"
            static let limitedTimePopUpMessage       = "Order date must be between %@ - %@ to add this item to your cart."
            
        }
        
        struct ProductCollectionViewCell {
            static let limitedTimeTitleLabel            = "Limited\nTime!"
            static let limitedTimeModalTileButtonTitle  = "Got It"
            static let specialMessageLabel              = "Edit or remove in cart only"
            static let soldOutLabel                     = "Sold Out"
        }
        
        struct SpecialInstructionsView {
            static let titleLabel                       = "SPECIAL INSTRUCTIONS:"
            static let instructionTextLabel             = "Start writing here (optional)..."
        }
    }
    
    struct SpecialBuilder {
        
        struct SpecialBuilderPresenter {
            static let specialSpecialInstructions       = "Some instructions may lead to an incidental upcharge (for example: cutting brownies in half). You will be notified by phone if this is the case."
            static let addToCartString                  = "Add To Cart"
            
        }
    }
 
    
    struct StyleNavigation {
        static let titleToNavigationBar                 = "Menu"
        
    }
    
    
    struct APIs {
        
        struct APIErrors {
            
            struct APIError {
                static let invalidResponse              = "The server returned an invalid response."
                static let unauthenticated              = "You are no longer logged in."
                static let tokenFail                    = "Token fail."

            }
            
            struct BaseAPIError {
                static let networkError                 = "Please connect to the internet and try again."
                static let unknownMessage               = "An unknown error occurred."
                
            }
        }
    }
    
    struct StartOrder {
        
        struct StartOrderFactory {
            static let instructionsScreen               = "Delivery Instructions"
            
        }
        
    }
    
    struct OrderHistoryVC {
        static let title                                = "Order History"
        static let invalidDate                          = "Invalid-Date"
        
    }
    
    struct OrderTrackingVC {
        static let title                                = "Track Order"
        static let invalidDate                          = "Invalid-Date"
        
        static func displayTime(_ completedTime: String)-> String{
            return "Left Store At: \(completedTime))"
        }
        static func displayArriveTime(_ etaInt: Int)-> String{
            return "Your order will arrive in about \(etaInt) minutes "
        }
        
        static let typeOrderTrack                       = "TRACK NOW"
        static let typeOrderDirection                   = "DIRECTION"
        static let arrived                              = "Your treats have arrived."
    }
}
