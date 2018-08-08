//
//  ListARKit.swift
//  ARChemistry
//
//  Created by HHumorous on 8/7/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ListARKit: BaseVC {
    
    @IBOutlet weak var clvContent: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var compound = [CompoundDto]()
    var db: Firestore!
    
    let collectionViewCellHeightCoefficient: CGFloat = 0.85
    let collectionViewCellWidthCoefficient: CGFloat = 0.55
    let priceButtonCornerRadius: CGFloat = 10
    let gradientFirstColor = UIColor(hex: "ff8181").cgColor
    let gradientSecondColor = UIColor(hex: "a81382").cgColor
    let cellsShadowColor = UIColor(hex: "2a002a").cgColor

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateNavigationBar(.Menu, "Chemical Compound")
        db = Firestore.firestore()
        loadCompound()
    }
    
    private func loadCompound() {
        db.collection("Compounds").getDocuments { (snapshot, err) in
            if let err = err {
                print("\(err.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.compound = snapshot!.documents.compactMap({CompoundDto(dictionary: $0.data())})
                    self.clvContent.reloadData()
                }
            }
        }
    }
    
    private func configureCollectionView() {
        let collectionCellFlow = SubCollectionVCFlowLayout(with: CGSize(width: clvContent.frame.size.height * collectionViewCellWidthCoefficient, height: clvContent.frame.size.height * collectionViewCellHeightCoefficient))
        clvContent.collectionViewLayout = collectionCellFlow
        clvContent.dataSource = self
        clvContent.delegate = self
    }
    
    private func configureProductCell(_ cell: ElementCollectionCell, for indexPath: IndexPath) {
        cell.clipsToBounds = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.bounds
        gradientLayer.colors = [gradientFirstColor, gradientSecondColor]
        gradientLayer.cornerRadius = 21
        gradientLayer.masksToBounds = true
        cell.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.layer.shadowColor = cellsShadowColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 20
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 30)
        
        cell.imvImage.kf.setImage(with: URL(string: compound[indexPath.row].image))
    }
    
    private func animateChangingTitle(for indexPath: IndexPath) {
        UIView.transition(with: lblName, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.lblName.text = self.compound[indexPath.row].name
        }, completion: nil)
        UIView.transition(with: lblDesc, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.lblDesc.text = self.compound[indexPath.row].desc
        }, completion: nil)
    }
}

extension ListARKit: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return compound.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCollectionCell", for: indexPath) as! ElementCollectionCell
        
        self.configureProductCell(cell, for: indexPath)
        
        return cell
    }
    
    
}

extension ListARKit: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: ARKit = VCFromSB(SB: .ARKit)
        self.present(vc, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let locationFirst = CGPoint(x: clvContent.center.x + scrollView.contentOffset.x, y: clvContent.center.y + scrollView.contentOffset.y)
        let locationSecond = CGPoint(x: clvContent.center.x + scrollView.contentOffset.x + 20, y: clvContent.center.y + scrollView.contentOffset.y)
        let locationThird = CGPoint(x: clvContent.center.x + scrollView.contentOffset.x - 20, y: clvContent.center.y + scrollView.contentOffset.y)
        
        if let indexPathFirst = clvContent.indexPathForItem(at: locationFirst), let indexPathSecond = clvContent.indexPathForItem(at: locationSecond), let indexPathThird = clvContent.indexPathForItem(at: locationThird), indexPathFirst.row == indexPathSecond.row && indexPathSecond.row == indexPathThird.row && indexPathFirst.row != pageControl.currentPage {
            pageControl.currentPage = indexPathFirst.row % compound.count
            self.animateChangingTitle(for: indexPathFirst)
        }
    }
}
