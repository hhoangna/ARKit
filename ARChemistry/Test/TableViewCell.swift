//
//  TableViewCell.swift
//  Test
//
//  Created by Admin on 9/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

protocol CellDelegate: class {
    func onBtnSave(cell: UITableViewCell, sender: UIButton)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    var delegate: CellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
        delegate?.onBtnSave(cell: self, sender: sender)
    }
}
