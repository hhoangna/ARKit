//
//  UIButton+Ext.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/7/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    func setBorderButton(color: UIColor?, lineW: CGFloat) {
        self.layer.borderColor = color?.cgColor;
        self.layer.borderWidth = lineW;
    }
    
    func setRousdaryButton(radius: CGFloat) {
        self.layer.masksToBounds = true;
        self.clipsToBounds = true;
        self.layer.cornerRadius = radius;
    }
}
