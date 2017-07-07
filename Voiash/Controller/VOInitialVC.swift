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
    @IBOutlet weak var imgClouds2:UIImageView!
    @IBOutlet weak var imgClouds3:UIImageView!
    var isActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateClouds()
        animatePlane()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.title = " "
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.isActive = false
    }
    
    
    // MARK: - Animations
    func animatePlane(){
        UIView.animate(withDuration: 1, delay:0, animations: {
            self.imgPlane.frame.origin.y = self.imgPlane.frame.origin.y
            self.imgPlane.frame.origin.x = self.imgPlane.frame.origin.x + 85
        }, completion: {completion in
            UIView.animate(withDuration: 1, delay:0, animations: {
                self.imgPlane.frame.origin.y = self.imgPlane.frame.origin.y - 20
                self.imgPlane.frame.origin.x = self.imgPlane.frame.origin.x + 100
            }, completion: {completion in
                UIView.animate(withDuration: 1, delay:0, animations: {
                    self.imgPlane.frame.origin.y = self.imgPlane.frame.origin.y - 50
                    self.imgPlane.frame.origin.x = self.imgPlane.frame.origin.x + 130
                }, completion: {completion in
                    UIView.animate(withDuration: 1, delay:0, animations: {
                        self.imgPlane.frame.origin.y = self.imgPlane.frame.origin.y - 80
                        self.imgPlane.frame.origin.x = self.imgPlane.frame.origin.x + 150
                    }, completion: {completion in
                        self.imgPlane.frame.origin.y = self.imgPlane.frame.origin.y - 120
                        self.imgPlane.frame.origin.x = self.imgPlane.frame.origin.x + 200
                    })
                })
            })
            
        })
    }
    
    func animateClouds(){
        if !self.isActive {
            return
        }
        imgClouds.frame.origin.x = 75
        //imgClouds.frame.origin.x = 35
        //imgClouds.frame.origin.x = 5
        UIView.animate(withDuration: 7, delay: 0.0, options: .curveLinear, animations: {[unowned self] () -> Void in
            self.imgClouds.frame.origin.x = self.view.frame.size.width - 125
            //self.imgClouds2.frame.origin.x = self.view.frame.size.width - 85
            //self.imgClouds3.frame.origin.x = self.view.frame.size.width - 100
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
