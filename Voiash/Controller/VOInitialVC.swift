//
//  VOInitialVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import Lottie

class VOInitialVC: UIViewController {

    @IBOutlet weak var vFlightClouds:FlightCloudsView!
    @IBOutlet weak var vAnimation:UIView!
    
    var animationView:LOTAnimationView!
    var isActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = LOTAnimationView(name: "streetby_test_loading")
        animationView.loopAnimation = true
        animationView.contentMode = .scaleAspectFill
        self.vAnimation.addSubview(animationView)
        animationView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.title = " "
        self.isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.isActive = false
        super.viewWillDisappear(animated)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //let lottieRect = CGRect(x: 0, y: 60, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 60)
        let lottieRect = CGRect(x: 0, y: 60, width: self.vAnimation.bounds.size.width, height: self.vAnimation.bounds.size.height)
        self.animationView.frame = lottieRect
    }
    
    // MARK: - IBAction
    @IBAction func loginAnonymousBtnPressed(){
        VOFBAuthService.shared.loginAnonymous()
        appDel.isAnonymous = true
        appDel.setTabBarRoot()
    }
}
