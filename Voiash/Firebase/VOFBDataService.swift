//
//  VOFBDataService.swift
//  Voiash
//
//  Created by Brenda Saavedra on 03/07/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import Foundation
import Firebase


typealias CompletionUser = (_ user:VOFBUser?)-> Void

class VOFBDataService {
    fileprivate static let _shared = VOFBDataService()
    
    var myUser: VOFBUser?
    
    static var shared:VOFBDataService{
        return _shared
    }

    var mainRef:DatabaseReference {
        return Database.database().reference().child(K.FB.kindDB)
    }
    
    var usersRef:DatabaseReference {
        return mainRef.child(K.FB.user.ref)
    }
    
    
    //MARK: - User
    /*
    * Save user with all data
    */
    func saveUser(uid: String, userData:JSONStandard){
        usersRef.child(uid).setValue(userData, withCompletionBlock: { (err, ref) in
            if err == nil {
                self.myUser = VOFBUser.init(userKey: uid, userData: userData)
            }
        })
    }
    
    /*
     * Get the users data
     */
    func getUser(uid: String, onComplete:@escaping CompletionUser){
        usersRef.child(uid).observeSingleEvent(of: .value, with: {(snapshot)  in
            if snapshot.exists() {
                if let data = snapshot.value as? JSONStandard {
                    let user = VOFBUser.init(userKey:uid, userData:data)
                    onComplete(user)
                    return
                }
            }else{
                onComplete(nil)
            }
        })
    }
    
    /*
     Delete all contents of current User
     */
    func deleteMyUser(_ onComplete:@escaping (_ error:String?)-> Void){
        self.usersRef.child(self.myUser!.userKey).removeValue { (error, ref) in
            if let error = error {
                onComplete(error.localizedDescription)
            }else{
                Auth.auth().currentUser?.delete { error in
                    if let error = error {
                        onComplete(error as! String)
                    } else {
                        self.myUser = nil
                        onComplete(nil)
                    }
                }
            }
        }
    }
    
    
}
