//
//  AppDelegate.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/3/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var currentVC: VOSignInVC?
    var reloadUser = false
    var isFBActive = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // [START setup_gidsignin]
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        // [END setup_gidsignin]
        FBSDKApplicationDelegate.sharedInstance().application(application,
                                                              didFinishLaunchingWithOptions:launchOptions)
        
        IQKeyboardManager.sharedManager().enable = true
        
        //try! Auth.auth().signOut()
        
        reloadRootVC()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if self.reloadUser {
            VOFBAuthService.shared.reloadUser()
        }
    }
    
    //MARK: - Functions
    func setTabBarRoot(){
        let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        tabBar.selectedIndex = 4
        self.window?.rootViewController = tabBar
    }
    
    func setInitRoot(){
        let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitNavBar") as! UINavigationController
        self.window?.rootViewController = tabBar
    }
    
    func reloadRootVC() {
        //if keychain.getBool(K.FB.user.userId) != nil {
        if (Auth.auth().currentUser != nil) {
            VOFBDataService.shared.getUser(uid: Auth.auth().currentUser!.uid, onComplete: { (user) in
                if let user = user {
                    VOFBDataService.shared.myUser = user
                }
                
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.setTabBarRoot()
                self.window?.makeKeyAndVisible()
            })
        }
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if self.isFBActive {
            let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
            
            return handled
        }else{
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
    }
    

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if self.isFBActive {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                         open: url,
                                                                         // [START old_options]
                sourceApplication: sourceApplication,
                annotation: annotation)
        }
        
        if GIDSignIn.sharedInstance().handle(url,
                                             sourceApplication: sourceApplication,
                                             annotation: annotation) {
            return true
        }
        return false
    }
    
    // [END old_options]
    // [START headless_google_auth]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // [START_EXCLUDE]
        guard let controller = self.currentVC else { return }
        // [END_EXCLUDE]
        if let error = error {
            // [START_EXCLUDE]
            self.currentVC!.showAlert(typeAlert:.error, message:error.localizedDescription)
            //self.currentVC!.showMessagePrompt(error.localizedDescription)
            // [END_EXCLUDE]
            return
        } 
        
        // [START google_credential]
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // [END google_credential]
        // [START_EXCLUDE]
       // controller.showSpinner {
            VOFBAuthService.shared.loginWithCredential(credential) { (error, user) in
                if let error = error {
                   // controller.hideSpinner({
                        controller.vBlur.isHidden = true
                        controller.showAlert(typeAlert:.error, message:error)
                   // })
                }else{
                    VOFBAuthService.shared.currentCredential = credential
                    
                    VOFBDataService.shared.getUser(uid: (Auth.auth().currentUser?.uid)!, onComplete: { (user) in
                        if user == nil {
                            if (GIDSignIn.sharedInstance().currentUser != nil) {
                                let urlAvatar = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 100).absoluteString
                                let email = GIDSignIn.sharedInstance().currentUser.profile.email
                                let name =  GIDSignIn.sharedInstance().currentUser.profile.givenName
                                let lastName =  GIDSignIn.sharedInstance().currentUser.profile.familyName
                               // let birthday =
                                
                                let userData:JSONStandard = [K.FB.user.name:name?.capitalized as AnyObject, K.FB.user.lastName:lastName?.capitalized as AnyObject, K.FB.user.provider: K.provider.google as AnyObject, K.FB.user.email: email as AnyObject,K.FB.user.urlAvatar:urlAvatar as AnyObject]
                                VOFBDataService.shared.saveUser(uid: (Auth.auth().currentUser?.uid)!, userData: userData, onComplete:{(success) in
                                    if success {
                                        appDel.setTabBarRoot()
                                        controller.vBlur.isHidden = true
                                    }else{
                                        controller.vBlur.isHidden = true
                                        VOFBAuthService.shared.signOut()
                                        controller.showAlert(typeAlert:.error, message:(NSLocalizedString("errorGeneral", comment: "")))
                                    }
                                })
                            }
                        }else{
                            controller.vBlur.isHidden = true
                            VOFBDataService.shared.myUser = user!
                            appDel.setTabBarRoot()
                        }
                       // controller.hideSpinner({
                            //controller.performSegue(withIdentifier: K.segue.segueTabBar, sender: nil)
                       // })
                    })
                }
            }
        //}
        
        // [END_EXCLUDE]
    }
    // [END headless_google_auth]
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

