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
    
    weak var delegate: MenuCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpbuttonNoti()
    }
    
    func setUpbuttonNoti() {
        btnNoti?.setRousdaryButton(radius: (btnNoti?.frame.height)! / 2)
        btnNoti?.backgroundColor = Color.blueHeader;
        btnNoti?.setTitleColor(Color.white, for: .normal);
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
