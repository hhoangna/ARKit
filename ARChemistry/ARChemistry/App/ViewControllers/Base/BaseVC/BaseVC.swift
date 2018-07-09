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
    
    fileprivate lazy var backBarItem : UIBarButtonItem = UIBarButtonItem.back(target: self, action: #selector(onNavigationBack(_:)))
    fileprivate lazy var menuBarItem : UIBarButtonItem = UIBarButtonItem.menu(target: self, action: #selector(onNavigationMenu(_:)))
    fileprivate lazy var saveBarItem : UIBarButtonItem = UIBarButtonItem.SaveButton(target: self, action: #selector(onNavigationSaveDone(_:)))
    fileprivate lazy var doneBarItem : UIBarButtonItem = UIBarButtonItem.doneButton(target: self, action: #selector(onNavigationSaveDone(_:)))
    fileprivate lazy var cancelBarItem : UIBarButtonItem = UIBarButtonItem.cancelButton(target: self, action: #selector(onNavigationBack(_:)))
    
    
    
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


// MARK: - Navigation
extension BaseVC {
    func updateNavigationBar(_ barStyle:BarStyle, _ title:String?) {
        
        if let title = title {
            self.addTitleToNavigationBar(title: title)
        }
        switch barStyle {
        case .Menu:
            self.navigationItem.leftBarButtonItem = menuBarItem
            break;
        case .BackOnly:
            self.navigationItem.leftBarButtonItem = backBarItem
            break;
        case .BackDone:
            self.navigationItem.leftBarButtonItem = backBarItem
            self.navigationItem.rightBarButtonItem = doneBarItem
            break;
        case .CancelSave:
            self.navigationItem.leftBarButtonItem = cancelBarItem
            self.navigationItem.rightBarButtonItem = saveBarItem
            
            break;
        case .CanCelDone:
            break;
        }
    }
    
    @objc func onNavigationBack(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        if let navi = self.navigationController {
            
            if (navi.viewControllers.count <= 1) {
                if (navi.presentingViewController != nil) {
                    navi.dismiss(animated: true, completion: nil)
                }
            }else {
                navi.popViewController(animated: true);
            }
            
        }else {
            if (self.presentingViewController != nil) {
                self.dismiss(animated: true, completion: nil);
            }
        }
    }
    
    @objc func onNavigationMenu(_ sender: UIBarButtonItem) {
        App().mainVC?.showSlideMenu(isShow: true, animation: true)
    }
    
    @objc func onNavigationSaveDone(_ sender: UIBarButtonItem) {
    }
    
}

