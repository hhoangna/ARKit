//
//  ProfileCell.swift
//  ARChemistry
//
//  Created by HHumorous on 7/20/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate:class {
    func didSelectRightButton(cell:ProfileCell, btn: UIButton);
    func didSelectLogoutButton(cell:ProfileCell, btn: UIButton);
}

class ProfileCell: BaseTbvCell {
    
    enum IconCell {
        case edit
        case calendar
        case arrowDown
        case arrowLeft
        
        var icon:UIImage {
            switch self {
            case .edit:
                return #imageLiteral(resourceName: "ic_Edit")
            case .calendar:
                return #imageLiteral(resourceName: "ic_calendar")
            case .arrowDown:
                return #imageLiteral(resourceName: "ic_arrowDown")
            case .arrowLeft:
                return #imageLiteral(resourceName: "ic_arrowLeft")
            }
        }
    }
    
    @IBOutlet weak var btnChange: UIButton?
    @IBOutlet weak var btnLogout: UIButton?
    @IBOutlet weak var csWidEditButton: NSLayoutConstraint?
    
    weak var delegate: ProfileCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        btnChange?.layer.cornerRadius = (btnChange?.frame.size.height)!/2
        btnChange?.layer.borderColor = AppColor.white.cgColor
        btnChange?.layer.borderWidth = 1
        
        btnLogout?.layer.cornerRadius = (btnLogout?.frame.size.height)!/2
        btnLogout?.backgroundColor = colorWithGradient((btnLogout?.frame.size.height)!, AppColor.orangeColor, AppColor.redColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configura(_ mode: IconCell? =  nil ,
                   _ title:String? = nil,
                   _ subtitle:String? = nil)  {
        
        if let mMode = mode{
            self.btnEdit?.image = mMode.icon
        }
        self.lblTitle?.text = title
        self.lblSubTitle?.text = subtitle
    }
    
    @IBAction func onbtnClickRightButton(btn:UIButton){
        delegate?.didSelectRightButton(cell: self, btn: btn)
    }
    
    @IBAction func onBtnLogoutClicked(btn:UIButton){
        delegate?.didSelectLogoutButton(cell: self, btn: btn)
    }

}
