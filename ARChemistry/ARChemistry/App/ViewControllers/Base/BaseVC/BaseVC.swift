//
//  BaseVC.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/3/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class BaseVC: UIViewController {
    
    public var contentVC: BaseNV?
    
    fileprivate var gesDismissKeyboardDetector : UITapGestureRecognizer? = nil;
    fileprivate var obsKeyboardChangeFrame: NSObjectProtocol? = nil;
    
    fileprivate lazy var backBarItem : UIBarButtonItem = UIBarButtonItem.back(target: self, action: #selector(onNavigationBack(_:)))
    fileprivate lazy var menuBarItem : UIBarButtonItem = UIBarButtonItem.menu(target: self, action: #selector(onNavigationMenu(_:)))
    fileprivate lazy var saveBarItem : UIBarButtonItem = UIBarButtonItem.SaveButton(target: self, action: #selector(onNavigationSaveDone(_:)))
    fileprivate lazy var doneBarItem : UIBarButtonItem = UIBarButtonItem.doneButton(target: self, action: #selector(onNavigationSaveDone(_:)))
    fileprivate lazy var cancelBarItem : UIBarButtonItem = UIBarButtonItem.cancelButton(target: self, action: #selector(onNavigationBack(_:)))
    fileprivate lazy var editBarItem : UIBarButtonItem = UIBarButtonItem.editButton(target: self, action: #selector(onNavigationClickRightButton(_:)))
    
    weak var delegate:CustomNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.needLandscapeMode() {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }else {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if self.needLandscapeMode() {
            return .landscape
        }
        return .portrait
    }

    
    func permitInterfaceOrientation() -> UIInterfaceOrientationMask {
        if self.needLandscapeMode() {
           return .landscape
        }
        return .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func needLandscapeMode() -> Bool {
        
        if self is PeriodicTableVC || self is SettingVC{
            return true
        }
        
        return false
    }
    
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

protocol CustomNavigationDelegate:class {
    func didSelectedBackOrMenu() //Required
    func didSelectedRightButton()
}

// Funtion is optional
extension CustomNavigationDelegate {
    func didSelectedRightButton() {}
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
            self.navigationItem.leftBarButtonItem = menuBarItem
            self.navigationItem.rightBarButtonItem = doneBarItem
            break;
        case .CancelSave:
            self.navigationItem.leftBarButtonItem = cancelBarItem
            self.navigationItem.rightBarButtonItem = saveBarItem
            
            break;
        case .CanCelDone:
            break;
        case .BackEdit:
            self.navigationItem.leftBarButtonItem = menuBarItem
            self.navigationItem.rightBarButtonItem = editBarItem
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
        delegate?.didSelectedRightButton()
    }
    
    @objc func onNavigationClickRightButton(_ sender: UIBarButtonItem) {
        delegate?.didSelectedRightButton()
    }
    
}

