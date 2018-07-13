//
//  BaseNV.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/3/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

class BaseNV: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    func permitInterfaceOrientation() -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        let count = self.viewControllers.count
        if count > 1 {
            if let vc: BaseVC = App().rootNV?.viewControllers.last as? BaseVC {
                return vc.permitInterfaceOrientation()
            }
        } else {
            
            if let vc: BaseVC = App().rootNV?.viewControllers.last as? BaseVC {
                return vc.permitInterfaceOrientation()
            }
        }
        
        return .portrait;
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
