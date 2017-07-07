//
//  VOMyProfileVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/6/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import Kingfisher
import QuartzCore

class VOMyProfileVC: UIViewController {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAge:UILabel!
    @IBOutlet weak var imgAvatar:UIImageView!
    @IBOutlet weak var btnDelete:VORoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreen()
        self.navigationController?.presentWhiteNavigationBar()
    }

    func setScreen(){
        imgAvatar.layer.masksToBounds = true
        imgAvatar.layer.borderWidth = 3.0
        imgAvatar.layer.borderColor = UIColor.white.cgColor
        imgAvatar.layer.cornerRadius = 42
        
        if let user = VOFBDataService.shared.myUser {
            lblName.text = user.fullName
            lblAge.text = user.age
            
            if let url = user.urlAvatar {
                imgAvatar.kf.setImage(with: url)
                
            }
            btnDelete.isHidden = false
        }else{
            btnDelete.isHidden = true
        }
    }

    
    // MARK: - IBAction
    @IBAction func logoutBtnPressed(){
        VOFBAuthService.shared.signOut()
    }
    
    @IBAction func deleteBtnPressed(){
        btnDelete.showLoading()
        VOFBDataService.shared.deleteMyUser { (error) in
            self.btnDelete.hideLoading()
            if let error = error {
                self.showMessagePrompt(error)
            }else{
                VOFBAuthService.shared.signOut()
            }
        }
        
    }


}