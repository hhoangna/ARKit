//
//  ResgisterVC.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/4/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

class ResgisterVC: BaseVC {
    
    @IBOutlet fileprivate weak var tfUsername: UITextField!
    @IBOutlet fileprivate weak var tfEmail: UITextField!
    @IBOutlet fileprivate weak var tfPassword: UITextField!
    @IBOutlet fileprivate weak var tfRePassword: UITextField!
    @IBOutlet fileprivate weak var viewResgister: UIView?
    @IBOutlet fileprivate weak var btnResgister: UIButton?
    
    
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


    override func viewDidLoad() {
        super.viewDidLoad()

       initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

extension ResgisterVC:UITextFieldDelegate {
    
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
extension ResgisterVC {
    @IBAction func onbtnClickRegister(btn:UIButton) {
        register = RegisterDto(tfUsername.text, tfEmail.text, tfPassword.text)
        
        ///s
    }
    
    @IBAction func onbtnClickSignIn(btn:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
