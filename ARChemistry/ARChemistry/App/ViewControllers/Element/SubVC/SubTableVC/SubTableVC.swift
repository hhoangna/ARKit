//
//  SubTableVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/22/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import FirebaseFirestore
import ObjectMapper

// MARK: - Configurable constants
private let itemHeight: CGFloat = 84
private let lineSpacing: CGFloat = 20
private let xInset: CGFloat = 20
private let topInset: CGFloat = 20

class SubTableVC: UICollectionViewController {
    
    var element = [ElementDto]()
    var db: Firestore!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        loadElement()
        
        setupTableView()
        configureCollectionViewLayout()
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

    private func configureCollectionViewLayout() {
        guard let layout = collectionView?.collectionViewLayout as? SubTableVCFowLayout else { return }
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        let itemWidth = UIScreen.main.bounds.width - 2 * xInset
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionView?.collectionViewLayout.invalidateLayout()
    }

    fileprivate func setupTableView() {
        
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.allowsSelection = true

        let nib = UINib(nibName: "ElementTableCell", bundle: nil)
        
        collectionView?.register(nib, forCellWithReuseIdentifier: "ElementTableCell")
        collectionView?.contentInset.bottom = itemHeight
    }

    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementTableCell", for: indexPath) as! ElementTableCell
        
        let elementDetail = element[indexPath.row]
        cell.configureWith(elementDetail)
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return element.count
    } 
}
