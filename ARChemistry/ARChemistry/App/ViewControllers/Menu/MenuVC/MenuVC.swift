//
//  MenuVC.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/7/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import UIKit

class MenuVC: BaseVC {
    
    enum GW_Feature {
        case GWF_Working;
        case GWF_History;
        case GWF_Earning;
        case GWF_Team ;
        case GWF_Setting;
        case GWF_Terms
    }
    
    @IBOutlet weak var tbvContent:UITableView?

    
    var arrData:[Array<Any>]?
    var curentFeature:GW_Feature?
    
    fileprivate static let MenuProfileIdentifierCell:String = "MenuProfileCell"
    fileprivate static let MenuLogoutIdentifierCell:String = "MenuLogoutCell"
    fileprivate static let MenuRowIdentifierCell:String = "MenuRowCell"


    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        initVar()
    }
    
    func initVar() {
        curentFeature = .GWF_Working
        initArrData()
    }
    
    func initArrData() {
        arrData = Array()
        arrData?.append(["Working",GW_Feature.GWF_Working,"ic-Working"])
        arrData?.append(["History",GW_Feature.GWF_History,"ic-History"])
        arrData?.append(["Earning",GW_Feature.GWF_Earning,"ic-Earning"])
        arrData?.append(["Team",GW_Feature.GWF_Team,"ic-Team"])
        arrData?.append(["Setting",GW_Feature.GWF_Setting,"ic-Setting"])
        arrData?.append(["Terms & Conditions",GW_Feature.GWF_Team,"ic-Terms"])

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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        let heightFooter = SHEIGHT() - ((CGFloat(self.arrData?.count ?? 0) * CGFloat(60.0)) +  CGFloat(100))

        return (heightFooter >= 60) ? heightFooter : 60;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header:MenuCell = self.tbvContent?.dequeueReusableCell(withIdentifier: MenuVC.MenuProfileIdentifierCell) as! MenuCell;
        
        header.lblTitle?.text = Config().user?.user?.userId;
        header.lblSubTitle?.text = Config().user?.user?.email;
        header.delegate = self;
        return header;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer:MenuCell = self.tbvContent?.dequeueReusableCell(withIdentifier: MenuVC.MenuLogoutIdentifierCell) as! MenuCell;
        footer.delegate = self;
        return footer;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuCell = self.tbvContent?.dequeueReusableCell(withIdentifier: MenuVC.MenuRowIdentifierCell, for: indexPath) as! MenuCell;
        
        let row = indexPath.row;
        if let data:Array = arrData?[row] {
            cell.tag = (data[1] as! GW_Feature).hashValue;
            if let image = UIImage.init(named: data[2] as! String) {
                cell.imvIcon?.image = image.withRenderingMode(.alwaysTemplate)
            }
            
            cell.lblTitle?.text = (data[0] as! String);
            if curentFeature?.hashValue == row {
                cell.lblTitle?.textColor = Color.blueHeader;
                cell.imvIcon?.tintColor =  Color.blueHeader;

            }else {
                cell.lblTitle?.textColor = Color.black;
                cell.imvIcon?.tintColor =  Color.black;
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
        guard let feature: GW_Feature = arrData![row][1] as? GW_Feature else {
            return;
        }
        
        /*
        var vc:BaseVC?;
        
        switch feature {
        case .GWF_Working:
            vc = VCFromSB(WorkingListVC(), SB: .Working)
            break
            
        case .GWF_History:
            vc = VCFromSB(HistoryListVC(), SB: .History)
            break
        case .GWF_Earning:
            vc = VCFromSB(EarningListVC(), SB: .Earning)

            break
        case .GWF_Setting:
            vc = VCFromSB(SettingVC(), SB: .Setting)

            break
        case .GWF_Team:
            vc = VCFromSB(TeamListVC(), SB: .Team)

            break
        case .GWF_Terms:
            vc = VCFromSB(TermsConditionsVC(), SB: .TeamsConditions)

            break
        }
 
        if curentFeature != feature {
            if let vc = vc {
                App().mainVC?.rootNV?.setViewControllers([vc], animated: false)
                curentFeature = feature;
                
                tableView.reloadData()
            }
        }
         */
    }
}


//MARK: - UITableViewDelegate
extension MenuVC:MenuCellDelegate {
    func didSelectedLogout(cell: MenuCell, btn: UIButton) {
        //menuPresenter.logout()
    }
    
    func didSelectedProfile(cell: MenuCell, btn: UIButton) {
        //
    }
}

