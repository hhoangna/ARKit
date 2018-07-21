//
//  BaseTbvCell.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/4/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

class BaseTbvCell: UITableViewCell {
    
    @IBOutlet  weak var imvIcon: UIImageView?
    @IBOutlet  weak var lblTitle: UILabel?
    @IBOutlet  weak var lblSubTitle: UILabel?
    @IBOutlet  weak var btnEdit: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
