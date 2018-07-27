//
//  ProfileVC.swift
//  ARChemistry
//
//  Created by HHumorous on 7/20/18.
//  Copyright © 2018 HHumorous. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import ObjectMapper
import FirebaseFirestore

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
    var userDetail = UserDetail()
    var strAddress: String?
    var strDate: Date?
    var strGender: Int? = 0
    var strImage: UIImage?
    var strImageUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        fetchUserData()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let type = Config().user?.type as! Int? {
            switch type {
            case 0:
                switch mode {
                case .modeView:
                    self.updateNavigationBar(.BackEdit, "Profile");
                case .modeEdit:
                    self.updateNavigationBar(.BackDone, "Profile");
                }
            case 1:
                self.updateNavigationBar(.Menu, "Profile");
            default:
                self.updateNavigationBar(.Menu, "Profile");
            }
        }
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
    
    func updateData(_ user: UserDetail) {
        strDate = user.birthday
        strAddress = user.address
        strGender = user.gender as? Int
        strImageUrl = user.imageUrl
    }
    
    func fetchUserData() {
        
        if Auth.auth().currentUser != nil {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            let db = Firestore.firestore()
            db.collection("Users").document(uid).getDocument(completion: { (document, err) in
                if let user = document.flatMap({
                    $0.data().flatMap({ (data) in
                        return Mapper<User>().map(JSON: data)
                    })
                }) {
                    self.userDetail = user.user!
                    self.updateData(user.user!)
                    self.tbvContent.reloadData()
                    Config().setUser(user)
                    Config().user?.user?.imageUrl = self.userDetail.imageUrl
                } else {
                    print("Failed to fetch data")
                }
            })
        }
    }
    
    func saveNewUserDataToFirebase() {
        App().showHUDProgess(self.tbvContent)
        
        userDetail.address = strAddress
        userDetail.birthday = strDate
        userDetail.gender = strGender! as NSNumber
        userDetail.imageUrl = strImageUrl
        
        if let uid = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            db.collection("Users").document(uid).updateData(["user.address": strAddress!,
                                                             "user.birthday": strDate!,
                                                             "user.gender": strGender!,
                                                             "user.imageUrl": strImageUrl!]) { (err) in
                if let err = err {
                    App().hideHUDProgess("Error", "Failed to update with error \(err)", "", .text)
                } else {
                    App().hideHUDProgess("Success", "", "", .text)
                }
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
        let row: RowInSectionInfo = RowInSectionInfo(rawValue: indexPath.row)!
        
        switch sectionScreen {
        case .Avatar:
            return 250
        case .Info:
            switch row {
            case .Address, .Birthday, .Gender: do {
                if let type = Config().user?.type as! Int? {
                    switch type {
                    case 0:
                        return 50
                    case 1:
                        return 0
                    default:
                        return 50
                    }
                }
                return 50
                }
            case .Email:
                return 50
            }
            
        case .Logout:
            return 60
        case .ChangePassword:
            if let type = Config().user?.type as! Int? {
                switch type {
                case 0:
                    return 50
                case 1:
                    return 0
                default:
                    return 50
                }
            }
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionScreen:Section = Section(rawValue: indexPath.section)!
        
        switch sectionScreen {
        case .Avatar:
            let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "PAvatarCell", for: indexPath) as! ProfileCell
            if userDetail.imageUrl != nil {
                let url = URL(string: (userDetail.imageUrl)!)
                cell.imvIcon?.kf.setImage(with: url)
            } else {
                cell.imvIcon?.image = UIImage(named: "ic_user")
            }
            
            cell.imvIcon?.layer.cornerRadius = (cell.imvIcon?.frame.size.height)!/2
            
            cell.lblTitle?.text = userDetail.name
            
            switch mode {
            case .modeView:
                cell.btnChange?.isHidden = true
            case .modeEdit:
                cell.btnChange?.isHidden = false
            }
            cell.delegate = self
            
            return cell
        case .Info:
            let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "PInfoCell", for: indexPath) as! ProfileCell
            let row: RowInSectionInfo = RowInSectionInfo(rawValue: indexPath.row)!
            
            switch row {
            case .Address:
                cell.configura(.edit, row.title, userDetail.address)
            case .Email:
                cell.configura(nil, row.title, userDetail.email)
            case .Birthday:
                if userDetail.birthday == nil {
                    cell.configura(.calendar, row.title, dateToString(Date(), dateFormat: "dd-MM-yyyy"))
                } else {
                    cell.configura(.calendar, row.title, dateToString(userDetail.birthday!, dateFormat: "dd-MM-yyyy"))
                }
            case .Gender:
                cell.configura(.arrowDown, row.title, userDetail.gender == 0 ? "Male" : (userDetail.gender == 1 ? "Female" : "Please choose"))
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
            
            cell.delegate = self
            
            return cell
        }
        
    }
}

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionScreen:Section = Section(rawValue: indexPath.section)!
        if sectionScreen == .ChangePassword {
            let vc: ChangePassVC = VCFromSB(SB: .Profile)
            vc.user = self.userDetail
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
            
            tapToImageView()
            cell.imvIcon?.kf.setImage(with: URL(string: (self.strImageUrl)!))
            
            
        } else if sectionScreen == .ChangePassword {
            if indexPath?.row == 0 {
                let vc: ChangePassVC = VCFromSB(SB: .Profile)
                vc.user = self.userDetail
                self.navigationController?.pushViewController(vc, animated: true)
            }
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
                
                alert.addDatePicker(mode: .date, date: self.strDate!, minimumDate: nil, maximumDate: nil) { date in
                    self.strDate = date
                }
                alert.addAction(image: nil, title: "Done", color: AppColor.mainColor, style: .cancel, isEnabled: true) { (UIAlertAction) in
                    cell.lblSubTitle?.text = dateToString(self.strDate!, dateFormat: "dd-MM-yyyy")
                }
                alert.show()
                
            } else if row == .Gender {
                
                let alert = UIAlertController(style: .actionSheet, title: row.title, message: "Select your \(row.title)")

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

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func tapToImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {

            selectedImage = editedImage
            print("editedImage's size = \(editedImage.size)")
            
        } else if let originImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = originImage
            print("originImage's size = \(originImage.size)")
        }
        self.strImage = selectedImage
        if selectedImage != nil {
            App().showHUDProgess(self.tbvContent)
            let randomString = UUID().uuidString
            let storageRef = Storage.storage().reference().child("\(randomString).png")
            //Image uploaded to Firebase must be Data, not UIImage
            if let uploadImage = UIImagePNGRepresentation(self.strImage!) {
                storageRef.putData(uploadImage, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    storageRef.downloadURL(completion: { (url, err) in
                        if err == nil {
                            if url != nil {
                                self.strImageUrl = url?.absoluteString
                                App().hideHUDProgess("Success", "", "ic_check", .customView)
                            }
                        }
                    })
                })
            }
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
