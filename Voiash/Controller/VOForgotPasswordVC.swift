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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBOutlet
    @IBAction func resetPassBtnPressed(_ sender: AnyObject) {
      /* showSpinner {
            // [START send_verification_email]
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                // [START_EXCLUDE]
                self.hideSpinner {
                    if let error = error {
                        self.showMessagePrompt(error.localizedDescription)
                        return
                    }
                    self.showMessagePrompt("Sent")
                }
                // [END_EXCLUDE]
            }
            // [END send_verification_email]
        }*/
    }

}
