//
//  ElementCollectionCell.swift
//  ARChemistry
//
//  Created by HHumorous on 7/23/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

class ElementCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var lblSymbol: UILabel!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblType: UILabel!
    @IBOutlet private weak var lblMass: UILabel!
    @IBOutlet private weak var imvImage: UIImageView!
    
    let gradientFirstColor = UIColor(hex: "ff8181").cgColor
    let gradientSecondColor = UIColor(hex: "a81382").cgColor
    let cellsShadowColor = UIColor(hex: "2a002a").cgColor
    
    override func draw(_ rect: CGRect) {
        lblMass.translatesAutoresizingMaskIntoConstraints = false
        lblMass.bottomAnchor.constraint(equalTo: lblSymbol.topAnchor, constant: 5).isActive = true
        lblMass.leftAnchor.constraint(equalTo: lblSymbol.rightAnchor, constant: 5).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [gradientFirstColor, gradientSecondColor]
        gradientLayer.cornerRadius = 21
        gradientLayer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
        
        layer.shadowColor = cellsShadowColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize(width: 0.0, height: 30)
    }
    
    //    func configureWith(_ share: Share) {
    //        companyLabel.text = share.company
    //        categoryLabel.text = share.category
    //        priceLabel.text = "$ \(twoDigitsFormatted(share.price))"
    //        tendencyLabel.text = " \(twoDigitsFormatted(share.score)) (\(twoDigitsFormatted((share.percent)))) %"
    //        if share.isClosed {
    //            priceLabel.textColor = UIColor.vegaGray
    //            tendencyLabel.textColor = UIColor.vegaGray
    //            tendencyIcon.image = nil
    //        } else {
    //            tendencyLabel.textColor = share.isGrowing ? UIColor.vegaGreen : UIColor.vegaRed
    //            priceLabel.textColor = UIColor.vegaBlack
    //            tendencyIcon.image = share.isGrowing ? #imageLiteral(resourceName: "ic_up") : #imageLiteral(resourceName: "ic_down")
    //        }
    //    }

}
