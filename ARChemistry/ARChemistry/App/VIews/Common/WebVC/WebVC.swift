//
//  WebVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/25/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    @IBOutlet weak var webKit: WKWebView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var vContent: UIView!
    
    var url: URL = URL(string: "http://www.google.com")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vContent.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        vContent.layer.cornerRadius = 15
        let request = URLRequest(url: url)
        webKit.load(request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showWebViewWithAnimation()
    }
    
    @objc func showWebViewWithAnimation()  {
        let height = vContent?.frame.size.height ?? 0
        
        vContent?.transform = CGAffineTransform(translationX: 0, y: height)
        UIView.animate(withDuration: 0.3) {
            self.vContent?.transform = .identity
        }
    }
    
    func hideWebView()  {
        let height = vContent?.frame.size.height ?? 0
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self?.vContent?.transform = CGAffineTransform(translationX: 0, y: height)
        }) {[weak self] (isFinish) in
            self?.dismiss(animated: false, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != self.vContent {
                hideWebView()
            }
        }
    }
    
    @IBAction func onBtnClosePressed(btn: UIButton) {
        hideWebView()
    }
}

extension WebVC {
    static func showWebViewWithUrl(_ url: URL) {
        let vc: WebVC = WebVC.load(SB: .Common)
        vc.setUrl(url)
        
        App().mainVC?.navigationController?.present(vc, animated: true, completion: nil)
    }
}

fileprivate extension WebVC {
    func setUrl(_ url: URL) {
        self.url = url
    }
}
