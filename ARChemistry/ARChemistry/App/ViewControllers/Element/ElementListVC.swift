//
//  ElementListVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/22/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import FirebaseFirestore
import McPicker

private let itemHeight: CGFloat = 100
private let lineSpacing: CGFloat = 20
private let xInset: CGFloat = 20
private let topInset: CGFloat = 20

class ElementListVC: BaseVC {
    
    @IBOutlet weak var clvContent: UICollectionView!
    var element = [ElementDto]()
    var elementDisplay = [ElementDto]()
    var db: Firestore!
    var orderBy: String = "atom"
    
    lazy var layout = SubTableVCFowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.delegate = self
    
        setupTableView()
        
        db = Firestore.firestore()
        loadElement(orderBy)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateNavigationBar(.MenuSort, "Chemical Element")
    }
    
    private func loadElement(_ order: String) {
        
        db.collection("Elements").order(by: order, descending: false).getDocuments { (snapshot, err) in
            if let err = err {
                print("\(err.localizedDescription)")
            }else{
                DispatchQueue.main.async {
                    self.element = snapshot!.documents.compactMap({ElementDto(dictionary: $0.data())})
                    self.elementDisplay = self.element
                    self.clvContent.reloadData()
                }
            }
        }
    }
    
    fileprivate func setupTableView() {
        
        clvContent.allowsSelection = true
        clvContent.collectionViewLayout = layout
        layout.scrollDirection = .vertical
        
        let nib = UINib(nibName: "ElementTableCell", bundle: nil)
        
        clvContent.register(nib, forCellWithReuseIdentifier: "ElementTableCell")
        clvContent.register(SearchBarCell.self, forCellWithReuseIdentifier: "SearchBarCell.identifier")
        clvContent.contentInset.bottom = itemHeight
    }
}

extension ElementListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 44)
        case 1:
            let itemWidth = UIScreen.main.bounds.width - 2 * xInset
            return CGSize(width: itemWidth, height: itemHeight)
        default:
            assert(false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets.zero
        case 1:
            return UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        default:
            assert(false)
        }
    }
}

extension ElementListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return elementDisplay.count
        default:
            assert(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBarCell.identifier", for: indexPath) as! SearchBarCell
            
            cell.searchBar.delegate = self
            cell.searchBar.searchBarStyle = .minimal
            cell.searchBar.placeholder = "Search element by name, symbol"
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementTableCell", for: indexPath) as! ElementTableCell
            
            let elementDetail = elementDisplay[indexPath.row]
            cell.configureWith(elementDetail)
            
            return cell
        default:
            assert(false)
        }
    }
}

extension ElementListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let elementDetail = elementDisplay[indexPath.row]
        
        let link = convertStringToNeededLink(elementDetail.name)
        
        WebVC.showWebViewWithUrl(URL(string: link)!)
    }
}

extension ElementListVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollView === self.clvContent else { return }
        let indexPath = IndexPath(item: 0, section: 0)
        guard let cell = self.clvContent.cellForItem(at: indexPath) as? SearchBarCell else {
            return
        }
        cell.searchBar.resignFirstResponder()
    }
}

extension ElementListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.elementDisplay = self.element
        }
        else {
            self.elementDisplay = self.element.filter({ $0.symbol.hasPrefix(searchText) || $0.name.hasPrefix(searchText)
            })
        }
        self.clvContent.reloadSections([1])
    }
}

extension ElementListVC: CustomNavigationDelegate {
    func didSelectedBackOrMenu() {
        //
    }
    
    func didSelectedRightButton() {
        let data = ["Name", "Symbol", "Atom", "Type"]
        McPicker.showAsPopover(data: [data], fromViewController: self, sourceView: nil, sourceRect: nil, barButtonItem: self.navigationItem.rightBarButtonItem) { [weak self](selections: [Int: String]) -> Void in
            if let mode = selections[0] {
                switch mode {
                case "Name":
                    self?.orderBy = "name"
                case "Symbol":
                    self?.orderBy = "symbol"
                case "Atom":
                    self?.orderBy = "atom"
                case "Type":
                    self?.orderBy = "type"
                default:
                    self?.orderBy = "atom"
                }
            }
            self?.loadElement((self?.orderBy)!)
            self?.clvContent.reloadSections([1])
        }
        
    }
}
