//
//  CustomNavigation.swift
//  ARChemistry
//
//  Created by HHumorous on 7/9/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

enum BarStyle {
    case Menu;
    case BackOnly;
    case BackDone;
    case CancelSave;
    case CanCelDone;
}

class CustomNavigation: BaseNV {
    
    fileprivate lazy var backBarItem : UIBarButtonItem = UIBarButtonItem.back(target: self, action: #selector(onNavigationBack(_:)))
    fileprivate lazy var menuBarItem : UIBarButtonItem = UIBarButtonItem.menu(target: self, action: #selector(onNavigationMenu(_:)))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(false, animated: false);
        self.navigationBar.barTintColor = AppColor.mainColor
        self.navigationBar.tintColor = .white
        self.navigationBar.backgroundColor = AppColor.mainColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateNavigationBar(_ barStyle:BarStyle, title:String?) {
        if let title = title{
            self.addTitleToNavigationBar(title: title)
        }
        switch barStyle {
        case .Menu:
            self.navigationItem.leftBarButtonItem = menuBarItem
            break;
        case .BackOnly:
            self.navigationItem.leftBarButtonItem = backBarItem
            break;
        case .BackDone:
            self.navigationItem.leftBarButtonItem = backBarItem
            break;
        case .CancelSave:
            break;
        case .CanCelDone:
            break;
        }
    }
    
    @objc func onNavigationBack(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true);
    }
    
    @objc func onNavigationMenu(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true);
    }
}

