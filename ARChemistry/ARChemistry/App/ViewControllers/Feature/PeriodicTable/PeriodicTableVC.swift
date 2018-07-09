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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateNavigationBar(.Menu, "Periodic Table");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
