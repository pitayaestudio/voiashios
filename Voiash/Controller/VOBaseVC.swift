//
//  VOBaseVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/11/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import QorumLogs

class VOBaseVC: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if appDel.isAnonymous {
            return
        }
        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            //QL1(auth)
            if user == nil {
                VOFBDataService.shared.myUser = nil
                appDel.setInitRoot()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if appDel.isAnonymous || handle == nil{
            return
        }
        Auth.auth().removeStateDidChangeListener(handle!)
    }

}
