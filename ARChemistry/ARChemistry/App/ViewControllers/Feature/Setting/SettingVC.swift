//
//  SettingVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/9/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit

private let itemHeight: CGFloat = 84
private let lineSpacing: CGFloat = 20
private let xInset: CGFloat = 20
private let topInset: CGFloat = 10

class SettingVC: BaseVC {
    
    @IBOutlet weak var clvContent: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        clvContent.collectionViewLayout = PeriodicCellFlow(style: .regular)
        let nib = UINib(nibName: "PeriodicCell", bundle: nil)
        clvContent.register( nib, forCellWithReuseIdentifier: "PeriodicCell")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateNavigationBar(.Menu, "Setting");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureCollectionViewLayout() {
        guard let layout = clvContent.collectionViewLayout as? PeriodicCellFlow else { return }
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        let itemWidth = UIScreen.main.bounds.width - 2 * xInset
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        clvContent.collectionViewLayout.invalidateLayout()
    }

}

extension SettingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PeriodicCell = clvContent.dequeueReusableCell(withReuseIdentifier: "PeriodicCell", for: indexPath) as! PeriodicCell
        
        return cell
    }
}

extension SettingVC: UICollectionViewDelegate {
    
}
