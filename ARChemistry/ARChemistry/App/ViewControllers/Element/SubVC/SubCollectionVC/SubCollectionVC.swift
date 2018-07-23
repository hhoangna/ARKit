//
//  SubCollectionVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/22/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

//with itemSize: CGSize

private let itemHeight: CGFloat = 100
private let collectionViewCellHeightCoefficient: CGFloat = 0.65
private let collectionViewCellWidthCoefficient: CGFloat = 0.45

class SubCollectionVC: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
//        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
//        guard let layout = collectionView?.collectionViewLayout as? SubCollectionVCFlowLayout else { return }

//        layout.itemSize = CGSize(width: (collectionView?.frame.size.height)! * collectionViewCellWidthCoefficient, height: (collectionView?.frame.size.height)! * collectionViewCellHeightCoefficient)

        collectionView?.collectionViewLayout.invalidateLayout()

    }
    
    fileprivate func setupTableView() {
        
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.allowsSelection = true
        
        let nib = UINib(nibName: "ElementCollectionCell", bundle: nil)
        
        collectionView?.register(nib, forCellWithReuseIdentifier: "ElementCollectionCell")
        collectionView?.contentInset.bottom = itemHeight
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCollectionCell", for: indexPath) as! ElementCollectionCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let locationFirst = CGPoint(x: (collectionView?.center.x)! + scrollView.contentOffset.x, y: (collectionView?.center.y)! + scrollView.contentOffset.y)
//        let locationSecond = CGPoint(x: (collectionView?.center.x)! + scrollView.contentOffset.x + 20, y: (collectionView?.center.y)! + scrollView.contentOffset.y)
//        let locationThird = CGPoint(x: (collectionView?.center.x)! + scrollView.contentOffset.x - 20, y: (collectionView?.center.y)! + scrollView.contentOffset.y)
//
//        if let indexPathFirst = collectionView.indexPathForItem(at: locationFirst), let indexPathSecond = collectionView.indexPathForItem(at: locationSecond), let indexPathThird = collectionView.indexPathForItem(at: locationThird), indexPathFirst.row == indexPathSecond.row && indexPathSecond.row == indexPathThird.row && indexPathFirst.row != pageControl.currentPage {
//            pageControl.currentPage = indexPathFirst.row % images.count
//            self.animateChangingTitle(for: indexPathFirst)
//        }
//    }
}

