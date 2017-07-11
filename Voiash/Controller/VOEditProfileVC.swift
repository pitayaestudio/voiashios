//
//  VOEditProfileVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/10/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import TextFieldEffects
import GBHFacebookImagePicker

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
                tfAge.text = age
            }
            if let url = user.urlAvatar {
                DispatchQueue.main.async() {
                    self.imgAvatar.kf.setImage(with: url)
                }
            }
        }
    }
    
    //MARK: - FBPicker
    func setFBPicker(){
        // Init picker
        let picker = GBHFacebookImagePicker()
        
        // Allow multiple selection (false by default)
        //GBHFacebookImagePicker.pickerConfig.allowMultipleSelection = false
        //GBHFacebookImagePicker.pickerConfig.maximumSelectedPictures = 1
        
        // Make some customisation
        // self.someCustomisation()
        
        // Present picker
        picker.presentFacebookAlbumImagePicker(from: self,
                                               delegate: self)
    }
    
    //MARK: - Image
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
   /* func openFBImages() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VOAlbumFacebookVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }*/
    
    //MARK: - Age
    func datePickerValueChanged(_ sender: UIDatePicker) {
        self.birthDay = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        tfAge.text = dateFormatter.string(from: sender.date)
    }
    
    //MARK: - IBAction
    @IBAction func ageFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: .valueChanged)
        
    }
    
    @IBAction func cancelBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnPressed(){
        guard  (tfName.text != nil)  && !(tfName.text?.isBlank)! else {
            self.showMessagePrompt(NSLocalizedString("nameRequired", comment: ""))
            return
        }
        guard (tfLastName.text != nil) && !(tfLastName.text?.isBlank)!  else {
            self.showMessagePrompt(NSLocalizedString("lastNameRequired", comment: ""))
            return
        }
        guard self.birthDay != nil  else {
            self.showMessagePrompt(NSLocalizedString("birthdayRequired", comment: ""))
            return
        }
        
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
                self.showMessagePrompt(error)
            }else{
                self.navigationController?.popViewController(animated: true)
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
        
        if VOFBDataService.shared.myUser!.provider == K.provider.fb {
            alert.addAction(UIAlertAction(title: NSLocalizedString("titFacebook", comment: ""), style: .default, handler: { _ in
                self.setFBPicker()
            }))
        }
        
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
        print("Cancelled Facebook Album picker with error")
        print(error.debugDescription)
    }
    
    // Optional
    func facebookImagePicker(didCancelled imagePicker: UIViewController) {
        print("Cancelled Facebook Album picker")
    }
    
    // Optional
    func facebookImagePickerDismissed() {
        print("Picker dismissed")
    }
}
