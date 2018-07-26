//
//  PickerItemVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/25/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

typealias  PickerItemCallback = (_ date:Date) -> Void

class PickerItemVC: UIViewController {
    
    @IBOutlet weak var scrollMenu: ScrollMenu!
    @IBOutlet weak var clvContent: UICollectionView!
    @IBOutlet weak var vContent: UIView!
    
    var callback:PickerItemCallback?
    lazy var layout = PeriodicCellFlow(style: .regular)
    var screenIndex: Int? = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpClvContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showPickerItemWithAnimation()
    }
    
    func setUpClvContent() {
        clvContent.delegate = self
        clvContent.dataSource = self
        clvContent.showsVerticalScrollIndicator = false
        clvContent.showsHorizontalScrollIndicator = false
        
        clvContent.collectionViewLayout = layout
        layout.scrollDirection = .vertical
    }
    
    @objc func showPickerItemWithAnimation()  {
        let height = vContent?.frame.size.height ?? 0
        
        vContent?.transform = CGAffineTransform(translationX: 0, y: height)
        UIView.animate(withDuration: 0.3) {
            self.vContent?.transform = .identity
        }
    }
    
    func hidePickerItem()  {
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
                hidePickerItem()
            }
        }
    }
}

extension PickerItemVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension PickerItemVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCell = (clvContent.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell)!
        
        return cell
    }
}

extension PickerItemVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

extension PickerItemVC {
    static func showPickerItem() {
        let vc: PickerItemVC = PickerItemVC.load(SB: .Common)
        
        App().mainVC?.navigationController?.present(vc, animated: true, completion: nil)
    }
}

fileprivate extension PickerItemVC {
    func setCallBack(callback:@escaping PickerItemCallback)  {
        self.callback = callback
    }
}
