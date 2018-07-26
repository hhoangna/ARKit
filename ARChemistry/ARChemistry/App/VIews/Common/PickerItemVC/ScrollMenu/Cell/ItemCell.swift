//
//  ItemCell.swift
//  ARChemistry
//
//  Created by HHumorous on 7/25/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
       
        layer.backgroundColor = AppColor.mainColor.cgColor
        layer.cornerRadius = 5
    }

}
