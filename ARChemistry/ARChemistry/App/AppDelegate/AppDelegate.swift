//
//  AppDelegate.swift
//  ARChemistry
//
//  Created by HHumorous on 6/28/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import MBProgressHUD
import GoogleSignIn
import FirebaseFirestore
import ARKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var config:Configuration?
    public var rootNV:BaseNV?
    public var mainVC:MainVC?
    private var hud = MBProgressHUD()
    var user = UserDetail()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        config = Configuration()
        checkStatusLogin()
        
        FirebaseApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        guard ARWorldTrackingConfiguration.isSupported else {
            fatalError("""
                ARKit is not available on this device. For apps that require ARKit
                for core functionality, use the `arkit` key in the key in the
                `UIRequiredDeviceCapabilities` section of the Info.plist to prevent
                the app from installing. (If the app can't be installed, this error
                can't be triggered in a production scenario.)
                In apps where AR is an additive feature, use `isSupported` to
                determine whether to show UI for launching AR experiences.
            """) // For details, see https://developer.apple.com/documentation/arkit
        }

        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
//        if let error = error {
//            print("\(error.localizedDescription)")
//        } else {
//            // Perform any operations on signed in user here.
//            self.user.name = user.profile.name
//            self.user.email = user.profile.email
//            guard let authentication = user.authentication else { return }
//            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                           accessToken: authentication.accessToken)
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//                if let error = error {
//                    print(error)
//                    return
//                } else {
//                    guard let uid = Auth.auth().currentUser?.uid else {
//                        App().hideHUDProgess("Error", "Can't sign up", "ic_errorLogin", .customView)
//                        return
//                    }
//                    let dictionaryValues = ["name": self.user.name,
//                                            "email": self.user.email,
//                                            "imageUrl": "",
//                                            "gender": "",
//                                            "birthday": "",
//                                            "address": "",
//                                            "password": ""]
//                    let values = [uid : dictionaryValues]
//
//                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
//                        if err != nil {
//                            //
//                            return
//                        }
//                        print("Successfully saved user info into Firebase database")
//                        Config().user?.token = uid
////                        Config().user?.user = self.user
//                        Config().user?.user?.name = self.user.name
//                        Config().user?.user?.email = self.user.email
//                        App().loginSuccess()
//                    })
//
//                }
//            }
//        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func checkStatusLogin() {
        //set rootNV
        rootNV = window?.rootViewController as? BaseNV
        if (!(config?.hasLogin ?? false)) {
            let vc:LoginRegisterVC = VCFromSB(SB: .Login)
            rootNV?.setViewControllers([vc], animated: false)
        }else {
            loginSuccess()
        }
    }
    
    func loginSuccess() {
        let vc:MainVC = VCFromSB(SB: .Main)
        mainVC = vc;
        if let mVC  = mainVC {
            rootNV?.setViewControllers([mVC], animated: false)
        }
    }
    
    func onReLogin() {
        let vc:LoginRegisterVC = VCFromSB(SB: .Login)
        rootNV?.setViewControllers([vc], animated: false)
        Config().setUser(nil)
    }

    func hideHUDProgess(_ title: String, _ mess: String, _ imgName: String, _ mode: MBProgressHUDMode) {
        
        hud.mode = mode
        hud.label.text = title
        hud.detailsLabel.text = mess
        hud.customView = UIImageView(image: UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate))
        hud.hide(animated: true, afterDelay: 2)
        
    }
    
    func showHUDProgess(_ view: UIView) {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
    }

}

