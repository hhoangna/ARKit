//
//  TabBarTopView.swift
//  VSip-iOS
//
//  Created by HHumorous on 7/6/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

struct TabBarItem {
    var title:String?
    
    init(_ name:String) {
        self.title = name;
    }
}

protocol TabBarTopViewDelegate {
    func didSelectedTabBarTopItem(tabBarTopItemView:TabBarTopView, indexBarItem: Int)
}

class TabBarTopView: UIView {
    
    
    @IBOutlet weak var clvContent:UICollectionView?
    @IBOutlet weak var vLineColor:UIView?
    @IBOutlet weak var conLeftvLineColor:NSLayoutConstraint?
    @IBOutlet weak var conWidthvLineColor:NSLayoutConstraint?
    
    fileprivate let tabBarTopIndentifierCell = "TabBarTopViewCell"
    
    var delegate:TabBarTopViewDelegate?
    
    var indexSelected = 0
    
    var tabBarTopItems:[TabBarItem]!{
        didSet{
            setupViewColorSelect()
            clvContent?.reloadData()
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView()  {
        clvContent?.delegate = self;
        clvContent?.dataSource = self;
        
        clvContent?.register(UINib.init(nibName: ClassName(TabBarTopViewCell()), bundle: nil), forCellWithReuseIdentifier: tabBarTopIndentifierCell)
    }
    
    func setupViewColorSelect() {
        vLineColor?.backgroundColor = AppColor.white
        conWidthvLineColor?.constant = self.frame.size.width * 0.9 / CGFloat(tabBarTopItems.count)
    }
    
}

extension TabBarTopView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / CGFloat(tabBarTopItems.count), height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


//MARK: - UICollectionViewDataSource
extension TabBarTopView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarTopItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row;
        let cell:TabBarTopViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: tabBarTopIndentifierCell, for: indexPath) as! TabBarTopViewCell
        
        if let barItems = self.tabBarTopItems{
            let barItem = barItems[row];
            
            cell.lblTitle?.text = barItem.title
            
            if row == indexSelected{
                if (indexSelected == 0) {
                    cell.lblTitle?.backgroundColor = colorWithGradient((cell.lblTitle?.frame.size.height)!, AppColor.purpleColor, AppColor.mainColor)
                } else {
                    cell.lblTitle?.backgroundColor = colorWithGradient((cell.lblTitle?.frame.size.height)!, AppColor.redColor, AppColor.yellowColor)
                }
                cell.lblTitle?.textColor = AppColor.white
                cell.lblTitle?.font = AppFont.helveticaBold(with: 15)
            }else {
                if (indexSelected == 1) {
                    cell.lblTitle?.textColor = colorWithGradient((cell.lblTitle?.frame.size.height)!, AppColor.purpleColor, AppColor.mainColor)
                } else {
                    cell.lblTitle?.textColor = colorWithGradient((cell.lblTitle?.frame.size.height)!, AppColor.redColor, AppColor.yellowColor)
                }
                cell.lblTitle?.backgroundColor = AppColor.white
                cell.lblTitle?.font = AppFont.helveticaRegular(with: 15)
            }
        }
        
        return cell;
    }
    
}


//MARK: - UICollectionViewDelegate
extension TabBarTopView:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        updateContraintViewSelectedEndDecelerating()
        clvContent?.reloadData()
        delegate?.didSelectedTabBarTopItem(tabBarTopItemView: self, indexBarItem: indexSelected)
    }
}


//MARK: - OtherFuntion
extension TabBarTopView {
    func updateContraintViewSelectedDidScroll(_ scrollView:UIScrollView) {
        let width = self.frame.size.width
        let contentOffsetX = scrollView.contentOffset.x;
        
        conLeftvLineColor?.constant = ((contentOffsetX / width) * width ) / CGFloat(tabBarTopItems.count)
    }
    
    func updateContraintViewSelectedEndDecelerating(){
        let width = self.frame.size.width
        conLeftvLineColor?.constant = (CGFloat(indexSelected) * width ) / CGFloat(tabBarTopItems.count)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x;
        let width = self.frame.size.width
        indexSelected = Int(contentOffsetX / width);
        clvContent?.reloadData()
    }
}
