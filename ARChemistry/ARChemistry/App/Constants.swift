//
//  Constants.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/4/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

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
    return UIDevice.current.orientation.isPortrait ? UIScreen.main.bounds.width : UIScreen.main.bounds.height;
}

func SHEIGHT() ->CGFloat {
    return UIDevice.current.orientation.isPortrait ? UIScreen.main.bounds.height : UIScreen.main.bounds.width;
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

func colorWithGradient(_ height: CGFloat,_ from: UIColor,_ to: UIColor) -> UIColor {
    
    let size = CGSize(width: 1, height: height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let context = UIGraphicsGetCurrentContext()
    let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors:[from.cgColor, to.cgColor] as CFArray, locations:[0.0, 1.0])!
    context?.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return UIColor(patternImage: image!)
}

struct AppColor {
    static let mainColor            = UIColor(hex: "#009DF7")
    static let grayColor            = UIColor(hex: "#8F99A4")
    static let highLightColor       = UIColor(hex: "#b3e6ff")
    static let white                = UIColor.white
    static let black                = UIColor.black
    static let purpleColor          = UIColor(hex: "#7E57C2")
    static let greenColor           = UIColor(hex: "#4CAF50")
    static let redColor             = UIColor(hex: "#FF5722")
    static let yellowColor          = UIColor(hex: "#FFEB3B")
    static let orangeColor          = UIColor(hex: "#F57C00")
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}


public enum SBName : String {
    case Main = "Main";
    case Login = "Login";
    case PeriodicTable = "PeriodicTable";
    case ARKit = "ARKit";
    case Setting = "Setting";

}


