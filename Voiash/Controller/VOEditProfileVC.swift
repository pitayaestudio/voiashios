//
//  VOEditProfileVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/10/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import TextFieldEffects

class VOEditProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tfName: TextFieldEffects!
    @IBOutlet weak var tfLastName: TextFieldEffects!
    @IBOutlet weak var tfEmail: TextFieldEffects!
    @IBOutlet weak var tfAge: TextFieldEffects!
    @IBOutlet weak var imgAvatar: UIImageView!
    var imagePicker: UIImagePickerController!
    var imgData:Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                imgAvatar.kf.setImage(with: url)
                
            }
        }
    }

    //MARK: ImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            if let imgData = UIImageJPEGRepresentation(image, 0.2) {
                self.imgData = imgData
                imgAvatar.image = image
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
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
    
    //MARK: - Age
    func datePickerValueChanged(_ sender: UIDatePicker) {
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
        
        var age = ""
        if(tfAge.text != nil) && !(tfAge.text?.isBlank)! {
            age = tfAge.text!
        }
        
        VOFBDataService.shared.updateMyUser(name: tfName.text!.capitalized, lastName: tfLastName.text!.capitalized, age: age, data: self.imgData) { (error) in
            if let error = error {
                self.showMessagePrompt(error)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func changePhotoBtnPressed(){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}
