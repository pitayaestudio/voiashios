//
//  VOSignUpVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import TextFieldEffects

class VOSignUpVC: UIViewController {

    @IBOutlet weak var tfName: TextFieldEffects!
    @IBOutlet weak var tfLastName: TextFieldEffects!
    @IBOutlet weak var tfEmail: TextFieldEffects!
    @IBOutlet weak var tfPassword: TextFieldEffects!
    @IBOutlet weak var tfPassword2: TextFieldEffects!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideBack()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.presentTransparentNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - IBAction
    @IBAction func signUpBtnPressed(_ sender: AnyObject) {
        
    }
    
    // MARK: - Validations
    func validateData()->JSONStandard? {
        guard let name = tfName.text && !name.isBlank  else {
            self.showMessagePrompt(NSLocalizedString("nameRequired", comment: ""))
            return nil
        }
        
        guard let lastName = tfLastName.text && !lastName.isBlank  else {
            self.showMessagePrompt(NSLocalizedString("lastNameRequired", comment: ""))
            return nil
        }
        
        guard var email = tfEmail.text && !email.isBlank  else {
            self.showMessagePrompt(NSLocalizedString("emailRequired", comment: ""))
            return nil
        }
        
        guard email = tfEmail.text!.isEmail else{
            self.showMessagePrompt(NSLocalizedString("errorInvalidEmail", comment: ""))
            return nil
        }
        
        
    }
    

}
