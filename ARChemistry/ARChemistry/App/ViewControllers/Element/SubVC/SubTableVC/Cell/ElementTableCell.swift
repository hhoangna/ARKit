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
    @IBOutlet private weak var lblAtom: UILabel!
    @IBOutlet private weak var imvImage: UIImageView!
    
    override func draw(_ rect: CGRect) {
        lblAtom.translatesAutoresizingMaskIntoConstraints = false
        lblAtom.bottomAnchor.constraint(equalTo: lblSymbol.topAnchor, constant: 5).isActive = true
        lblAtom.leftAnchor.constraint(equalTo: lblSymbol.rightAnchor, constant: 5).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.masksToBounds = false
    }
    
    func configureWith(_ element: ElementDto) {
        
        lblAtom.text = element.atom.stringValue
        lblMass.text = "[\(element.mass)]"
        lblName.text = element.name
        lblType.text = element.type
        lblSymbol.text = element.symbol
        imvImage.kf.setImage(with: URL(string: element.image))
        
        switch element.type {
        case "Á kim":
            layer.backgroundColor = AppColor.semi.cgColor
        case "Kim loại chuyển tiếp":
            layer.backgroundColor = AppColor.transition.cgColor
        case "Phi kim":
            layer.backgroundColor = AppColor.nonmetal.cgColor
        case "Halogen":
            layer.backgroundColor = AppColor.halogen.cgColor
        case "Kim loại kiềm":
            layer.backgroundColor = AppColor.alkali.cgColor
        case "Kim loại kiềm thổ":
            layer.backgroundColor = AppColor.alkaline.cgColor
        case "Khí hiếm":
            layer.backgroundColor = AppColor.noblegas.cgColor
        case "Nhóm Lantan":
            layer.backgroundColor = AppColor.lantan.cgColor
        case "Nhóm Actini", "Actini":
            layer.backgroundColor = AppColor.actinide.cgColor
        case "Kim loại", "Kim loại mềm":
            layer.backgroundColor = AppColor.metal.cgColor
        case "Không rõ":
            layer.backgroundColor = AppColor.unknown.cgColor
        default:
            layer.backgroundColor = AppColor.white.cgColor
        }
    }
    
    private func twoDigitsFormatted(_ val: Double) -> String {
        return String(format: "%.0.2f", val)
    }
}
