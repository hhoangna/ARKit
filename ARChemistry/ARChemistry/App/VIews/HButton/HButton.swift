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
