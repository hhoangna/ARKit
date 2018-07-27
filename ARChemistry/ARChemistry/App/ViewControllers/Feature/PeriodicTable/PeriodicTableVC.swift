//
//  PeriodicTableVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/9/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

class PeriodicTableVC: BaseVC {
    
    @IBOutlet weak var vPeriodicTable : PeriodicTable!
    @IBOutlet weak var btnBack : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateNavigationBar(.Menu, "Periodic Table");
    }
    
    @IBAction private func backToMain(_ sender: UIButton) {
        App().mainVC?.showSlideMenu(isShow: true, animation: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
