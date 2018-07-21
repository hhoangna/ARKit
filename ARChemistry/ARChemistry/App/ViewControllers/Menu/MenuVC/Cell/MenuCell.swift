//
//  MenuCell.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/7/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

protocol MenuCellDelegate: class{
    func didSelectedLogout(cell:MenuCell, btn:UIButton);
    func didSelectedProfile(cell:MenuCell, btn:UIButton);
}

class MenuCell: BaseTbvCell {
    
    @IBOutlet weak var btnNoti:UIButton?
    @IBOutlet weak var imvAvatar:UIImageView?
    
    weak var delegate: MenuCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func draw(_ rect: CGRect) {
        imvAvatar?.layer.cornerRadius = (imvAvatar?.frame.size.height)!/2
        imvAvatar?.layer.borderColor = AppColor.white.cgColor
        imvAvatar?.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onbtnClickLogout(btn:UIButton) {
        delegate?.didSelectedLogout(cell: self, btn: btn);
    }
    
    @IBAction func onbtnClickViewProfile(btn:UIButton) {
        delegate?.didSelectedProfile(cell: self, btn: btn)
    }
}
