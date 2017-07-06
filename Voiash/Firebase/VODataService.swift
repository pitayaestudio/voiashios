//
//  VODataService.swift
//  Voiash
//
//  Created by Brenda Saavedra on 03/07/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import Foundation
import Firebase

class VODataService {
    fileprivate static let _shared = VODataService()
    
    var myUser: VOFBUser!
    
    static var shared:VODataService{
        return _shared
    }

    var mainRef:DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef:DatabaseReference {
        return mainRef.child(K.FB.user.ref)
    }
    
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
}
