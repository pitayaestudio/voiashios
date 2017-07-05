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
    
    static var shared:VODataService{
        return _shared
    }

    var mainRef:DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef:DatabaseReference {
        return mainRef.child(K.FB.user.ref)
    }
    
   /* func saveUser(uid: String, provider:String){
        let userData: Dictionary<String, AnyObject> = [K.FB.user.provider: provider as AnyObject]
        usersRef.child(uid).updateChildValues(userData)
    } **/
    
    func saveUser(uid: String, userData:JSONStandard){
        usersRef.child(uid).setValue(userData)
    }
}
