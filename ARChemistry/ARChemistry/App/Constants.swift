//
//  Constants.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/4/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import Foundation
import UIKit


// MARK: Functions

func App() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate;
}

func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func E(_ val: String?) -> String {
    return (val != nil) ? val! : "";
}

func isEmpty(_ val: String?) -> Bool {
    return val == nil ? true : val!.isEmpty;
}

func ClassName(_ object: Any) -> String {
    return String(describing: type(of: object))
}

func MURL(_ server: String, _ path: String) -> String{
    return server.appending(path);
}

func ToString(_ data: Any) -> String{
    return String(describing: data);
}

func URLENCODE(_ str: String) -> String{
    return str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? str;
}

func URLDECODE(_ str: String) -> String{
    return str.removingPercentEncoding ?? str;
}

func VCFromSB<T>( SB:SBName) -> T {
    return UIStoryboard(name: SB.rawValue,
                        bundle: nil)
        .instantiateViewController(withIdentifier: String(describing: T.self)) as! T;
}

func VCFromSB<T>(_ viewController:T, SB:SBName) -> T {
    return UIStoryboard(name: SB.rawValue,
                        bundle: nil)
        .instantiateViewController(withIdentifier: ClassName(viewController)) as! T;
}

func SWIDTH() ->CGFloat {
    return UIScreen.main.bounds.width;
}

func SHEIGHT() ->CGFloat {
    return UIScreen.main.bounds.height;
}

func Config() -> Configuration {
    return App().config!
}

fileprivate(set)  var Location: LocationManager = {
    return LocationManager_();
}()

typealias ResponseDictionary = [String: Any]
typealias ResponseArray = [Any]


let CF_UserData = "CF_UserData"

func SERVER_API() -> String {
    return "http://128.199.134.62:3000/"
}

func SERVER_FILE() -> String {
    return "http://128.199.134.62:3000/"
}

func API() -> APIService {
    return APIService.shared()
}


public enum SBName : String {
    case Main = "Main";
    case Login = "Login";
    case PeriodicTable = "PeriodicTable";
    case ARKit = "ARKit";
    case Setting = "Setting";

}


