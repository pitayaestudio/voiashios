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
        vFlightClouds.addFlightCloudsAllScreenAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        vFlightClouds.removeAllAnimations()
        self.navigationController?.isNavigationBarHidden = true
        self.isActive = false
        super.viewWillDisappear(animated)
    }
    
    // MARK: - IBAction
    @IBAction func loginAnonymousBtnPressed(){
        VOFBAuthService.shared.loginAnonymous()
        appDel.isAnonymous = true
        appDel.setTabBarRoot()
    }
}
