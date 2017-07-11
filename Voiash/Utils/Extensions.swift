//
//  Extensions.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/4/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit


extension UINavigationController {
    
    public func presentWhiteNavigationBar() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = K.color.colorRed
        self.navigationBar.barTintColor = K.color.colorRed
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:K.color.colorRed]
        
        setNavigationBarHidden(false, animated:true)
    }
    
    public func hideWhiteNavigationBar() {
        setNavigationBarHidden(true, animated:false)
    }
    
    public func presentTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        setNavigationBarHidden(false, animated:true)
    }
    
    public func hideTransparentNavigationBar() {
        setNavigationBarHidden(true, animated:false)
        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
        navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
        navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    }
}

extension UINavigationItem {
    func customTitle(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Helvetica", size: 12)
        titleLabel.textColor = K.color.titleGray
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleView = titleLabel
    }
}

extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                
                if(self.characters.count>=6 && self.characters.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
}

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    var isValidAge: Bool {
        return self.age >= 18 ? true : false
    }
}

extension AppDelegate {
    func findCurrentViewController() -> UIViewController{
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        
        return findCurrentViewController(byTempTopVC: rootVC!)
    }
    
    func findCurrentViewController(byTempTopVC vc: UIViewController) -> UIViewController {
        let presentedVC = vc.presentedViewController
        
        guard presentedVC != nil else {
            return vc
        }
        
        if presentedVC!.isKind(of:UINavigationController.self) {
            let theNav =  presentedVC
            let theTopVC = theNav!.childViewControllers.last
            return findCurrentViewController(byTempTopVC: theTopVC!)
        }
        
        return findCurrentViewController(byTempTopVC: presentedVC!)
    }
}
