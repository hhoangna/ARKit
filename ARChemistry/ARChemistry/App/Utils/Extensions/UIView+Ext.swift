//
//  UIView+Ext.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/7/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//


import UIKit

extension UIView {
    
    // MARK: - Finding
    
    func findNextResponder(withClass cls : AnyClass) -> UIResponder? {
        
        var current : UIResponder? = self;
        
        while let aCurrent = current {
            
            if aCurrent.isKind(of: cls) {
                return current;
            }
            
            current = aCurrent.next;
        }
        
        return nil;
    }
    
    func getSuperView(withClass cls: AnyClass) -> Any? {
        
        var obj = self.superview;
        
        while let anObj = obj {
            
            if anObj.isKind(of: cls) {
                return anObj;
            }else{
                obj = anObj.superview;
            }
            
        }
        
        return nil;
    }
    
    // MARK: - Style
    
    func setBorder(color: UIColor?, lineW: CGFloat) {
        self.layer.borderColor = color?.cgColor;
        self.layer.borderWidth = lineW;
    }
    
    func setRoudary(radius: CGFloat) {
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = radius;
    }
    
    // MARK: - Others
    
    func removeAllConstraints() {
        removeConstraints(self.constraints);
    }
    
    func removeAllConstraintsIncludesSubviews() {
        removeAllConstraints();
        
        for subView in self.subviews {
            subView.removeAllConstraintsIncludesSubviews();
        }
        
    }
    
    func addSubview(_ subView: UIView, edge: UIEdgeInsets) {
        
        let frame = UIEdgeInsetsInsetRect(self.bounds, edge);
        subView.frame = frame;
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        addSubview(subView);
    }
    
    func capture() -> UIImage? {
        return capture(scale: 0.0);
    }
    
    func capture(scale: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale);
        
        drawHierarchy(in: self.frame, afterScreenUpdates: true);
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
    
    func setShadowDefault() {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
    }
}

