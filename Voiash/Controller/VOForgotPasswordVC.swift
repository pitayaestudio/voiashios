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
    @IBOutlet weak var btnForgot: VORoundButton!
    
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
    
    // MARK: - IBOutlet
    @IBAction func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetPassBtnPressed(_ sender: AnyObject) {
        self.btnForgot.showSpinner()
        guard let email = self.tfEmail.text else{
            self.showAlert(typeAlert:.error, message:NSLocalizedString("emailRequired", comment: ""))
            return
        }
        
        if !email.isEmail {
            self.showAlert(typeAlert:.error, message:NSLocalizedString("errorInvalidEmail", comment: ""))
            return
        }
    
        VOFBAuthService.shared.resetPasswordForEmail(email, onComplete: { (error) in
            self.btnForgot.hideSpinner()
            if let error = error {
                self.showAlert(typeAlert:.error, message:error)
            }else{
                self.backBtnPressed()
                self.showAlert(typeAlert:.error, message:NSLocalizedString("resetPassOK", comment: ""))
                
            }
            
            
        })
    }

}
