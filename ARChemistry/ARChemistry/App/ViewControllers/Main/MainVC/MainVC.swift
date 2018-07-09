//
//  MainVC.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/2/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

class MainVC: BaseVC {
    
    @IBOutlet weak var viewMenu: UIView?
    @IBOutlet weak var viewMain: UIView?
    
    @IBOutlet weak var vMask: UIView?;
    @IBOutlet weak var conLeftPanel: NSLayoutConstraint?;
    
    var dragGesture = UIPanGestureRecognizer();
    var originDragX: CGFloat?;
    var originLeftX: CGFloat?;

    
    var rootNV:CustomNavigation?
    var menuVC:MenuVC?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showSlideMenu(isShow: false, animation: false)
        pushWorkingListToMain()
        setUpPanGesture()
    }
    
    func setUpPanGesture() {
        dragGesture = UIPanGestureRecognizer(target: self, action: #selector(self.onDragEvent(gesture:)))
        vMask?.isUserInteractionEnabled = true;
        vMask?.addGestureRecognizer(dragGesture);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Main_Menu" {
            menuVC = segue.destination as? MenuVC
        }else if (segue.identifier == "Main_RootNV") {
            rootNV = segue.destination as? CustomNavigation;
        }
    }
    
    
    @IBAction func hindenSlideMenu(gesture:UITapGestureRecognizer) {
        showSlideMenu(isShow: false, animation: true);
    }
    
    
    func pushWorkingListToMain() {
        //Push vào màn hình chính
        let vc:PeriodicTableVC = .loadSB(SB: SBName.PeriodicTable);
        rootNV?.setViewControllers([vc], animated: false);
    }
    
    @objc func onDragEvent(gesture:UILongPressGestureRecognizer) {
        let state = gesture.state;
        let p:CGPoint = gesture.location(in: gesture.view);
        let width = viewMenu?.frame.size.width;
        
        if (state == .began) {
            originDragX = p.x;
            originLeftX = conLeftPanel?.constant ?? 0;
            vMask?.isHidden = false;
            
            UIView.animate(withDuration: 0.18) {
                self.vMask?.alpha = 1.0;
            }
        }else if (state == .changed) {
            let delta:CGFloat  = p.x - (originDragX ?? 0);
            
            // [-width, 0]
            var newX:CGFloat  = (originLeftX ?? 0) + delta;
            newX = max(-width!, min(0, newX));
            conLeftPanel?.constant = newX;
            self.view.layoutIfNeeded();
            
        }else if (state == .ended ||
                state == .failed ||
                state == .cancelled) {
            
            let needShowing:Bool = (conLeftPanel?.constant ?? 0 > -width!/2.0);
            showSlideMenu(isShow: needShowing, animation: true);
        }
    }

    
    func showSlideMenu(isShow:Bool,animation:Bool) {
        conLeftPanel?.constant = isShow ? 0 : -max(SWIDTH(), SHEIGHT());
        
        if animation {
            UIView.animate(withDuration: 0.18, animations: {
                self.view.layoutIfNeeded()
                self.vMask?.alpha = (isShow ? 1 : 0);
                
            }) { (finished) in
                if (finished) {
                    self.vMask?.isHidden = !isShow;

                }
            }
        }else {
            self.view.layoutIfNeeded()
        }
        
        vMask?.isHidden = !isShow;
    }
}

