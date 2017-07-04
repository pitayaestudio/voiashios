//
//  VOFBAuthService.swift
//  Voiash
//
//  Created by Brenda Saavedra on 03/07/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data:AnyObject?)-> Void

class VOFBAuthService: NSObject {
    fileprivate static let _shared = VOFBAuthService()
    
    static var shared:VOFBAuthService{
        return _shared
    }
    
    func loginWithCredential(_ credential: AuthCredential, onComplete:Completion?){
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print ("loginWithCredential Error:: " + error.debugDescription)
                let strError = self.handleFirebaseError(error! as NSError)
                onComplete?(strError,nil)
            } else {
                print ("BSC:: successfully auth Firebase")
                self.saveUserInKeychain((user?.uid)!, isLoginWithFB: true)
                onComplete?(nil,user)
            }
        })
    }
    
    func loginWithEmail(_ phone:String, onComplete:Completion?){
        let email = "email_\(phone)@gmail.com"
        let pass  = "pass_\(phone)"
        Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
            if error != nil {
                self.signInWithEmail(phone, onComplete: onComplete)
            }else{
                if user?.uid != nil {
                    self.signInWithEmail(phone, onComplete: onComplete)
                }
            }
        })
    }
    
    func signInWithEmail(_ phone:String, onComplete:Completion?){
        let email = "email_\(phone)@gmail.com"
        let pass  = "pass_\(phone)"
        Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
            if error != nil{
                onComplete?(self.handleFirebaseError(error! as NSError),nil)
            }else{
                self.saveUserInKeychain((user?.uid)!, isLoginWithFB: false)
                onComplete?(nil,user)
            }
        })
    }
    
    func saveUserInKeychain(_ userID: String, isLoginWithFB: Bool){
        //DataService.instance.saveUser(uid: userID, isLoginWithFB: isLoginWithFB)
        keychain.set(userID, forKey: K.FB.user.userId)
        
    }
    
    func handleFirebaseError(_ error:NSError)->String{
        print(error.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: error.code){
            switch errorCode {
                
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                return "Could not create account. Email already in use"
                
            case .invalidEmail:
                return "Invalid email address"
                
            case .wrongPassword:
                return "Invalid password"
                
            default:
                return "There was a problem, try again"
                
            }
        }
        return ""
    }
    
    func signOut(){
        try! Auth.auth().signOut()
    }
}
