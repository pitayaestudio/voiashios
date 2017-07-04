//
//  VOSignInVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 03/07/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class VOSignInVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     /*   if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: SEGUE_FEEDVC, sender: nil)
        } */
    }
    
    //MARK: Keyboard
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextfield(textField, moveDistance: -100, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextfield(textField, moveDistance: -100, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextfield(_ textfield:UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement:CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField",context:nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx:0,dy:movement)
        UIView.commitAnimations()
        
    }
    
    //MARK: IBAction
    @IBAction func facebookBtnPressed(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("BSC:: " + error.debugDescription)
            } else if result?.isCancelled == true {
                print("BSC:: User cancelled facebook auth" )
            } else {
                print("BSC:: Successfully auth FaceBook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                VOFBAuthService.shared.loginWithCredential(credential, onComplete: { (errMsg, data) in
                    if errMsg == nil {
                       // self.performSegue(withIdentifier: SEGUE_FEEDVC, sender: nil)
                    } else {
                        let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated:true, completion:nil)
                    }
                })
            }
        }
    }
    
    @IBAction func signInBtnPressed(_ sender: AnyObject) {
        if let email = emailField.text, let pass = passField.text , (email.characters.count > 0 && pass.characters.count > 0){
            VOFBAuthService.shared.loginWithEmail(email, password: pass, onComplete: { (errMsg, data) in
                if errMsg == nil {
                 //   self.performSegue(withIdentifier: SEGUE_FEEDVC, sender: nil)
                }else{
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated:true, completion:nil)
                }
            })
        }else{
            let alert = UIAlertController(title: "Username and Password required", message: "You must enter both a username and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
