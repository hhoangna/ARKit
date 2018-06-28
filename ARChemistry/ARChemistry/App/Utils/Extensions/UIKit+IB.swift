//
//  UIKit+IB.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/4/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
  public static func loadSB<T>(SB:SBName) -> T {
        return UIStoryboard(name: SB.rawValue,
                            bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: T.self)) as! T;
    }
    
  public static func load<T: UIViewController>(nib: String? = nil) -> T {
        return T(nibName: nib != nil ? nib : String(describing: T.self),
                 bundle: nil);
    }
}

extension UIView {
    func LoadNib<T:UIView>(nib:String? = nil,owner: Any? = nil) -> T {
        return Bundle.main.loadNibNamed(nib != nil ? nib! : String(describing: type(of: T.self)),
                                        owner: owner,
                                        options: nil)?.first as! T
    }
}
