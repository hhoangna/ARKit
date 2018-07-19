//
//  LoginVC.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/3/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {
    
    @IBOutlet fileprivate weak var tfUsername: UITextField?
    @IBOutlet fileprivate weak var tfPassword: UITextField?
    @IBOutlet fileprivate weak var viewLogin: UIView?
    @IBOutlet fileprivate weak var btnLogin: UIButton?

    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addDismissKeyboardDetector()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeDismissKeyboardDetector()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK: - UIAction
extension LoginVC {
    @IBAction func onbtnClickLogin(btn:UIButton) {
        App().loginSuccess()
    }
    
    @IBAction func onbtnClickSignIn(btn:UIButton) {
        let vc:ResgisterVC = .load(SB: .Login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


