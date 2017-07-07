//
//  VOInitialVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit

class VOInitialVC: UIViewController {

    @IBOutlet weak var imgPlane:UIImageView!
    @IBOutlet weak var imgClouds:UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateClouds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.title = " "
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - Animations
    func animateClouds(){
        imgClouds.frame.origin.x = 75
        UIView.animate(withDuration: 7, delay: 0.0, options: .curveLinear, animations: {[unowned self] () -> Void in
            self.imgClouds.frame.origin.x = self.view.frame.size.width - 125
        }) {[unowned self] (finsihed) -> Void in
            self.animateClouds()
        }
    }
    
    // MARK: - IBAction
    @IBAction func loginAnonymousBtnPressed(){
        VOFBAuthService.shared.loginAnonymous()
        appDel.setTabBarRoot()
    }
    

}
