//
//  VOForgotPasswordVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import TextFieldEffects

class VOForgotPasswordVC: UIViewController {

    @IBOutlet weak var tfEmail: TextFieldEffects!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideBack()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.presentTransparentNavigationBar()
    }
    
    // MARK: - IBOutlet
    @IBAction func resetPassBtnPressed(_ sender: AnyObject) {
       
        guard let email = self.tfEmail.text else{
            self.showMessagePrompt(NSLocalizedString("emailRequired", comment: ""))
            return
        }
        
        if !email.isEmail {
            self.showMessagePrompt(NSLocalizedString("errorInvalidEmail", comment: ""))
            return
        }
    
       showSpinner {
            VOFBAuthService.shared.resetPasswordForEmail(email, onComplete: { (error) in
                self.hideSpinner({ 
                    if let error = error {
                        self.showMessagePrompt(error)
                    }else{
                        self.showMessagePrompt(NSLocalizedString("resetPassOK", comment: ""))
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                })
            })
       }
    }

}
