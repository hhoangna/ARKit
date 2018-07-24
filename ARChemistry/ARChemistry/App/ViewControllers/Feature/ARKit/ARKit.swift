//
//  ARKit.swift
//  ARChemistry
//
//  Created by HHumorous on 7/9/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

class ARKit: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(SWIDTH(), SHEIGHT())
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.updateNavigationBar(.Menu, "View in AR");
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
