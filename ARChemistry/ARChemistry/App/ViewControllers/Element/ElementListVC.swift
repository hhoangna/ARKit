//
//  ElementListVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/22/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import ColorMatchTabs

class ElementListVC: ColorMatchTabsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menu(target: self, action: #selector(didSelectedBackOrMenu))
        
        let label = UILabel()
        
        label.textColor = AppColor.white
        label.font = AppFont.helveticaRegular(with: 17)
        label.text = "Chemical Element"
        label.sizeToFit()
        
        self.navigationItem.titleView = label

        colorMatchTabDataSource = self
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
}

extension ElementListVC: ColorMatchTabsViewControllerDataSource {
    
    func numberOfItems(inController controller: ColorMatchTabsViewController) -> Int {
        return TabItemsProvider.items.count
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, viewControllerAt index: Int) -> UIViewController {
        return SubViewControllersProvider.viewControllers[index]
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, titleAt index: Int) -> String {
        return TabItemsProvider.items[index].title
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, iconAt index: Int) -> UIImage {
        return TabItemsProvider.items[index].normalImage
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, hightlightedIconAt index: Int) -> UIImage {
        return TabItemsProvider.items[index].highlightedImage
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, tintColorAt index: Int) -> UIColor {
        return TabItemsProvider.items[index].tintColor
    }
    
}

extension ElementListVC: PopoverViewControllerDelegate {
    
    func popoverViewController(_ popoverViewController: PopoverViewController, didSelectItemAt index: Int) {
        selectItem(at: index)
    }
}

extension ElementListVC: CustomNavigationDelegate {
    @objc func didSelectedBackOrMenu() {
        App().mainVC?.showSlideMenu(isShow: true, animation: true)
    }
}
