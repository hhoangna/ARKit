//
//  ProfileVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/20/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ObjectMapper

enum ModeScreen {
    case modeView;
    case modeEdit;
}

enum Section:Int {
    case Avatar = 0
    case Info
    case ChangePassword
    case Logout
    
    static let count: Int = {
        var max: Int = 0
        while let _ = Section(rawValue: max) { max += 1 }
        return max
    }()
}

enum RowInSectionInfo: Int {
    case Email = 0
    case Gender
    case Birthday
    case Address
    
    static let count: Int = {
        var max: Int = 0
        while let _ = RowInSectionInfo(rawValue: max) { max += 1 }
        return max
    }()
    
    var title: String {
        switch self {
        case .Email:
            return "Email"
        case .Gender:
            return "Gender"
        case .Birthday:
            return "Birthday"
        case .Address:
            return "Address"
        }
    }
}

class ProfileVC: BaseVC {
    
    @IBOutlet weak var tbvContent: UITableView!
    
    var mode: ModeScreen = .modeView
    var user = UserDto.User()
    var strAddress: String?
    var strDate: String?
    var strGender: Int? = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        switch mode {
        case .modeView:
            self.updateNavigationBar(.BackEdit, "Profile");
        case .modeEdit:
            self.updateNavigationBar(.BackDone, "Profile");
        }
        tbvContent?.reloadData()
    }
    
    func initData() {
        strDate = user.birthday
        strAddress = user.address
        strGender = user.gender
    }
    
    func saveNewUserDataToFirebase() {
        App().showHUDProgess(self.tbvContent)
        
        user.address = strAddress
        user.birthday = strDate
        user.gender = strGender
        
        let ref = Database.database().reference().child("users/\((Config().user?.token)!)")
        ref.updateChildValues(["address": user.address!,
                               "birthday": user.birthday!,
                               "gender": user.gender!]) { (err, ref: DatabaseReference) in
                                if let err = err {
                                    App().hideHUDProgess("Error", "Failed to update with error \(err)", "", .text)
                                } else {
                                    App().hideHUDProgess("Success", "", "", .text)
                                }
        }
    }
    
}

extension ProfileVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionScreen:Section = Section(rawValue: section)!
        switch sectionScreen {
        case .Avatar:
            return 1
        case .Info:
            return RowInSectionInfo.count
        case .Logout:
            return 1
        case .ChangePassword:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionScreen:Section = Section(rawValue: indexPath.section)!
        switch sectionScreen {
        case .Avatar:
            return 250
        case .Info:
            return 50
        case .Logout:
            return 60
        case .ChangePassword:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionScreen:Section = Section(rawValue: indexPath.section)!
        
        switch sectionScreen {
        case .Avatar:
            let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "PAvatarCell", for: indexPath) as! ProfileCell
            let url = URL(string: (user.imageUrl)!)

            cell.imvIcon?.layer.cornerRadius = (cell.imvIcon?.frame.size.height)!/2
            cell.imvIcon?.kf.setImage(with: url)
            cell.lblTitle?.text = user.name
            
            switch mode {
            case .modeView:
                cell.btnChange?.isHidden = true
            case .modeEdit:
                cell.btnChange?.isHidden = false
            }
            
            return cell
        case .Info:
            let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "PInfoCell", for: indexPath) as! ProfileCell
            let row: RowInSectionInfo = RowInSectionInfo(rawValue: indexPath.row)!
            
            switch row {
            case .Address:
                cell.configura(.edit, row.title, user.address)
            case .Email:
                cell.configura(nil, row.title, user.email)
            case .Birthday:
                cell.configura(.calendar, row.title, user.address)
                cell.configura(.calendar, row.title, user.birthday)
            case .Gender:
                cell.configura(.arrowDown, row.title, user.gender == 0 ? "Male" : (user.gender == 1 ? "Female" : "Please choose"))
            }
            
            switch mode {
            case .modeView:
                cell.csWidEditButton?.constant = 0
            case .modeEdit:
                cell.csWidEditButton?.constant = (row == .Email ? 0 : 25)
            }
            
            cell.delegate = self
            
            return cell
        case .Logout:
            let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "PLogoutCell", for: indexPath) as! ProfileCell
            
            cell.delegate = self
            
            return cell
        case .ChangePassword:
            let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "PChangePasswordCell", for: indexPath) as! ProfileCell
            
            return cell
        }
        
    }
}

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionScreen:Section = Section(rawValue: indexPath.section)!
        if sectionScreen == .ChangePassword {
            let vc: ChangePassVC = VCFromSB(SB: .Profile)
            vc.user = self.user
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProfileVC: ProfileCellDelegate {
    func didSelectRightButton(cell: ProfileCell, btn: UIButton) {
        let indexPath = tbvContent.indexPath(for: cell)
        
        let row: RowInSectionInfo = RowInSectionInfo(rawValue: indexPath!.row)!
        let sectionScreen:Section = Section(rawValue: indexPath!.section)!
        if sectionScreen == .Avatar {
            
        } else if sectionScreen == .ChangePassword {
            let vc: ChangePassVC = VCFromSB(SB: .Profile)
            vc.user = self.user
            self.navigationController?.pushViewController(vc, animated: true)
        } else if sectionScreen == .Info {
            if row == .Address {
                
                let alert = UIAlertController(style: .actionSheet, title: row.title, message: "Change your \(row.title)")
                
                let textField: TextField.Config = { textField in
                    textField.left(image: #imageLiteral(resourceName: "pen"), color: .black)
                    textField.leftViewPadding = 12
                    textField.becomeFirstResponder()
                    textField.borderWidth = 1
                    textField.cornerRadius = 8
                    textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
                    textField.backgroundColor = nil
                    textField.textColor = .black
                    textField.placeholder = self.strAddress
                    textField.keyboardAppearance = .default
                    textField.keyboardType = .default
                    //textField.isSecureTextEntry = true
                    textField.returnKeyType = .done
                    textField.action { textField in
                        Log("textField = \(String(describing: textField.text))")
                        self.strAddress = textField.text!
                    }
                }
                
                alert.addOneTextField(configuration: textField)
                
                alert.addAction(image: nil, title: "Done", color: AppColor.mainColor, style: .cancel, isEnabled: true) { (UIAlertAction) in
                    cell.lblSubTitle?.text = self.strAddress
                }
                alert.show()
                
            } else if row == .Birthday {
                
                let alert = UIAlertController(style: .actionSheet, title: row.title, message: "Select your \(row.title)")
                alert.addDatePicker(mode: .date, date: stringToDate(self.strDate!), minimumDate: nil, maximumDate: nil) { date in
                    self.strDate = dateToString(date, dateFormat: "dd-MM-yyyy")
                }
                alert.addAction(image: nil, title: "Done", color: AppColor.mainColor, style: .cancel, isEnabled: true) { (UIAlertAction) in
                    cell.lblSubTitle?.text = self.strDate
                }
                alert.show()
                
            } else if row == .Gender {
                
                let alert = UIAlertController(style: .actionSheet, title: row.title, message: "Select your \(row.title)")
                
                //            let arrGender: [String] = ["Male", "Female"]
                let pickerViewValues: [String] = ["Male", "Female"]
                let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: 0)
                
                alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
                    self.strGender = index.row
                }
                alert.addAction(image: nil, title: "Done", color: AppColor.mainColor, style: .cancel, isEnabled: true) { (UIAlertAction) in
                    cell.lblSubTitle?.text = self.strGender == 0 ? "Male" : (self.strGender == 1 ? "Female" : "Please choose")
                }
                alert.show()
            }
        }
    }
    
    func didSelectLogoutButton(cell: ProfileCell, btn: UIButton) {
        let signOutAction = UIAlertAction(title: "Log out", style: .destructive) { (action) in
            do {
                try Auth.auth().signOut()
                    App().onReLogin()
                    Config().setUser(nil)
            } catch let err {
                print("Failed to sign out with error", err)
                showAlert(on: self, style: .alert, title: "Sign Out Error", message: err.localizedDescription)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            showAlert(on: self, style: .actionSheet, title: nil, message: nil, actions: [signOutAction, cancelAction], completion: nil)
    }
}

extension ProfileVC: CustomNavigationDelegate {
    
    func didSelectedBackOrMenu() {
        //
    }
    
    func didSelectedRightButton() {
        switch mode {
        case .modeView:
            mode = .modeEdit
            updateUI()
        case .modeEdit:
            mode = .modeView
            updateUI()
            saveNewUserDataToFirebase()
        }
    }
}
