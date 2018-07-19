//
//  TabBarTopViewCell.swift
//  VSip-iOS
//
//  Created by HHumorous on 7/6/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

class TabBarTopViewCell: BaseClvCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        lblTitle?.layer.cornerRadius = (lblTitle?.frame.size.height)!/2
    }
    
}
