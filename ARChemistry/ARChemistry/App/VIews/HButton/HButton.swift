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
