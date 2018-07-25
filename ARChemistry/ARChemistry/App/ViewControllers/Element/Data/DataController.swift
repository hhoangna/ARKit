//
//  DataController.swift
//  ARChemistry
//
//  Created by HHumorous on 7/22/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

//
//  TabItemsProvider.swift
//  ColorMatchTabs
//
//  Created by Sergey Butenko on 9/6/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import ColorMatchTabs

private let collectionViewCellHeightCoefficient: CGFloat = 0.75
private let collectionViewCellWidthCoefficient: CGFloat = 0.60 

struct TabItem {
    
    let title: String
    let tintColor: UIColor
    let normalImage: UIImage
    let highlightedImage: UIImage
}

class TabItemsProvider {
    
    static let items = {
        return [
            TabItem(
                title: "Table",
                tintColor: UIColor(red: 0.51, green: 0.72, blue: 0.25, alpha: 1.00),
                normalImage: UIImage(named: "ic_Table")!,
                highlightedImage: UIImage(named: "ic_tableHigh")!
            ),
            TabItem(
                title: "Collection",
                tintColor: UIColor(red: 0.15, green: 0.67, blue: 0.99, alpha: 1.00),
                normalImage: UIImage(named: "ic_Collection")!,
                highlightedImage: UIImage(named: "ic_collectionHigh")!
            )
        ]
    }()
    
}

class SubViewControllersProvider {
    
    static let viewControllers: [UIViewController] = {
        let tableVC = SubTableVC(collectionViewLayout: SubTableVCFowLayout())
        
        let collectionVC = SubCollectionVC(collectionViewLayout: SubCollectionVCFlowLayout(with: CGSize(width: SWIDTH() * collectionViewCellWidthCoefficient, height: SHEIGHT() * collectionViewCellHeightCoefficient)))
        
        return [tableVC, collectionVC]
    }()
    
}

