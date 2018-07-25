//
//  SubCollectionVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/22/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import FirebaseFirestore

//with itemSize: CGSize

private let itemHeight: CGFloat = 100
private let collectionViewCellHeightCoefficient: CGFloat = 0.65
private let collectionViewCellWidthCoefficient: CGFloat = 0.45

class SubCollectionVC: UICollectionViewController {
    
    var element = [ElementDto]()
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        loadElement()
        
        setupTableView()
//        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
        collectionView?.collectionViewLayout.invalidateLayout()

    }
    
    func loadElement() {
        db.collection("Elements").order(by: "atom", descending: false).getDocuments { (snapshot, err) in
            if let err = err {
                print("\(err.localizedDescription)")
            }else{
                DispatchQueue.main.async {
                    self.element = snapshot!.documents.compactMap({ElementDto(dictionary: $0.data())})
                    self.collectionView?.reloadData()
                }
            }
        }
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
        
        let elementDetail = element[indexPath.row]
        cell.configureWith(elementDetail)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return element.count
    }
}

