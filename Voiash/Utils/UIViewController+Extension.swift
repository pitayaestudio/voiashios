//
//  UIViewController+Extension.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/11/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import SpaceView

extension UIViewController {
    
    func showAlert(typeAlert: SpaceStyles, message: String) {
        //let title = typeAlert == .success ? NSLocalizedString("successTitle", comment: "") : (typeAlert == .warning ? NSLocalizedString("warningTitle", comment: ""):NSLocalizedString("errorTitle", comment: ""))
        let color = typeAlert == .success ? K.color.colorRed : (typeAlert == .warning ? K.color.colorRed:K.color.colorRed)
        self.showSpace(title: "", description: message, spaceOptions: [.spaceStyle(style: typeAlert),.spacePosition(position: .top),.shouldAutoHide(should: true), .descriptionFont(font: UIFont(name: "Avenir-Book", size: 13.0)!), .titleFont(font: UIFont(name: "Avenir-Book", size: 13.0)!), .spaceColor(color: color)
            ])
    }
    
    func hideBack(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardView() {
        view.endEditing(true)
    }
}
