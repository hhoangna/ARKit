//
//  Font.swift
//  ARChemistry
//
//  Created by HHumorous on 7/18/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import Foundation
import UIKit

struct AppFont {
    static func robotoRegular(with size: Int) -> UIFont {
        let font = UIFont(name: "Roboto-Regular", size: CGFloat(size))
        
        return font!
    }
    
    static func robotoBold(with size: Int) -> UIFont {
        let font = UIFont(name: "Roboto-Bold", size: CGFloat(size))
        
        return font!
    }
    
    static func robotoMedium(with size: Int) -> UIFont {
        let font = UIFont(name: "Roboto-Medium", size: CGFloat(size))
        
        return font!
    }
    
    static func robotoBlack(with size: Int) -> UIFont {
        let font = UIFont(name: "Roboto-Black", size: CGFloat(size))
        
        return font!
    }
    
    static func helveticaRegular(with size: Int) -> UIFont {
        let font = UIFont(name: "Helvetica", size: CGFloat(size))
        
        return font!
    }
    
    static func helveticaBold(with size: Int) -> UIFont {
        let font = UIFont(name: "Helvetica-Bold", size: CGFloat(size))
        
        return font!
    }
    
    static func gothamBook(with size: Int) -> UIFont {
        let font = UIFont(name: "Gotham-Book", size: CGFloat(size))
        
        return font!
    }
    
    static func gothamMedium(with size: Int) -> UIFont {
        let font = UIFont(name: "Gotham-Medium", size: CGFloat(size))
        
        return font!
    }
    
    static func gothamBold(with size: Int) -> UIFont {
        let font = UIFont(name: "Gotham-Bold", size: CGFloat(size))
        
        return font!
    }
    
    static func belindaRegular(with size: Int) -> UIFont {
        let font = UIFont(name: "BelindaW00-Regular", size: CGFloat(size))
        
        return font!
    }
}
