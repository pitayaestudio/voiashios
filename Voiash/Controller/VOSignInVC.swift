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
import TextFieldEffects

class VOSignInVC: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var tfEmail: TextFieldEffects!
    @IBOutlet weak var tfPassword: TextFieldEffects!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDel.currentVC = self
        
        self.hideBack()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance().uiDelegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: IBAction
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func facebookBtnPressed(_ sender: AnyObject) {
        return
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("BSC:: " + error.debugDescription)
            } else if result?.isCancelled == true {
                print("BSC:: User cancelled facebook auth" )
            } else {
                print("BSC:: Successfully auth FaceBook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                let userData: JSONStandard = [K.FB.user.provider:K.provider.fb as AnyObject]
                VOFBAuthService.shared.loginWithCredential(credential, userData: userData, onComplete: { (errMsg, data) in
                    if errMsg == nil {
                        self.performSegue(withIdentifier: K.segue.segueTabBar, sender: nil)
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
        if let email = tfEmail.text, let pass = tfPassword.text , (email.characters.count > 0 && pass.characters.count > 5){
            showSpinner {
                VOFBAuthService.shared.loginWithEmail(email, password: pass, onComplete: { (errMsg, data) in
                    self.hideSpinner {
                        if let error = errMsg {
                            self.showMessagePrompt(error)
                            return
                        }else{
                            self.performSegue(withIdentifier: K.segue.segueTabBar, sender: nil)
                        }
                    }
                })
            }
        }else{
            self.showMessagePrompt("You must enter both an email and a password (6 characters)")
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
        guard error == nil else {
            
            print("Error while trying to redirect : \(error)")
            return
        }
        
        print("Successful Redirection")
    }
    
    
    //MARK: GIDSignIn Delegate

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {}
    
    // Finished disconnecting |user| from the app successfully if |error| is |nil|.
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!)
    {}
}

