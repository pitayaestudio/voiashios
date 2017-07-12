//
//  VOEditProfileVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/10/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import TextFieldEffects
import FBSDKLoginKit
import QorumLogs

class VOEditProfileVC: VOBaseVC {

    @IBOutlet weak var tfName: TextFieldEffects!
    @IBOutlet weak var tfLastName: TextFieldEffects!
    @IBOutlet weak var tfEmail: TextFieldEffects!
    @IBOutlet weak var tfAge: TextFieldEffects!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var vBlur:UIVisualEffectView!
    
    var birthDay:Date!
    var imagePicker: UIImagePickerController!
    var imgData:Data?
    var picker:GBHFacebookImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vBlur.isHidden = true
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupScreen(){
        imgAvatar.layer.masksToBounds = true
        imgAvatar.layer.borderWidth = 3.0
        imgAvatar.layer.borderColor = UIColor.white.cgColor
        imgAvatar.layer.cornerRadius = 42
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        if let user = VOFBDataService.shared.myUser {
            tfName.text = user.name
            tfLastName.text = user.lastName
            tfEmail.text = user.email
            
            if let age = user.birthday {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                self.birthDay = dateFormatter.date(from: age)
                
                tfAge.text = age
            }
            if let url = user.urlAvatar {
                DispatchQueue.main.async() {
                    self.imgAvatar.kf.setImage(with: url)
                }
            }
        }
    }
    
    //MARK: - Facebook
    func setFBPicker(){
        // Init picker
        self.picker = GBHFacebookImagePicker()
        
        // Selected border color
        GBHFacebookImagePicker.pickerConfig.uiConfig.selectedBorderColor = K.color.colorRed
        
        // Selected border width
        GBHFacebookImagePicker.pickerConfig.uiConfig.selectedBorderWidth = 4.0
        
        // Present picker
        self.picker!.presentFacebookAlbumImagePicker(from: self,
                                               delegate: self)
    }
    
    func loginToFacebook(){
        if appDel.facebookLogin == nil {
            appDel.facebookLogin = FBSDKLoginManager()
        }
        self.vBlur.isHidden = false
        appDel.isFBActive = true
        appDel.facebookLogin!.logIn(withReadPermissions: ["public_profile", "email", "user_birthday", "user_photos"], from: self) { (result, error) in
            appDel.isFBActive = false
            self.vBlur.isHidden = true
            if error != nil {
                QL4("BSC:: " + error.debugDescription)
                appDel.facebookLogin!.logOut()
            } else if result?.isCancelled == true {
                QL4("BSC:: User cancelled facebook auth" )
                appDel.facebookLogin!.logOut()
            } else {
                QL2("BSC:: Successfully auth FaceBook")
                self.setFBPicker()
                let newData: Dictionary<String, Any>! = [K.FB.user.fbToken:"\(FBSDKAccessToken.current()!.tokenString!)"]
                VOFBDataService.shared.updateMyUserWithData(newData: newData)
            }
        }
    }
    
    //MARK: - Image
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.showAlert(typeAlert: .warning, message: NSLocalizedString("warningCamera", comment: ""))
        }
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func closeScreen(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Age
    func datePickerValueChanged(_ sender: UIDatePicker) {
        self.birthDay = sender.date
       /* let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none*/
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        tfAge.text = dateFormatter.string(from: sender.date)
    }
    
    //MARK: - IBAction
    @IBAction func ageFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.maximumDate = K.ageValidation.maximum
        datePickerView.minimumDate = K.ageValidation.minimum
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: .valueChanged)
        
    }
    
    @IBAction func cancelBtnPressed(){
        self.closeScreen()
    }
    
    @IBAction func saveBtnPressed(){
        guard  (tfName.text != nil)  && !(tfName.text?.isBlank)! else {
            self.showAlert(typeAlert:.error, message:NSLocalizedString("nameRequired", comment: ""))
            return
        }
        guard (tfLastName.text != nil) && !(tfLastName.text?.isBlank)!  else {
            self.showAlert(typeAlert:.error, message:NSLocalizedString("lastNameRequired", comment: ""))
            return
        }
        guard self.birthDay != nil  else {
            self.showAlert(typeAlert:.error, message:NSLocalizedString("birthdayRequired", comment: ""))
            return
        }
       /* if !self.birthDay.isValidAge {
            self.showAlert(typeAlert:.error, message:NSLocalizedString("invalidAge", comment: ""))
            return nil
        }*/
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate: String = dateFormatter.string(from: self.birthDay)
        
        if self.imgData != nil {
            vBlur.isHidden = false
        }
        VOFBDataService.shared.updateMyUser(name: tfName.text!.capitalized, lastName: tfLastName.text!.capitalized, age: selectedDate, data: self.imgData) { (error) in
            if self.imgData != nil {
                self.vBlur.isHidden = true
            }
            if let error = error {
                self.showAlert(typeAlert:.error, message:error)
            }else{
                self.closeScreen()
            }
        }
    }
    
    @IBAction func changePhotoBtnPressed(){
        let alert = UIAlertController(title: NSLocalizedString("titChooseImage", comment: ""), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("titCamera", comment: ""), style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("titGallery", comment: ""), style: .default, handler: { _ in
            self.openGallary()
        }))
      
        alert.addAction(UIAlertAction(title: NSLocalizedString("titFacebook", comment: ""), style: .default, handler: { _ in
           // if VOFBDataService.shared.myUser!.provider == K.provider.fb || FBSDKAccessToken.current() != nil{
            if FBSDKAccessToken.current() != nil || VOFBDataService.shared.myUser?.fbToken != nil {
                self.setFBPicker()
            }else{
                self.loginToFacebook()
            }
        }))
        
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("actCancel", comment: ""), style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}

extension VOEditProfileVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            if let imgData = UIImageJPEGRepresentation(image, 0.2) {
                self.imgData = imgData
                imgAvatar.image = image
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension VOEditProfileVC: GBHFacebookImagePickerDelegate {
    
    // MARK: - GBHFacebookImagePicker Protocol
    func facebookImagePicker(imagePicker: UIViewController,
                             successImageModels: [GBHFacebookImage],
                             errorImageModels: [GBHFacebookImage],
                             errors: [Error?]) {
        // Append selected image(s)
        // Do what you want with selected image
        if let image = successImageModels[0].image {
            if let imgData = UIImageJPEGRepresentation(image, 0.2) {
                self.imgData = imgData
                imgAvatar.image = image
            }
        }
    }
    
    func facebookImagePicker(imagePicker: UIViewController, didFailWithError error: Error?) {
        QL3("Cancelled Facebook Album picker with error")
    }
    
    // Optional
    func facebookImagePicker(didCancelled imagePicker: UIViewController) {
        QL3("Cancelled Facebook Album picker")
    }
    
    // Optional
    func facebookImagePickerDismissed() {
        QL3("Picker dismissed")
    }
}
