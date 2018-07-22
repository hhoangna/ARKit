//
//  RegisterClvCell.swift
//  ARChemistry
//
//  Created by HHumorous on 7/18/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterClvCell: BaseClvCell {
    @IBOutlet fileprivate weak var tfUsername: UITextField!
    @IBOutlet fileprivate weak var tfEmail: UITextField!
    @IBOutlet fileprivate weak var tfPassword: UITextField!
    @IBOutlet fileprivate weak var tfRePassword: UITextField!
    @IBOutlet fileprivate weak var viewResgister: UIView?
    @IBOutlet fileprivate weak var btnResgister: HButton?
    
    override func draw(_ rect: CGRect) {
        btnResgister?.applyGradient(withColours: [AppColor.redColor, AppColor.orangeColor, AppColor.white], gradientOrientation: .horizontal)
        btnResgister?.layer.cornerRadius = (btnResgister?.frame.size.height)!/2
    }
    
    override func awakeFromNib() {
        initUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != self.tfUsername {
                self.tfUsername?.resignFirstResponder()
            }
            
            if touch.view != self.tfEmail {
                self.tfEmail?.resignFirstResponder()
            }
            
            if touch.view != self.tfRePassword {
                self.tfRePassword?.resignFirstResponder()
            }
            
            if touch.view != self.tfPassword {
                self.tfPassword?.resignFirstResponder()
            }
        }
    }
    
    struct ValidateRegister {
        var isValidateEmail:Bool = false
        var isValidateConfirmPassword:Bool = false
        var isValidatePassword:Bool = false
        var isValidateUserName:Bool = false
    }
    
    
    var isValidateRegister:ValidateRegister = ValidateRegister()
    var isCheckEnableButtonRegister:Bool = false {
        didSet {
            checkEnableCreateProfile()
        }
    }
    var register:RegisterDto?
    
    func initUI() {
        setUpTextField()
        setUpViewResgister()
        setUpButtonResgister()
    }
    
    func setUpTextField() {
        tfPassword.delegate = self;
        tfUsername.delegate = self;
        tfEmail.delegate = self;
        tfRePassword.delegate = self;
        tfPassword.isSecureTextEntry = true;
        tfRePassword.isSecureTextEntry = true;
    }
    
    func setTextUserName(userName:String) {
        tfUsername.text = userName
    }
    
    func setTextEmail(email:String) {
        tfEmail.text = email
    }
    
    func setTextPassword(password:String) {
        tfPassword.text = password
    }
    
    func setTextRePassword(rePassword:String) {
        tfRePassword.text = rePassword
    }
    
    func setUpViewResgister() {
        viewResgister?.setRoudary(radius: 4.0);
    }
    
    func setUpButtonResgister()  {
        btnResgister?.setRoudary(radius: 4.0);
        isCheckEnableButtonRegister = false;
    }
    
    func checkEnableCreateProfile(){
        btnResgister?.isEnabled = isCheckEnableButtonRegister
        btnResgister?.alpha = isCheckEnableButtonRegister ? 1 : 0.5
    }
    
    func validateRegister()->Bool{
        var isRegister:Bool = false
        guard isValidateRegister.isValidateEmail,
            isValidateRegister.isValidatePassword,
            isValidateRegister.isValidateConfirmPassword,
            isValidateRegister.isValidateUserName,
            isValidateRegister.isValidateEmail
            else {
                return isRegister
        }
        isRegister = true
        return isRegister
    }
    
    func performLocalValidateUserName(){
        if (tfUsername.text?.isEmpty)!{
            isValidateRegister.isValidateUserName = false
        }else{
            isValidateRegister.isValidateUserName = true
        }
    }
    
    func performLocalValidateEmail(){
        
        let isEmail = ValidateUtils.validateEmail(tfEmail.text ?? "");
        if ((tfEmail.text?.isEmpty)! || isEmail == false){
            tfEmail.textColor = .red
            isValidateRegister.isValidateEmail = false
        }else{
            tfEmail.textColor = .black
            isValidateRegister.isValidateEmail = true
        }
    }
    
    
    func performLocalValidatePassword(){
        if (tfPassword.text?.isEmpty)!{
            isValidateRegister.isValidatePassword = false
        }else{
            isValidateRegister.isValidatePassword = true
        }
    }
    
    func performLocalValidateConfirmPassword(rePass:String?){
        if (rePass?.isEmpty)! ||
            rePass != tfPassword.text{
            tfRePassword.textColor = .red;
            isValidateRegister.isValidateConfirmPassword = false
        }else{
            tfRePassword.textColor = .black;
            isValidateRegister.isValidateConfirmPassword = true
        }
    }
    
}

extension RegisterClvCell:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        switch textField {
        case tfUsername:
            performLocalValidateUserName()
            break
        case tfEmail:
            performLocalValidateEmail()
            break
        case tfPassword:
            performLocalValidatePassword()
            break
        case tfRePassword:
            performLocalValidateConfirmPassword(rePass: updatedString)
            break
        default:
            print("ok")
        }
        
        isCheckEnableButtonRegister = validateRegister()
        return true
    }
}


//MARK: - Action
extension RegisterClvCell {
    @IBAction func onbtnClickRegister(btn:UIButton) {
        
        App().showHUDProgess(self)
        
        Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPassword.text!) { (user, err) in
            if err != nil {
                App().hideHUDProgess("Error", "Can't sign up", "ic_errorLogin", .customView)
                return
            }
            Auth.auth().signIn(withEmail: self.tfEmail.text!, password: self.tfPassword.text!, completion: { (user, err) in
                if err != nil {
                    App().hideHUDProgess("Error", "Can't sign up", "ic_errorLogin", .customView)
                    return
                }
                guard let uid = Auth.auth().currentUser?.uid else {
                    App().hideHUDProgess("Error", "Can't sign up", "ic_errorLogin", .customView)
                    return
                }
                let dictionaryValues = ["name": self.tfUsername.text!,
                                        "email": self.tfEmail.text!,
                                        "imageUrl": "",
                                        "gender": "",
                                        "birthday": "",
                                        "address": "",
                                        "password": self.tfPassword.text!]
                let values = [uid : dictionaryValues]
                
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if err != nil {
                        App().hideHUDProgess("Error", "Can't sign up", "ic_errorLogin", .customView)
                        return
                    }
                    print("Successfully saved user info into Firebase database")
                    // after successfull save dismiss the welcome view controller
                    App().hideHUDProgess("Success!", "", "ic_check", .customView)
                })
            })
        }
    }
}
