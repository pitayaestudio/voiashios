//
//  VOSignUpVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class VOSignUpVC: UIViewController {

    @IBOutlet weak var tfName: TextFieldEffects!
    @IBOutlet weak var tfLastName: TextFieldEffects!
    @IBOutlet weak var tfEmail: TextFieldEffects!
    @IBOutlet weak var tfPassword: TextFieldEffects!
    @IBOutlet weak var tfPassword2: TextFieldEffects!
    @IBOutlet weak var btnSingIn: VORoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideBack()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpBtnPressed(_ sender: AnyObject) {
        guard let data = validateData() else{
            return
        }
        self.btnSingIn.showSpinner()
        VOFBAuthService.shared.createUserWithEmail(userData: data, password: self.tfPassword.text!) { (error, user) in
            self.btnSingIn.hideSpinner()
            if user != nil {
                if !Auth.auth().currentUser!.isEmailVerified {
                    self.performSegue(withIdentifier: K.segue.segueEmailConfirmation, sender: nil)
                } else {
                    appDel.setTabBarRoot()
                }
            }else if error == NSLocalizedString("errorEmailWithoutConfirmation", comment: "") {
                self.performSegue(withIdentifier: K.segue.segueEmailConfirmation, sender: nil)
            }else{
                self.showMessagePrompt(error!)
            }
        }
    }

    // MARK: - Validations
    func validateData()->JSONStandard? {
        guard  (tfName.text != nil)  && !(tfName.text?.isBlank)! else {
            self.showMessagePrompt(NSLocalizedString("nameRequired", comment: ""))
            return nil
        }
        
        guard (tfLastName.text != nil) && !(tfLastName.text?.isBlank)!  else {
            self.showMessagePrompt(NSLocalizedString("lastNameRequired", comment: ""))
            return nil
        }
        
        guard (tfEmail.text != nil) && !(tfEmail.text?.isBlank)!  else {
            self.showMessagePrompt(NSLocalizedString("emailRequired", comment: ""))
            return nil
        }
        
        if !tfEmail.text!.isEmail {
            self.showMessagePrompt(NSLocalizedString("errorInvalidEmail", comment: ""))
            return nil
        }
        
        guard (tfPassword.text != nil) && !(tfPassword.text?.isBlank)! else{
            self.showMessagePrompt(NSLocalizedString("passRequired", comment: ""))
            return nil
        }
        
        if !tfPassword.text!.isValidPassword {
            self.showMessagePrompt(NSLocalizedString("errorWrongPassword", comment: ""))
            return nil
        }
        
        guard (tfPassword2.text != nil) && !(tfPassword2.text?.isBlank)! else{
            self.showMessagePrompt(NSLocalizedString("pass2Required", comment: ""))
            return nil
        }
        
        if tfPassword2.text != tfPassword.text {
            self.showMessagePrompt(NSLocalizedString("passwordDifferent", comment: ""))
            return nil
        }
        
        let userData:JSONStandard = [K.FB.user.name:tfName.text!.capitalized as AnyObject, K.FB.user.lastName:tfLastName.text!.capitalized as AnyObject, K.FB.user.provider: K.provider.email as AnyObject, K.FB.user.email: tfEmail.text! as AnyObject]
        
        return userData
    }
    

}
