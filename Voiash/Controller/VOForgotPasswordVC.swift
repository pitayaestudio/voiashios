//
//  VOForgotPasswordVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import TextFieldEffects

class VOForgotPasswordVC: UIViewController {

    @IBOutlet weak var tfEmail: TextFieldEffects!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBOutlet
    @IBAction func resetPassBtnPressed(_ sender: AnyObject) {
        
    }

}
