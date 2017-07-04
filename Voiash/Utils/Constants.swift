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
        static let urlStorage = "gs://maraton-5a01d.appspot.com/"
       
        struct user {
            static let ref = "user"
            static let userId = "userId"
            static let provider = "provider"
        }
    }
    struct color {
        static let shadowGray = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
    }
    
}

