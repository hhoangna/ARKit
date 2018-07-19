//
//  UIButton+Ext.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/7/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit;

extension UIButton {
    
    // MARK: - Util properties
    
    var title: String? {
        get {
            return title(for: .normal);
        }
        set {
            setTitle(newValue, for: .normal);
        }
    }
    
    var titleColor: UIColor? {
        get {
            return titleColor(for: .normal);
        }
        set {
            setTitleColor(newValue, for: .normal);
        }
    }
    
    var attrTitle: NSAttributedString? {
        get {
            return attributedTitle(for: .normal);
        }
        set {
            setAttributedTitle(newValue, for: .normal);
        }
    }
    
    var image: UIImage? {
        get {
            return image(for: .normal);
        }
        set {
            setImage(newValue, for: .normal);
        }
    }
    
    var backgroundImage: UIImage? {
        get {
            return backgroundImage(for: .normal);
        }
        set {
            setBackgroundImage(newValue, for: .normal);
        }
    }
    
    // MARK: -
    
    func setShadow(shadowOpacity: CGFloat,shadowOffset: CGSize,shadowRadius: CGFloat,shadowColor: UIColor){
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = Float(shadowOpacity)
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    
}
