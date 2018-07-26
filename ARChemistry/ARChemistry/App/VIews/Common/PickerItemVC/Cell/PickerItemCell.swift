//
//  PickerItemCell.swift
//  ARChemistry
//
//  Created by HHumorous on 7/26/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

class PickerItemCell: UICollectionViewCell {
    
    @IBOutlet weak var clvContent: UICollectionView!
    
    lazy var layout = PeriodicCellFlow(style: .regular)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpClvContent()
    }
    
    func setUpClvContent() {
        clvContent.delegate = self
        clvContent.dataSource = self
        clvContent.showsVerticalScrollIndicator = false
        clvContent.showsHorizontalScrollIndicator = false
        
        clvContent.collectionViewLayout = layout
        layout.scrollDirection = .vertical
    }
    
}

extension PickerItemCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension PickerItemCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCell = (clvContent.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell)!
        
        return cell
    }
}

extension PickerItemCell: UICollectionViewDelegate {
    
}
