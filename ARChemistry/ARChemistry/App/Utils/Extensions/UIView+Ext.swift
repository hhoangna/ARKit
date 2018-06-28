//
//  UIView+Ext.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/7/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Style
extension UIView {
    func setBorder(color: UIColor?, lineW: CGFloat) {
        self.layer.borderColor = color?.cgColor;
        self.layer.borderWidth = lineW;
    }
    
    func setRoudary(radius: CGFloat) {
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = radius;
    }
}
