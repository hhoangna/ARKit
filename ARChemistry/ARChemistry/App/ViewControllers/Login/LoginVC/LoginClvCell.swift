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

//                let json = JSON(responseDict)
//                self.name = json["name"].string
//                self.email = json["email"].string
//                guard let profilePictureUrl = json["picture"]["data"]["url"].string else {
//                    App().hideHUDProgess("Error", "Failed to fetch User", "", .text)
//                    return
//                }
//                guard let url = URL(string: profilePictureUrl) else {
//                    App().hideHUDProgess("Error", "Failed to fetch User", "", .text)
//                    return
//                }
//
//                URLSession.shared.dataTask(with: url) { (data, response, err) in
//                    if err != nil {
//                        guard let err = err else {
//                            App().hideHUDProgess("Error", "Failed to fetch User", "", .text)
//                            return
//
//                        }
//                        App().hideHUDProgess("Fetch error", err.localizedDescription, "", .text)
//                        return
//                    }
//                    guard let data = data else {
//                        App().hideHUDProgess("Error", "Failed to fetch User", "", .text)
//                        return
//                    }
//                    self.profileImage = UIImage(data: data)
//                    self.saveUserIntoFirebaseDatabase()
//
//                    }.resume()

                break
            case .failed(let err):
                App().hideHUDProgess("Error", "Failed to get Facebook user with error: \(err)", "", .text)
                break
            }
        })
        graphRequestConnection.start()


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

