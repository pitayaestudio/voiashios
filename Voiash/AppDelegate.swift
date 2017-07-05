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
    var currentVC: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Sets background to a blank/empty image
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        FirebaseApp.configure()
        
        // [START setup_gidsignin]
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        // [END setup_gidsignin]
        FBSDKApplicationDelegate.sharedInstance().application(application,
                                                              didFinishLaunchingWithOptions:launchOptions)
        
        IQKeyboardManager.sharedManager().enable = true
        
        try! Auth.auth().signOut()
        
        reloadRootVC()
        
        return true
    }
    
    func reloadRootVC() {
        //if keychain.getBool(K.FB.user.userId) != nil {
        if (Auth.auth().currentUser != nil) {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBar")
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    // [END new_options]
    // [START old_delegate]
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // [END old_delegate]
        if GIDSignIn.sharedInstance().handle(url,
                                             sourceApplication: sourceApplication,
                                             annotation: annotation) {
            return true
        }
        return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                     open: url,
                                                                     // [START old_options]
            sourceApplication: sourceApplication,
            annotation: annotation)
    }
    // [END old_options]
    // [START headless_google_auth]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // [START_EXCLUDE]
        guard let controller = self.currentVC else { return }
        // [END_EXCLUDE]
        if let error = error {
            // [START_EXCLUDE]
            self.currentVC!.showMessagePrompt(error.localizedDescription)
            // [END_EXCLUDE]
            return
        }
        
        // [START google_credential]
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // [END google_credential]
        // [START_EXCLUDE]
        controller.showSpinner {
            let userData: JSONStandard = [K.FB.user.provider:K.provider.google as AnyObject]
            VOFBAuthService.shared.loginWithCredential(credential, userData:userData) { (error, user) in
                controller.hideSpinner({ 
                    if let error = error {
                        controller.showMessagePrompt(error)
                    }else{
                        controller.performSegue(withIdentifier: K.segue.segueTabBar, sender: nil)
                    }
                })
            }
        }
        
        // [END_EXCLUDE]
    }
    // [END headless_google_auth]
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

