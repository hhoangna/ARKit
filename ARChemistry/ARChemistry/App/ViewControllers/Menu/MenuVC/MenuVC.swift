//
//  MenuVC.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/7/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit
import FirebaseAuth
import ObjectMapper
import FirebaseFirestore
import Kingfisher

class MenuVC: BaseVC {
    
    enum AR_Feature {
        case AR_Element;
        case AR_PredicTable;
        case AR_Camera;
        case AR_Setting
    }
    
    @IBOutlet weak var tbvContent:UITableView?

    var arrData:[Array<Any>]?
    var curentFeature:AR_Feature?
    var userDetail: UserDetail = (Config().user?.user)!
    
    fileprivate static let MenuProfileIdentifierCell:String = "MenuProfileCell"
    fileprivate static let MenuLogoutIdentifierCell:String = "MenuLogoutCell"
    fileprivate static let MenuRowIdentifierCell:String = "MenuRowCell"


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initVar()
    }
    
    func initVar() {
        curentFeature = .AR_Element
        initArrData()
    }
    
    func initArrData() {
        arrData = Array()
        arrData?.append(["Chemical Element",AR_Feature.AR_Element,"ic_element"])
        arrData?.append(["Periodic Table",AR_Feature.AR_PredicTable,"ic_table"])
        arrData?.append(["View in AR",AR_Feature.AR_Camera,"ic_arkit"])
        arrData?.append(["Setting",AR_Feature.AR_Setting,"ic_setting"])

    }
    
    func setUpTableView()  {
        tbvContent?.delegate = self;
        tbvContent?.dataSource = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableViewDataSource
extension MenuVC:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header:MenuCell = self.tbvContent?.dequeueReusableCell(withIdentifier: MenuVC.MenuProfileIdentifierCell) as! MenuCell;
        if Config().user?.user?.imageUrl != nil {
            let url = URL(string: (Config().user?.user?.imageUrl)!)
            header.imvAvatar?.kf.setImage(with: url)
            header.imvAvatar?.kf
        } else {
            header.imvAvatar?.image = UIImage(named: "ic_user")
        }
        
        header.lblTitle?.text = Config().user?.user?.name
        header.lblSubTitle?.text = Config().user?.user?.email
        
        header.delegate = self;
        return header;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuCell = self.tbvContent?.dequeueReusableCell(withIdentifier: MenuVC.MenuRowIdentifierCell, for: indexPath) as! MenuCell;
        
        let row = indexPath.row;
        if let data:Array = arrData?[row] {
            cell.tag = (data[1] as! AR_Feature).hashValue;
            if let image = UIImage.init(named: data[2] as! String) {
                cell.imvIcon?.image = image.withRenderingMode(.alwaysTemplate)
            }
            
            cell.lblTitle?.text = (data[0] as! String);
            if curentFeature?.hashValue == row {
                cell.lblTitle?.textColor = AppColor.mainColor
                cell.imvIcon?.tintColor =  AppColor.mainColor

            }else {
                cell.lblTitle?.textColor = .black;
                cell.imvIcon?.tintColor =  .black;
            }
        }
        
        cell.selectionStyle = .none
        
        return cell;
    }
    
}

//MARK: - UITableViewDelegate
extension MenuVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        App().mainVC?.showSlideMenu(isShow: false, animation: true)
        let row = indexPath.row;
        guard let feature: AR_Feature = arrData![row][1] as? AR_Feature else {
            return;
        }
        
        var vc:BaseVC?;
        
        switch feature {
        case .AR_Element:
            vc = VCFromSB(ElementListVC(), SB: .Element)
            break
        case .AR_PredicTable:
            vc = VCFromSB(PeriodicTableVC(), SB: .PeriodicTable)
            break
    
        case .AR_Camera:
            vc = VCFromSB(ARKit(), SB: .ARKit)
            break
            
        case .AR_Setting:
            vc = VCFromSB(SettingVC(), SB: .Setting)
            break
        }
 
        if curentFeature != feature {
            if let vc = vc {
                App().mainVC?.rootNV?.setViewControllers([vc], animated: false)
                curentFeature = feature;
                
                tableView.reloadData()
            }
        }
    }
}


//MARK: - UITableViewDelegate
extension MenuVC:MenuCellDelegate {
    func didSelectedLogout(cell: MenuCell, btn: UIButton) {
        //menuPresenter.logout()
    }
    
    func didSelectedProfile(cell: MenuCell, btn: UIButton) {
        let vc: ProfileVC = VCFromSB(ProfileVC(), SB: .Profile)
        vc.navigationController?.setNavigationBarHidden(false, animated: true)
        App().mainVC?.rootNV?.setViewControllers([vc], animated: false)
        App().mainVC?.showSlideMenu(isShow: false, animation: true)
        curentFeature = nil
    }
}

