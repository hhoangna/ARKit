//
//  LoginClvCell.swift
//  ARChemistry
//
//  Created by HHumorous on 7/18/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import TransitionButton
import FacebookCore
import FacebookLogin
import MBProgressHUD
import FirebaseAuth
import ObjectMapper
import GoogleSignIn
import FirebaseFirestore

protocol LoginCellDelegate:class {
    func didSelectButton(cell:LoginClvCell, btn: UIButton);
}

class LoginClvCell: BaseClvCell, GIDSignInUIDelegate {
    
    @IBOutlet fileprivate weak var tfUsername: UITextField?
    @IBOutlet fileprivate weak var tfPassword: UITextField?
    @IBOutlet fileprivate weak var viewLogin: UIView?
    @IBOutlet fileprivate weak var btnLogin: TransitionButton!
    @IBOutlet fileprivate weak var btnFacebook: HButton?
    @IBOutlet fileprivate weak var btnGoogle: HButton?
    
    weak var delegate: LoginCellDelegate?
    
    public var users = User()
    
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
                    App().showHUDProgess(self)
                    Auth.auth().signIn(withEmail: (self.tfUsername?.text!)!, password: (self.tfPassword?.text!)!, completion: { (user, err) in
                        if err != nil {
                            App().hideHUDProgess("Error", "", "ic_errorLogin", .customView)
                        } else {
                            if let uid = Auth.auth().currentUser?.uid {
                                
                                let db = Firestore.firestore()
                                db.collection("Users").document(uid).getDocument(completion: { (document, err) in
                                    if let user = document.flatMap({
                                        $0.data().flatMap({ (data) in
                                            return Mapper<User>().map(JSON: data)
                                        })
                                    }) {
                                        self.users = user
                                        Config().setUser(self.users)
                                        App().hideHUDProgess("", "", "ic_check", .customView)
                                        App().loginSuccess()
                                    } else {
                                        App().hideHUDProgess("Error", "", "ic_errorLogin", .customView)
                                    }
                                })
                            }
                        }
                    })
                })
            })
        })
    }
    
    @IBAction func onBtnLoginWithFacebook(btn: HButton) {
        App().showHUDProgess(self)
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self.rootVC) { (result) in
            switch result {
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                print("Succesfully logged in into Facebook.")
                self.signIntoFirebase()
            case .failed(let err):
                App().hideHUDProgess("Failed to get Facebook user with error: \(err)", "", "ic_errorLogin", .customView)
            case .cancelled:
                App().hideHUDProgess("Cancel login to Facebook", "", "ic_cancelLogin", .customView)
            }
        }
    }
    
    fileprivate func signIntoFirebase() {
        guard let authenticationToken = AccessToken.current?.authenticationToken else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (user, err) in
            if let err = err {
                App().hideHUDProgess(err.localizedDescription, "", "ic_errorLogin", .customView)
                return
            }
            print("Succesfully authenticated with Firebase.")
            self.fetchFacebookUser()
        }
    }
    
    fileprivate func fetchFacebookUser() {

        let graphRequestConnection = GraphRequestConnection()
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)
        graphRequestConnection.add(graphRequest, completion: { (httpResponse, result) in
            switch result {
            case .success(response: let response):

                guard let responseDict = response.dictionaryValue else {
                    App().hideHUDProgess("Error", "Failed to fetch User", "", .text)
                    return
                }
                
                print(responseDict)
                
                let user = Mapper<UserDetail>().map(JSON: responseDict)
                
                self.users.user = user!
                
                guard let url = URL(string: (user?.picture?.data?.url)!) else {
                    App().hideHUDProgess("Error", "Failed to fetch User", "", .text)
                    return
                }

                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    if err != nil {
                        guard let err = err else {
                            App().hideHUDProgess("Error", "Failed to fetch User", "", .text)
                            return

                        }
                        App().hideHUDProgess("Fetch error", err.localizedDescription, "", .text)
                        return
                    }
                    self.saveUserIntoFirebaseDatabase()

                    }.resume()

                break
            case .failed(let err):
                App().hideHUDProgess("Error", "Failed to get Facebook user with error: \(err)", "", .text)
                break
            }
        })
        graphRequestConnection.start()
    }
    
    fileprivate func saveUserIntoFirebaseDatabase() {
        
        guard let uid = Auth.auth().currentUser?.uid,
            let name = self.users.user?.name,
            let email = self.users.user?.email,
            let imageUrl = self.users.user?.picture?.data?.url else {
                App().hideHUDProgess("Error", "Failed to save user", "", .text)
                return
        }

        let newUser: [String: Any] = [
            "token": uid,
            "type": 1,
            "user": [
                "id": uid,
                "name": name,
                "email": email,
                "gender": 0,
                "birthday": Date(),
                "address": "",
                "pass": "",
                "imageUrl": imageUrl]]
        
        let db = Firestore.firestore()
        db.collection("Users").document(uid).setData(newUser, merge: true, completion: { (err) in
            if let err = err {
                print("Error adding document: \(err)")
                App().hideHUDProgess("Error", "Can't sign up", "ic_errorLogin", .customView)
                return
            } else {
                print("Document added")
                App().hideHUDProgess("Success!", "", "ic_check", .customView)
                
                Config().user?.token = uid
                Config().user?.type = 1
                Config().setUser(self.users)
                App().loginSuccess()
            }
        })
    }
    
    @IBAction func onBtnLoginWithGoogle(btn: HButton) {
        delegate?.didSelectButton(cell: self, btn: btn)
    }
    
    func dismissKeyboard() {
        tfPassword?.resignFirstResponder()
        tfUsername?.resignFirstResponder()
    }
}

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
            case .horizontal:
                return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
            case .vertical:
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
            }
        }
    }
}

extension UIView {
    
    func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
}

