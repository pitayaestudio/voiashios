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
        static let urlProfile = "profile"
        static let kindDB = "devDB"
        static let prefixStorage = "dev_"
        
        struct user {
            static let ref = "users"
            static let userId = "userId"
            static let provider = "provider"
            static let email = "email"
            static let name = "name"
            static let lastName = "lastName"
            static let phone = "phoneNumber"
            static let birthday = "birthday"
            static let urlAvatar = "profilePicture"
            static let pushToken = "pushToken"
            static let fbToken = "fbToken"
            static let nameProfilePicture = "profile_picture"
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
        static let segueForgotPass = "segueForgotPass"
        static let segueEmailConfirmation = "segueEmailConfirmation"
        static let segueTabBar = "segueTabBar"
    }
    struct notifications {
        static let reloadEmail = "reloadEmailConfirmation"
    }
    struct ageValidation {
        static let maximum: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!;
        static let minimum: Date = Calendar.current.date(byAdding: .year, value: -100, to: Date())!;
    }
    
}
