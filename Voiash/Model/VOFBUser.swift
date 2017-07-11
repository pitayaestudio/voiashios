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
    var lastName: String?
    var birthday: String!
    var provider: String!
    var pushToken: String?
    var phone: String?
    var urlAvatar: URL?
    var userKey: String!
    var userRef: DatabaseReference?
    
    var fullName:String! {
        var fn = self.name
        if let ln = self.lastName {
            fn = "\(self.name!) \(ln)"
        }
        return fn
    }
    
    var age:String? {
        if self.birthday != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let date = dateFormatter.date(from: self.birthday!)
            
            return "\(date!.age) \(NSLocalizedString("yearsAge", comment: ""))"
        }else{
            return nil
        }
    }
    
    init(userKey:String?, userData:JSONStandard){
        self.userKey = userKey
        self.name = userData[K.FB.user.name] as! String
        
        if let lastName = userData[K.FB.user.lastName] as? String {
            self.lastName = lastName
        }
        
        if let birthday = userData[K.FB.user.birthday] as? String {
            self.birthday = birthday
        }
        
        self.email = userData[K.FB.user.email] as! String
        self.provider = userData[K.FB.user.provider] as! String
        
        if let push = userData[K.FB.user.pushToken] as? String {
            self.pushToken = push
        }
        
        if let age = userData[K.FB.user.birthday] as? String , userData[K.FB.user.birthday] as! String != "" {
            self.birthday = age
        }else{
            self.birthday = ""
        }
        
        if let url = userData[K.FB.user.urlAvatar] as? String {
            self.urlAvatar = URL.init(string: url)
        }
        
        if let phone = userData[K.FB.user.phone] as? String {
            self.phone = phone
        }
        
        if let key = userKey {
            self.userRef = VOFBDataService.shared.usersRef.child(key)
        }
    }
    
}
