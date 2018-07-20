//
//  HButton.swift
//  ARChemistry
//
//  Created by HHumorous on 7/19/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

@IBDesignable
class HButton: UIButton {
    
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
    
    @IBInspectable
    var borderWidth: CGFloat {
        set (newValue) {
            _borderWidth = newValue
            layer.borderWidth = _borderWidth
        } get {
            return _borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        set (newValue) {
            _borderColor = newValue
            layer.borderColor = _borderColor.cgColor
        } get {
            return _borderColor
        }
    }
    
    func setStyleBlue() {
        self.layer.backgroundColor = AppColor.mainColor.cgColor
        self.titleColor = AppColor.white
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    func setStyleWhite() {
        self.layer.backgroundColor = AppColor.white.cgColor
        self.titleColor = AppColor.mainColor
        self.layer.borderWidth = 1;
        self.layer.borderColor = AppColor.mainColor.cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
}
