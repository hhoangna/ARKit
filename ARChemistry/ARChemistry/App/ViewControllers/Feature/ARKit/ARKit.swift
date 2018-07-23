//
//  ARKit.swift
//  ARChemistry
//
//  Created by HHumorous on 7/9/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

//class ARKit: BaseVC {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        print(SWIDTH(), SHEIGHT())
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.updateNavigationBar(.Menu, "View in AR");
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}


// MARK: - Configurable constants
private let itemHeight: CGFloat = 84
private let lineSpacing: CGFloat = 20
private let xInset: CGFloat = 20
private let topInset: CGFloat = 10

class ARKit: BaseVC {
    fileprivate let cellId = "ShareCell"
    @IBOutlet private weak var clvContent: UICollectionView!
    fileprivate var shares: [Share] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shares = SharesHelper.generateShares()
        let nib = UINib(nibName: cellId, bundle: nil)
        clvContent.register( nib, forCellWithReuseIdentifier: cellId)
        clvContent.contentInset.bottom = itemHeight
        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
        guard let layout = clvContent.collectionViewLayout as? SubTableVCFowLayout else { return }
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        let itemWidth = UIScreen.main.bounds.width - 2 * xInset
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        clvContent.collectionViewLayout.invalidateLayout()
    }
}

extension ARKit: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clvContent.dequeueReusableCell(withReuseIdentifier: "ShareCell", for: indexPath) as! ShareCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
