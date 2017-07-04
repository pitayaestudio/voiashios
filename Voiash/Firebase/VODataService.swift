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
    
    private static let _instance = VODataService()
    
    static var instance: VODataService {
        return _instance
    }

    var mainRef:DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef:DatabaseReference {
        return mainRef.child(K.FB.user.ref)
    }
    
    func saveUser(uid: String, isLoginWithFB:Bool){
        let provider = isLoginWithFB ? "facebook.com" : "firebase"
        let userData: Dictionary<String, AnyObject> = [K.FB.user.provider: provider as AnyObject]
        usersRef.child(uid).updateChildValues(userData)
    }
    
}
