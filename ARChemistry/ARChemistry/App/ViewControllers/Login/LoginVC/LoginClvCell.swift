//
//  LoginClvCell.swift
//  ARChemistry
//
//  Created by HHumorous on 7/18/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import TransitionButton

class LoginClvCell: BaseClvCell {
    
    @IBOutlet fileprivate weak var tfUsername: UITextField?
    @IBOutlet fileprivate weak var tfPassword: UITextField?
    @IBOutlet fileprivate weak var viewLogin: UIView?
    @IBOutlet fileprivate weak var btnLogin: TransitionButton!
    @IBOutlet fileprivate weak var btnFacebook: HButton?
    @IBOutlet fileprivate weak var btnGoogle: HButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func draw(_ rect: CGRect) {
        
        btnLogin.applyGradient(withColours: [AppColor.purpleColor, AppColor.mainColor, AppColor.white], gradientOrientation: .horizontal)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != self.tfUsername {
                self.tfUsername?.resignFirstResponder()
            }
            
            if touch.view != self.tfPassword {
                self.tfPassword?.resignFirstResponder()
            }
        }
    }
    
    @IBAction func onbtnClickLogin(button:TransitionButton) {
        
        button.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(2)
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                button.stopAnimation(animationStyle: .normal, completion: {
                    App().loginSuccess()
                })
            })
        })
    }
    
    func dismissKeyboard() {
        tfPassword?.resignFirstResponder()
        tfUsername?.resignFirstResponder()
    }
}
