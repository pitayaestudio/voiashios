//
//  VOConfirmEmailVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import Firebase

class VOConfirmEmailVC: UIViewController {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblMessage:UILabel!
    @IBOutlet weak var btnContinue:VORoundButton!
    @IBOutlet weak var btnResend:VORoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(VOConfirmEmailVC.reloadScreen), name: NSNotification.Name(rawValue:K.notifications.reloadEmail), object: nil)
        appDel.reloadUser = true
        reloadScreen()
    }
    
    deinit {
        appDel.reloadUser = false
        NotificationCenter.default.removeObserver(self)
    }
    
    func reloadScreen(){
        if Auth.auth().currentUser!.isEmailVerified {
            lblTitle.text = NSLocalizedString("titConfirmOK", comment: "")
            lblMessage.text = NSLocalizedString("mesConfirmOK", comment: "")
            btnContinue.isHidden = false
            btnResend.isHidden = true
        }else{
            lblTitle.text = NSLocalizedString("titConfirmEmail", comment: "")
            lblMessage.text = NSLocalizedString("mesConfirmEmail", comment: "")
            btnContinue.isHidden = true
            btnResend.isHidden = false
        }
    }
    
    //MARK: - IBAction
    @IBAction func resendEmailBtnPressed(){
        self.btnResend.showLoading()
        VOFBAuthService.shared.sendEmailConfirmation( { (error) in
            self.btnResend.hideLoading()
            if let error = error {
                self.showMessagePrompt(error)
            }else{
                self.showMessagePrompt(NSLocalizedString("mesConfirmEmail", comment: ""))
            }
        })
    }
    
}
