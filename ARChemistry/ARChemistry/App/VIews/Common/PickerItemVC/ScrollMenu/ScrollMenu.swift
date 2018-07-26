//
//  ScrollMenu.swift
//  ARChemistry
//
//  Created by HHumorous on 7/26/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

protocol ScrollMenuDelegate: class {
}

extension ScrollMenuDelegate {
    func scrollMenuDidSelectedIndex(_ index: IndexPath){}
}

class ScrollMenu: UICollectionView {
    
    lazy var layout = PeriodicCellFlow(style: .regular)
    var delegateScrollMenu: ScrollMenuDelegate?
    var indexSelect: Int?
    var arrData: [Any] = []
    var arrValueWidth: [Int] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initData()
    }
    
    func initData() {
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.layout.scrollDirection = .horizontal
        self.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelect = indexPath.row
        
    }
}

extension ScrollMenu: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.height, height: self.frame.size.height - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}

extension ScrollMenu: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrData.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        return cell
    }
}

extension ScrollMenu: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        indexSelect = indexPath.row
        self.setScrollWithIndex(indexPath.row)
        self.reloadData()
        delegateScrollMenu?.scrollMenuDidSelectedIndex(indexPath)
    }
}

fileprivate extension ScrollMenu {
    func setData(_ arr: NSArray) {
        arrData = arr as! [String]
        self.reloadData()
    }
    
    func setIndexSelected(_ index: Int) {
        indexSelect = index
        self.reloadData()
    }
    
    func setScrollWithIndex(_ index: Int) {
        var value:CGFloat = 0
        let totalCellWidth: CGFloat = CGFloat(arrValueWidth[index])
        let totalWidth: CGFloat = CGFloat(10 * (index - 1)) + totalCellWidth
        
        if (index > 1 && totalWidth > (self.frame.size.width * 2/3)) {
            value = CGFloat(arrValueWidth[index - 2])
            if (self.contentSize.width - value < self.frame.size.width) {
                value = self.contentSize.width - self.frame.size.width
            }
        }
        self.setContentOffset(CGPoint(x: value, y: 0), animated: true)
    }
    
    func getValueWidthData() {
        var sum: CGFloat = 0
        for _ in 0..<arrData.count {
            sum = sum + self.frame.size.height
            arrValueWidth.append(Int(sum))
        }
    }
}
