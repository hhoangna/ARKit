//
//  LoginRegisterVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/18/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleSignIn

class LoginRegisterVC: BaseVC,  GIDSignInUIDelegate{
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    @IBOutlet weak var tabBarTopItemView: UIView?
    @IBOutlet weak var clvContent: UICollectionView?
    @IBOutlet weak var vEffect: UIVisualEffectView?
    
    var topItemView: TabBarTopView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        initUI()
        setupTabBarItemView()
        setupBackgroundVideo()
    }
    
    func setupTabBarItemView() {
        topItemView = TabBarTopView.load()
        topItemView?.delegate = self
        
        let tabLogin = TabBarItem.init("Login")
        let tabRegister = TabBarItem.init("Register")
        
        topItemView?.tabBarTopItems = [tabLogin,tabRegister]
        if let tabBarItem = topItemView {
            tabBarTopItemView?.addSubview(tabBarItem, edge: UIEdgeInsets.zero)
        }
    }
    
    func setupBackgroundVideo() {
        let theURL = Bundle.main.url(forResource: "video_background", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = UIColor.clear;
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer?.currentItem, queue: .main) { _ in
            self.avPlayer?.seek(to: kCMTimeZero)
            self.avPlayer?.play()
        }
    }
    
    func initUI() {
        if #available(iOS 11.0, *) {
            clvContent?.clipsToBounds = true
            clvContent?.layer.cornerRadius = 10
            clvContent?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            
            tabBarTopItemView?.clipsToBounds = true
            tabBarTopItemView?.layer.cornerRadius = 10
            tabBarTopItemView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        vEffect?.layer.cornerRadius = 15
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.play()
        paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
}

extension LoginRegisterVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.frame.size;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}


//MARK : - UICollectionViewDataSource
extension LoginRegisterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0) {
            let cell: LoginClvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoginClvCell", for: indexPath) as! LoginClvCell
            
            cell.rootVC = self
            cell.delegate = self
            
            return cell;
        } else {
            let cell: RegisterClvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterClvCell", for: indexPath) as! RegisterClvCell
            
            cell.rootVC = self
            
            return cell;
        }
        
    }
}

extension LoginRegisterVC: LoginCellDelegate {
    func didSelectButton(cell: LoginClvCell, btn: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
}

//MARK: - UIScrollViewDelegate
extension LoginRegisterVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topItemView?.updateContraintViewSelectedDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        topItemView?.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension LoginRegisterVC: TabBarTopViewDelegate {
    func didSelectedTabBarTopItem(tabBarTopItemView: TabBarTopView, indexBarItem: Int) {
        print("IndexTabBarItem:\(indexBarItem)")
        scrollToPageSelected(indexBarItem)
        view.endEditing(true)
    }
    
    func scrollToPageSelected(_ indexPage:Int) {
        let width = self.view.frame.size.width * 0.9
        let pointX = CGFloat(indexPage) * width
        
        clvContent?.contentOffset =  CGPoint(x: pointX, y: (clvContent?.contentOffset.y)!);
        UIView.animate(withDuration: 0.2) {
            self.loadViewIfNeeded()
        }
    }
}
