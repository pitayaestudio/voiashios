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

extension UIImageView{
    func addBlackGradientLayer(frame: CGRect){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.5]
        self.layer.addSublayer(gradient)
    }
    
    func imageWithGradient() {
        
        UIGraphicsBeginImageContext(self.image!.size)
        let context = UIGraphicsGetCurrentContext()
        
        self.image!.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.0, 1.0]
        
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        let colors = [top, bottom] as CFArray
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
        
        let startPoint = CGPoint(x: self.image!.size.width/2, y: 0)
        let endPoint = CGPoint(x: self.image!.size.width/2, y: self.image!.size.height)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
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
