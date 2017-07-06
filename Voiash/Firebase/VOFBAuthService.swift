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
    
    /**
     Make a login anonymous.
     */
    func loginAnonymous(){
        Auth.auth().signInAnonymously { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                print("=======> loginAnonymous")
            }
        }
    }
    
    /**
     Make a login with facebook credentials.
     
     - Parameter credential: The auth credential
     - Returns: Error, User.
     */
    func loginWithCredential(_ credential: AuthCredential, userData:JSONStandard, onComplete:Completion?){
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print ("loginWithCredential Error:: " + error.debugDescription)
                self.handleFirebaseError(error! as NSError, onComplete: onComplete)
            } else {
                print ("BSC:: successfully auth Firebase")
                self.saveUserInKeychain((user?.uid)!, userData: userData)
                onComplete?(nil,user)
            }
        })
    }
    
    /**
     Make a login with email and password.
     
     - Parameter email: The email of the user
     - Parameter password: The password of the user
     - Return: (error, user)
     */
    func loginWithEmail(_ email:String, password:String, onComplete:Completion?){
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                self.handleFirebaseError(error as NSError, onComplete: onComplete)
            }else{
                onComplete?(nil,user)
            }
        })
    }
    
    /**
    Create an user with email, password and extra data (name, lastname)
     
    - Parameter userData: The user's (email, password, lastName, name)
    - Parameter password
    - Return: (error, user)
    */
    func createUserWithEmail(userData:JSONStandard, password:String, onComplete:Completion?){
        let email = userData[K.FB.user.email] as! String
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.handleFirebaseError(error as NSError, onComplete: { (err, user) in
                    onComplete?(err, nil)
                })
            }else{
                self.saveUserInKeychain((user?.uid)!, userData: userData)
                onComplete?(nil,user)
            }
        }
    }
    
    /**
     Save the user in the keychain.
     - Parameter userID: Save the userID
     - Parameter userData: Dictionary with (email,provider)
     */
    func saveUserInKeychain(_ userID: String, userData:JSONStandard){
        VODataService.shared.saveUser(uid: userID, userData: userData)
        keychain.set(userID, forKey: K.FB.user.userId)
    }
    
    /**
     Reset password
     - Parameter email: User's email
     - Return error
     */
    func resetPasswordForEmail(_ email:String, onComplete:@escaping (_ errMsg: String?)-> Void){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                self.handleFirebaseError(error as NSError, onComplete: { (err, user) in
                    onComplete(err)
                })
            }
            onComplete(nil)
        }
    }
    
    /**
     Handle the firebase error in the login and create user
     
     - Parameter error: Send the error
     - Returns onComplete: Return the description of the error
     */
    private func handleFirebaseError(_ error:NSError, onComplete:Completion?){
        print(error.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: error.code){
            switch errorCode {
                
            case .userNotFound:
                onComplete?(NSLocalizedString("errorUserNotFound", comment: ""), nil)
                break
                
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete?(NSLocalizedString("errorEmailAlreadyInUse", comment: ""), nil)
                break
                
            case .invalidEmail:
                onComplete?(NSLocalizedString("errorInvalidEmail", comment: ""), nil)
                break
                
            case .wrongPassword:
                onComplete?(NSLocalizedString("errorWrongPassword", comment: ""), nil)
                break
                
            default:
                onComplete?(NSLocalizedString("errorGeneral", comment: ""), nil)
                break
                
            }
        }
    }
    
    func signOut(){
        try! Auth.auth().signOut()
        keychain.clear()
    }
}
