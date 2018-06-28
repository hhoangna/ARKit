//
//  BaseVC.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/3/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    fileprivate var gesDismissKeyboardDetector : UITapGestureRecognizer? = nil;
    fileprivate var obsKeyboardChangeFrame: NSObjectProtocol? = nil;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    deinit {
        print("> DEINIT [\(ClassName(self))]")
        unregisterForKeyboardNotifications();
        removeDismissKeyboardDetector();
    }
    
}


// MARK: - Keyboard
extension BaseVC {
    final func registerForKeyboardNotifications() {
        
        guard obsKeyboardChangeFrame == nil else {
            return;
        }
        
        obsKeyboardChangeFrame =
            NotificationCenter.default.addObserver(forName: .UIKeyboardWillChangeFrame,
                                                   object: nil,
                                                   queue: OperationQueue.main,
                                                   using: keyboardWillChangeFrame(noti:))
    }
    
    final func unregisterForKeyboardNotifications() {
        
        guard let obs = obsKeyboardChangeFrame else {
            return;
        }
        
        obsKeyboardChangeFrame = nil;
        NotificationCenter.default.removeObserver(obs);
    }
    
    final func addDismissKeyboardDetector() {
        
        guard gesDismissKeyboardDetector == nil else {
            return;
        }
        
        gesDismissKeyboardDetector = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(tapGesture:)));
        
        self.view.addGestureRecognizer(gesDismissKeyboardDetector!);
    }
    
    final func removeDismissKeyboardDetector() {
        
        guard let ges = gesDismissKeyboardDetector else {
            return;
        }
        
        gesDismissKeyboardDetector = nil;
        self.view.removeGestureRecognizer(ges);
        
    }
    
    func keyboardWillChangeFrame(noti: Notification) {}
    
    @objc func dismissKeyboard(tapGesture: UITapGestureRecognizer?) {
        self.view.endEditing(true);
    }
    
    func getKeyboardHeight(noti:NSNotification) -> CGFloat {
        
        let userInfo:NSDictionary = noti.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        return keyboardHeight;
    }
}

