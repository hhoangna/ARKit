//
//  ElementTableCell.swift
//  ARChemistry
//
//  Created by HHumorous on 7/23/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

class ElementTableCell: UICollectionViewCell {
    
    @IBOutlet private weak var lblSymbol: UILabel!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblType: UILabel!
    @IBOutlet private weak var lblMass: UILabel!
    
    override func draw(_ rect: CGRect) {
        lblMass.translatesAutoresizingMaskIntoConstraints = false
        lblMass.bottomAnchor.constraint(equalTo: lblSymbol.topAnchor, constant: 5).isActive = true
        lblMass.leftAnchor.constraint(equalTo: lblSymbol.rightAnchor, constant: 5).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.backgroundColor = AppColor.white.cgColor
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.masksToBounds = false
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
    
    private func twoDigitsFormatted(_ val: Double) -> String {
        return String(format: "%.0.2f", val)
    }
}
