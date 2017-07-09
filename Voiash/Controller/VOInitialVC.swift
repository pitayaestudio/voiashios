//
//  VOInitialVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit

class VOInitialVC: UIViewController {

    @IBOutlet weak var vFlightClouds:FlightCloudsView!
    var isActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.title = " "
        self.isActive = true
        vFlightClouds.addFlightCloudsAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.isActive = false
    }
    
    // MARK: - IBAction
    @IBAction func loginAnonymousBtnPressed(){
        VOFBAuthService.shared.loginAnonymous()
        appDel.setTabBarRoot()
    }
    

}
