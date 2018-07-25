//
//  ElementListVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/22/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import ColorMatchTabs
import FirebaseFirestore

class ElementListVC: ColorMatchTabsViewController {
    
    var element = [ElementDto]()
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
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
        
//        db.collection("Elements").getDocuments { (snapshot, err) in
//            if let err = err {
//                print("\(err.localizedDescription)")
//            }else{
//                self.element = snapshot!.documents.compactMap({ElementDto(dictionary: $0.data())})
//                DispatchQueue.main.async {
////                    self.tableView.reloadData()
//                    print(self.element)
//                }
//            }
//        }
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

extension ElementListVC: CustomNavigationDelegate {
    @objc func didSelectedBackOrMenu() {
        App().mainVC?.showSlideMenu(isShow: true, animation: true)
    }
}
