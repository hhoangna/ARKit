//
//  UIColor+Ext.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/8/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(redI: Int, greenI: Int, blueI: Int, alpha: CGFloat = 1.0) {
        assert(redI >= 0 && redI <= 255, "Invalid red component");
        assert(greenI >= 0 && greenI <= 255, "Invalid green component");
        assert(blueI >= 0 && blueI <= 255, "Invalid blue component");
        assert(alpha >= 0.0 && alpha <= 1.0, "Invalid alpha component");
        
        self.init(red: CGFloat(redI) / 255.0, green: CGFloat(greenI) / 255.0, blue: CGFloat(blueI) / 255.0, alpha: alpha);
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            redI: (rgb >> 16) & 0xFF,
            greenI: (rgb >> 8) & 0xFF,
            blueI: rgb & 0xFF,
            alpha: alpha
        )
    }
}
