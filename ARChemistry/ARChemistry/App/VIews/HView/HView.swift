//
//  HView.swift
//  ARChemistry
//
//  Created by HHumorous on 7/19/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

@IBDesignable
class HView: UIView {
    
    private var _cornerRadius: CGFloat = 0.0
    private var _borderWidth: CGFloat = 0.0
    private var _borderColor: UIColor = UIColor.black
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set (newValue) {
            _cornerRadius = newValue
            layer.cornerRadius = _cornerRadius
        } get {
            return _cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    func roundedCorners(_ corners: CACornerMask, _ radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            // Fallback on earlier versions
        }
    }
}


