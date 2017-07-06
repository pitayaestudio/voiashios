//
//  Constants.swift
//  Voiash
//
//  Created by Brenda Saavedra on 03/07/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import Foundation
import KeychainSwift

typealias JSONStandard = [String: AnyObject]
let keychain = KeychainSwift()
let appDel = UIApplication.shared.delegate as! AppDelegate

var language = 0
var nodeLanguage = ""

struct K {
    struct FB {
        static let urlStorage = "gs://voiash-794d0.appspot.com"
        
        static let kindDB = "devDB"
        
        struct user {
            static let ref = "users"
            static let userId = "userId"
            static let provider = "provider"
            static let email = "email"
            static let name = "name"
            static let lastName = "lastName"
            static let phone = "phoneNumber"
            static let urlAvatar = "profilePicture"
            static let pushToken = "pushToken"
        }
    }
    
    struct provider {
        static let fb = "facebook"
        static let google = "google"
        static let email = "email"
    }
    struct color {
        static let shadowGray = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        static let colorRed = UIColor(red: 255, green: 72, blue: 71, alpha: 1)
        static let titleGray = UIColor(red: 115, green: 115, blue: 115, alpha: 1)
    }
    struct segue {
        static let segueTabBar = "segueTabBar"
        static let segueForgotPass = "segueForgotPass"
        static let segueEmailConfirmation = "segueEmailConfirmation"
    }
    struct notifications {
        static let reloadEmail = "reloadEmailConfirmation"
    }
    
}

