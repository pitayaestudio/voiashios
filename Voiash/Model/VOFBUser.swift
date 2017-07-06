//
//  VOFBUser.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/6/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import Firebase

class VOFBUser: NSObject {

    var email: String!
    var name: String!
    var lastName: String!
    var provider: String!
    var pushToken: String?
    var phone: String?
    var urlAvatar: URL?
    var userKey: String!
    var userRef: DatabaseReference?
    
    init(userKey:String?, userData:JSONStandard){
        self.userKey = userKey
        self.name = userData[K.FB.user.name] as! String
        self.lastName = userData[K.FB.user.name] as! String
        self.email = userData[K.FB.user.email] as! String
        self.provider = userData[K.FB.user.provider] as! String
        
        if let push = userData[K.FB.user.pushToken] as? String {
            self.pushToken = push
        }
        
        if let url = userData[K.FB.user.urlAvatar] as? String {
            self.urlAvatar = URL.init(string: url)
        }
        
        if let phone = userData[K.FB.user.phone] as? String {
            self.phone = phone
        }
        
        if let key = userKey {
            self.userRef = VODataService.shared.usersRef.child(key)
        }
    }
    
}
