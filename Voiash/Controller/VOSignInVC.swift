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
    @IBOutlet weak var vBlur:UIVisualEffectView!
    @IBOutlet weak var btnGoogle: VORoundButton!
    @IBOutlet weak var btnLogin: VORoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDel.currentVC = self
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
    
    //MARK: IBAction
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func googleBtnPressed(_ sender: VORoundButton) {
        sender.showSpinner()
        self.vBlur.isHidden = false
        appDel.isFBActive = false
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookBtnPressed(_ sender: VORoundButton) {
        sender.showSpinner()
        appDel.isFBActive = true
        let facebookLogin = FBSDKLoginManager()
        self.vBlur.isHidden = false
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                self.vBlur.isHidden = true
                appDel.isFBActive = true
                sender.hideSpinner()
                print("BSC:: " + error.debugDescription)
            } else if result?.isCancelled == true {
                self.vBlur.isHidden = true
                appDel.isFBActive = true
                sender.hideSpinner()
                print("BSC:: User cancelled facebook auth" )
            } else {
                print("BSC:: Successfully auth FaceBook")
                let fbCredential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                appDel.isFBActive = true
                VOFBAuthService.shared.loginWithCredential(fbCredential , onComplete: { (errMsg, data) in
                    if errMsg == nil {
                        if((FBSDKAccessToken.current()) != nil) {
                            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, birthday"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    if let result = result as? [String: Any] {
                                        guard let email = result["email"] as? String else {
                                            return
                                        }
                                        guard let name = result["first_name"] as? String else {
                                            return
                                        }
                                        var lastName = ""
                                        if let last = result["last_name"] as? String {
                                            lastName = last.capitalized
                                        }
                                        var age = ""
                                        if let birth = result["birthday"] as? String {
                                            age = birth
                                        }
                                        var urlAvatar = ""
                                        if let ditPict = result["picture"] as? [String: Any] {
                                            if let ditType = ditPict["data"] as? [String: Any] {
                                                if let strUrl = ditType["url"] as? String {
                                                    urlAvatar = strUrl
                                                }
                                            }
                                        }
                                        let userData:JSONStandard = [K.FB.user.name:name.capitalized as AnyObject, K.FB.user.lastName:lastName as AnyObject, K.FB.user.provider: K.provider.fb as AnyObject, K.FB.user.email: email as AnyObject,K.FB.user.urlAvatar:urlAvatar as AnyObject, K.FB.user.birthday:age as AnyObject]
                                        VOFBDataService.shared.saveUser(uid: (Auth.auth().currentUser?.uid)!, userData: userData, onComplete: {(success) in
                                            if success {
                                                self.vBlur.isHidden = true
                                                sender.hideSpinner()
                                                appDel.setTabBarRoot()
                                            }else{
                                                self.vBlur.isHidden = true
                                                sender.hideSpinner()
                                            }
                                        })
                                    }
                                }else{
                                    self.vBlur.isHidden = true
                                    print("BSC:: " + error.debugDescription)
                                    sender.hideSpinner()
                                }
                            })
                        }
                    } else {
                        self.vBlur.isHidden = true
                        sender.hideSpinner()
                        let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated:true, completion:nil)
                    }
                })
            }
        }
    }
    
    @IBAction func signInBtnPressed(_ sender: AnyObject) {
        if !tfEmail.text!.isEmail {
            self.showAlert(typeAlert:.error, message:NSLocalizedString("errorInvalidEmail", comment: ""))
            return
        }
        
        if !tfPassword.text!.isValidPassword {
            self.showAlert(typeAlert:.error, message:NSLocalizedString("errorWrongPassword", comment: ""))
            return
        }
        
        let email = tfEmail.text!
        let pass = tfPassword.text!
        self.btnLogin.showSpinner()
        
        VOFBAuthService.shared.loginWithEmail(email, password: pass, onComplete: { (errMsg, data) in
            if let error = errMsg {
                self.btnLogin.hideSpinner()
                if error == NSLocalizedString("errorEmailWithoutConfirmation", comment: "") {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "VOConfirmEmailVC") as! VOConfirmEmailVC
                    vc.cameFromSignIn = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.showAlert(typeAlert:.error, message:error)
                }
                return
            }else{
                VOFBDataService.shared.getUser(uid: data!.uid, onComplete: { (fbUser) in
                    self.btnLogin.hideSpinner()
                    if let fbUser = fbUser {
                        VOFBDataService.shared.myUser = fbUser
                    }
                    appDel.setTabBarRoot()
                })
            }
        })
       
        
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
        guard error == nil else {
            
            print("Error while trying to redirect : \(error)")
            return
        }
        
        print("Successful Redirection")
    }
    
    
    //MARK: - GIDSignIn Delegate

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        if let error = error {
            self.showAlert(typeAlert:.error, message:NSLocalizedString("errorGeneral", comment: ""))
        }
        self.btnGoogle.hideSpinner()
        
        self.vBlur.isHidden = false
    }
    
    // Finished disconnecting |user| from the app successfully if |error| is |nil|.
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!)
    {
        
        self.vBlur.isHidden = false
        self.btnGoogle.hideSpinner()
    }
}

