//
//  FlightCloudsView.swift
//
//  Code generated using QuartzCode 1.57.0 on 7/12/17.
//  www.quartzcodeapp.com
//

import UIKit


class FlightCloudsView: UIView, CAAnimationDelegate {
    
    var updateLayerValueForCompletedAnimation : Bool = false
    var animationAdded : Bool = false
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var layers : Dictionary<String, AnyObject> = [:]
    
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupProperties()
        setupLayers()
    }
    
    var flightCloudsAllScreenAnimProgress: CGFloat = 0{
        didSet{
            if(!self.animationAdded){
                removeAllAnimations()
                addFlightCloudsAllScreenAnimation()
                self.animationAdded = true
                layer.speed = 0
                layer.timeOffset = 0
            }
            else{
                let totalDuration : CGFloat = 60
                let offset = flightCloudsAllScreenAnimProgress * totalDuration
                layer.timeOffset = CFTimeInterval(offset)
            }
        }
    }
    
    override var frame: CGRect{
        didSet{
            setupLayerFrames()
        }
    }
    
    override var bounds: CGRect{
        didSet{
            setupLayerFrames()
        }
    }
    
    func setupProperties(){
        
    }
    
    func setupLayers(){
        self.backgroundColor = UIColor(red:0.129, green: 0.129, blue:0.129, alpha:0)
        
        let Group3 = CALayer()
        self.layer.addSublayer(Group3)
        
        layers["Group3"] = Group3
        let Group = CALayer()
        Group3.addSublayer(Group)
        Group.setValue(-360 * CGFloat.pi/180, forKeyPath:"transform.rotation")
        
        layers["Group"] = Group
        let nube = CALayer()
        Group.addSublayer(nube)
        nube.contents = UIImage(named:"nube1")?.cgImage
        layers["nube"] = nube
        let nube2 = CALayer()
        Group.addSublayer(nube2)
        nube2.contents = UIImage(named:"nube2")?.cgImage
        layers["nube2"] = nube2
        let nube3 = CALayer()
        Group.addSublayer(nube3)
        nube3.contents = UIImage(named:"nube3")?.cgImage
        layers["nube3"] = nube3
        let nube4 = CALayer()
        Group.addSublayer(nube4)
        nube4.contents = UIImage(named:"nube4")?.cgImage
        layers["nube4"] = nube4
        let nube5 = CALayer()
        Group.addSublayer(nube5)
        nube5.contents = UIImage(named:"nube5")?.cgImage
        layers["nube5"] = nube5
        let nube6 = CALayer()
        Group.addSublayer(nube6)
        nube6.contents = UIImage(named:"nube6")?.cgImage
        layers["nube6"] = nube6
        let nube7 = CALayer()
        Group.addSublayer(nube7)
        nube7.contents = UIImage(named:"nube7")?.cgImage
        layers["nube7"] = nube7
        let Group2 = CALayer()
        Group3.addSublayer(Group2)
        
        layers["Group2"] = Group2
        let nube8 = CALayer()
        Group2.addSublayer(nube8)
        nube8.contents = UIImage(named:"nube8")?.cgImage
        layers["nube8"] = nube8
        let nube9 = CALayer()
        Group2.addSublayer(nube9)
        nube9.contents = UIImage(named:"nube9")?.cgImage
        layers["nube9"] = nube9
        let nube10 = CALayer()
        Group2.addSublayer(nube10)
        nube10.contents = UIImage(named:"nube10")?.cgImage
        layers["nube10"] = nube10
        let nube11 = CALayer()
        Group2.addSublayer(nube11)
        nube11.contents = UIImage(named:"nube11")?.cgImage
        layers["nube11"] = nube11
        let nube12 = CALayer()
        Group2.addSublayer(nube12)
        nube12.contents = UIImage(named:"nube12")?.cgImage
        layers["nube12"] = nube12
        let nube13 = CALayer()
        Group2.addSublayer(nube13)
        nube13.contents = UIImage(named:"nube13")?.cgImage
        layers["nube13"] = nube13
        let nube14 = CALayer()
        Group2.addSublayer(nube14)
        nube14.contents = UIImage(named:"nube14")?.cgImage
        layers["nube14"] = nube14
        
        let path = CAShapeLayer()
        self.layer.addSublayer(path)
        path.fillColor = nil
        layers["path"] = path
        
        let login_bg_avion = CALayer()
        self.layer.addSublayer(login_bg_avion)
        login_bg_avion.contents = UIImage(named:"login_bg_avion")?.cgImage
        layers["login_bg_avion"] = login_bg_avion
        
        let logo_Voiash_sin_fondo_baja = CALayer()
        self.layer.addSublayer(logo_Voiash_sin_fondo_baja)
        logo_Voiash_sin_fondo_baja.contents = UIImage(named:"logo_Voiash_sin_fondo_baja")?.cgImage
        layers["logo_Voiash_sin_fondo_baja"] = logo_Voiash_sin_fondo_baja
        
        let path2 = CAShapeLayer()
        self.layer.addSublayer(path2)
        path2.fillColor = nil
        layers["path2"] = path2
        setupLayerFrames()
    }
    
    func setupLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let Group3 : CALayer = layers["Group3"] as? CALayer{
            Group3.frame = CGRect(x: -1.782 * Group3.superlayer!.bounds.width, y: 0.51415 * Group3.superlayer!.bounds.height, width: 2.86725 * Group3.superlayer!.bounds.width, height: 0.48585 * Group3.superlayer!.bounds.height)
        }
        
        if let Group : CALayer = layers["Group"] as? CALayer{
            Group.transform = CATransform3DIdentity
            Group.frame     = CGRect(x: 0, y: 0, width: 0.49359 * Group.superlayer!.bounds.width, height:  Group.superlayer!.bounds.height)
            Group.setValue(-360 * CGFloat.pi/180, forKeyPath:"transform.rotation")
        }
        
        if let nube : CALayer = layers["nube"] as? CALayer{
            nube.frame = CGRect(x: 0.16764 * nube.superlayer!.bounds.width, y: 0.18641 * nube.superlayer!.bounds.height, width: 0.39286 * nube.superlayer!.bounds.width, height: 0.74175 * nube.superlayer!.bounds.height)
        }
        
        if let nube2 : CALayer = layers["nube2"] as? CALayer{
            nube2.frame = CGRect(x: 0.4319 * nube2.superlayer!.bounds.width, y: 0.18252 * nube2.superlayer!.bounds.height, width: 0.2148 * nube2.superlayer!.bounds.width, height: 0.69515 * nube2.superlayer!.bounds.height)
        }
        
        if let nube3 : CALayer = layers["nube3"] as? CALayer{
            nube3.frame = CGRect(x: 0.84031 * nube3.superlayer!.bounds.width, y: 0, width: 0.03392 * nube3.superlayer!.bounds.width, height: 0.41942 * nube3.superlayer!.bounds.height)
        }
        
        if let nube4 : CALayer = layers["nube4"] as? CALayer{
            nube4.frame = CGRect(x: 0.72443 * nube4.superlayer!.bounds.width, y: 0.20971 * nube4.superlayer!.bounds.height, width: 0.03392 * nube4.superlayer!.bounds.width, height: 0.41942 * nube4.superlayer!.bounds.height)
        }
        
        if let nube5 : CALayer = layers["nube5"] as? CALayer{
            nube5.frame = CGRect(x: 0.60714 * nube5.superlayer!.bounds.width, y: 0.25825 * nube5.superlayer!.bounds.height, width: 0.39286 * nube5.superlayer!.bounds.width, height: 0.74175 * nube5.superlayer!.bounds.height)
        }
        
        if let nube6 : CALayer = layers["nube6"] as? CALayer{
            nube6.frame = CGRect(x: 0.84031 * nube6.superlayer!.bounds.width, y: 0, width: 0.03392 * nube6.superlayer!.bounds.width, height: 0.41942 * nube6.superlayer!.bounds.height)
        }
        
        if let nube7 : CALayer = layers["nube7"] as? CALayer{
            nube7.frame = CGRect(x: 0, y: 0.05631 * nube7.superlayer!.bounds.height, width: 0.2148 * nube7.superlayer!.bounds.width, height: 0.69515 * nube7.superlayer!.bounds.height)
        }
        
        if let Group2 : CALayer = layers["Group2"] as? CALayer{
            Group2.frame = CGRect(x: 0.50641 * Group2.superlayer!.bounds.width, y: 0, width: 0.49359 * Group2.superlayer!.bounds.width, height:  Group2.superlayer!.bounds.height)
        }
        
        if let nube8 : CALayer = layers["nube8"] as? CALayer{
            nube8.frame = CGRect(x: 0.16764 * nube8.superlayer!.bounds.width, y: 0.17476 * nube8.superlayer!.bounds.height, width: 0.39286 * nube8.superlayer!.bounds.width, height: 0.74175 * nube8.superlayer!.bounds.height)
        }
        
        if let nube9 : CALayer = layers["nube9"] as? CALayer{
            nube9.frame = CGRect(x: 0.4319 * nube9.superlayer!.bounds.width, y: 0.18252 * nube9.superlayer!.bounds.height, width: 0.2148 * nube9.superlayer!.bounds.width, height: 0.69515 * nube9.superlayer!.bounds.height)
        }
        
        if let nube10 : CALayer = layers["nube10"] as? CALayer{
            nube10.frame = CGRect(x: 0.84031 * nube10.superlayer!.bounds.width, y: 0, width: 0.03392 * nube10.superlayer!.bounds.width, height: 0.41942 * nube10.superlayer!.bounds.height)
        }
        
        if let nube11 : CALayer = layers["nube11"] as? CALayer{
            nube11.frame = CGRect(x: 0.72443 * nube11.superlayer!.bounds.width, y: 0.20971 * nube11.superlayer!.bounds.height, width: 0.03392 * nube11.superlayer!.bounds.width, height: 0.41942 * nube11.superlayer!.bounds.height)
        }
        
        if let nube12 : CALayer = layers["nube12"] as? CALayer{
            nube12.frame = CGRect(x: 0.60714 * nube12.superlayer!.bounds.width, y: 0.25825 * nube12.superlayer!.bounds.height, width: 0.39286 * nube12.superlayer!.bounds.width, height: 0.74175 * nube12.superlayer!.bounds.height)
        }
        
        if let nube13 : CALayer = layers["nube13"] as? CALayer{
            nube13.frame = CGRect(x: 0.84031 * nube13.superlayer!.bounds.width, y: 0, width: 0.03392 * nube13.superlayer!.bounds.width, height: 0.41942 * nube13.superlayer!.bounds.height)
        }
        
        if let nube14 : CALayer = layers["nube14"] as? CALayer{
            nube14.frame = CGRect(x: 0, y: 0.05631 * nube14.superlayer!.bounds.height, width: 0.2148 * nube14.superlayer!.bounds.width, height: 0.69515 * nube14.superlayer!.bounds.height)
        }
        
        if let path : CAShapeLayer = layers["path"] as? CAShapeLayer{
            path.frame = CGRect(x: -0.068 * path.superlayer!.bounds.width, y: 0.59607 * path.superlayer!.bounds.height, width: 1.13769 * path.superlayer!.bounds.width, height: 0.32275 * path.superlayer!.bounds.height)
            path.path  = pathPath(bounds: (layers["path"] as! CAShapeLayer).bounds).cgPath
        }
        
        if let login_bg_avion : CALayer = layers["login_bg_avion"] as? CALayer{
            login_bg_avion.frame = CGRect(x: -0.12 * login_bg_avion.superlayer!.bounds.width, y: 0.87944 * login_bg_avion.superlayer!.bounds.height, width: 0.074 * login_bg_avion.superlayer!.bounds.width, height: 0.06038 * login_bg_avion.superlayer!.bounds.height)
        }
        
        if let logo_Voiash_sin_fondo_baja : CALayer = layers["logo_Voiash_sin_fondo_baja"] as? CALayer{
            logo_Voiash_sin_fondo_baja.frame = CGRect(x: 0.256 * logo_Voiash_sin_fondo_baja.superlayer!.bounds.width, y: 0.38302 * logo_Voiash_sin_fondo_baja.superlayer!.bounds.height, width: 0.448 * logo_Voiash_sin_fondo_baja.superlayer!.bounds.width, height: 0.13962 * logo_Voiash_sin_fondo_baja.superlayer!.bounds.height)
        }
        
        if let path2 : CAShapeLayer = layers["path2"] as? CAShapeLayer{
            path2.frame = CGRect(x: -0.16477 * path2.superlayer!.bounds.width, y: -0.33626 * path2.superlayer!.bounds.height, width: 0.95599 * path2.superlayer!.bounds.width, height: 1.2074 * path2.superlayer!.bounds.height)
            path2.path  = path2Path(bounds: (layers["path2"] as! CAShapeLayer).bounds).cgPath
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func addPlaneAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 100000
            completionAnim.delegate = self
            completionAnim.setValue("Plane", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.add(completionAnim, forKey:"Plane")
            if let anim = layer.animation(forKey: "Plane"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        self.layer.speed = 1
        self.animationAdded = false
        
        let fillMode : String = kCAFillModeForwards
        
        let nube = layers["nube"] as! CALayer
        
        ////Nube animation
        let nubePositionAnim          = CAKeyframeAnimation(keyPath:"position")
        nubePositionAnim.duration     = 6.02
        nubePositionAnim.repeatCount  = Float.infinity
        nubePositionAnim.autoreverses = true
        
        let nubePlaneAnim : CAAnimationGroup = QCMethod.group(animations: [nubePositionAnim], fillMode:fillMode)
        nubePlaneAnim.repeatCount = 10
        nube.add(nubePlaneAnim, forKey:"nubePlaneAnim")
        
        let nube5 = layers["nube5"] as! CALayer
        
        ////Nube5 animation
        let nube5PositionAnim          = CAKeyframeAnimation(keyPath:"position")
        nube5PositionAnim.duration     = 6.02
        nube5PositionAnim.repeatCount  = Float.infinity
        nube5PositionAnim.autoreverses = true
        
        let nube5PlaneAnim : CAAnimationGroup = QCMethod.group(animations: [nube5PositionAnim], fillMode:fillMode)
        nube5PlaneAnim.repeatCount = 10
        nube5.add(nube5PlaneAnim, forKey:"nube5PlaneAnim")
        
        let nube8 = layers["nube8"] as! CALayer
        
        ////Nube8 animation
        let nube8PositionAnim          = CAKeyframeAnimation(keyPath:"position")
        nube8PositionAnim.duration     = 6.02
        nube8PositionAnim.repeatCount  = Float.infinity
        nube8PositionAnim.autoreverses = true
        
        let nube8PlaneAnim : CAAnimationGroup = QCMethod.group(animations: [nube8PositionAnim], fillMode:fillMode)
        nube8PlaneAnim.repeatCount = 10
        nube8.add(nube8PlaneAnim, forKey:"nube8PlaneAnim")
        
        let nube12 = layers["nube12"] as! CALayer
        
        ////Nube12 animation
        let nube12PositionAnim          = CAKeyframeAnimation(keyPath:"position")
        nube12PositionAnim.duration     = 6.02
        nube12PositionAnim.repeatCount  = Float.infinity
        nube12PositionAnim.autoreverses = true
        
        let nube12PlaneAnim : CAAnimationGroup = QCMethod.group(animations: [nube12PositionAnim], fillMode:fillMode)
        nube12PlaneAnim.repeatCount = 10
        nube12.add(nube12PlaneAnim, forKey:"nube12PlaneAnim")
        
        let login_bg_avion = layers["login_bg_avion"] as! CALayer
        
        ////Login_bg_avion animation
        var pathRect1                       = layers["path"]?.bounds
        pathRect1?.origin.x += (layers["login_bg_avion"]?.position.x)! - 0.00000 * (pathRect1?.width)!
        pathRect1?.origin.y += (layers["login_bg_avion"]?.position.y)! - 0.98826 * (pathRect1?.height)!
        let login_bg_avionPositionAnim      = CAKeyframeAnimation(keyPath:"position")
        login_bg_avionPositionAnim.path     = pathPath(bounds: pathRect1!).cgPath
        login_bg_avionPositionAnim.rotationMode = kCAAnimationRotateAuto
        login_bg_avionPositionAnim.duration = 7.01
        
        let login_bg_avionPlaneAnim : CAAnimationGroup = QCMethod.group(animations: [login_bg_avionPositionAnim], fillMode:fillMode)
        login_bg_avion.add(login_bg_avionPlaneAnim, forKey:"login_bg_avionPlaneAnim")
    }
    
    func addCloudsAnimation(){
        self.layer.speed = 1
        self.animationAdded = false
        
        let fillMode : String = kCAFillModeForwards
        
        ////An infinity animation
        
        let Group3 = layers["Group3"] as! CALayer
        
        ////Group3 animation
        let Group3PositionAnim         = CAKeyframeAnimation(keyPath:"position")
        Group3PositionAnim.values      = [NSValue(cgPoint: CGPoint(x: -0.34837 * Group3.superlayer!.bounds.width, y: 0.75708 * Group3.superlayer!.bounds.height)), NSValue(cgPoint: CGPoint(x: 1.29162 * Group3.superlayer!.bounds.width, y: 0.75708 * Group3.superlayer!.bounds.height))]
        Group3PositionAnim.keyTimes    = [0, 1]
        Group3PositionAnim.duration    = 6.97
        Group3PositionAnim.repeatCount = Float.infinity
        
        let Group3CloudsAnim : CAAnimationGroup = QCMethod.group(animations: [Group3PositionAnim], fillMode:fillMode)
        Group3.add(Group3CloudsAnim, forKey:"Group3CloudsAnim")
        
        let login_bg_avion = layers["login_bg_avion"] as! CALayer
        
        ////Login_bg_avion animation
        let login_bg_avionPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        login_bg_avionPositionAnim.path      = pathPath(bounds: (layers["path"]?.superlayer??.convert((layers["path"] as! CAShapeLayer).frame, to:layers["login_bg_avion"]?.superlayer))!).cgPath
        login_bg_avionPositionAnim.rotationMode = kCAAnimationRotateAuto
        login_bg_avionPositionAnim.duration  = 1
        login_bg_avionPositionAnim.beginTime = 28.9
        
        let login_bg_avionCloudsAnim : CAAnimationGroup = QCMethod.group(animations: [login_bg_avionPositionAnim], fillMode:fillMode)
        login_bg_avion.add(login_bg_avionCloudsAnim, forKey:"login_bg_avionCloudsAnim")
    }
    
    func addFlightCloudsAnimation(){
        self.layer.speed = 1
        self.animationAdded = false
        
        let fillMode : String = kCAFillModeForwards
        
        ////An infinity animation
        
        let Group3 = layers["Group3"] as! CALayer
        
        ////Group3 animation
        let Group3PositionAnim         = CAKeyframeAnimation(keyPath:"position")
        Group3PositionAnim.values      = [NSValue(cgPoint: CGPoint(x: -0.34837 * Group3.superlayer!.bounds.width, y: 0.75708 * Group3.superlayer!.bounds.height)), NSValue(cgPoint: CGPoint(x: 1.29162 * Group3.superlayer!.bounds.width, y: 0.75708 * Group3.superlayer!.bounds.height))]
        Group3PositionAnim.keyTimes    = [0, 1]
        Group3PositionAnim.duration    = 60
        Group3PositionAnim.repeatCount = Float.infinity
        
        let Group3FlightCloudsAnim : CAAnimationGroup = QCMethod.group(animations: [Group3PositionAnim], fillMode:fillMode)
        Group3.add(Group3FlightCloudsAnim, forKey:"Group3FlightCloudsAnim")
        
        let login_bg_avion = layers["login_bg_avion"] as! CALayer
        
        ////Login_bg_avion animation
        let login_bg_avionPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        login_bg_avionPositionAnim.path      = pathPath(bounds: (layers["path"]?.superlayer??.convert((layers["path"] as! CAShapeLayer).frame, to:layers["login_bg_avion"]?.superlayer))!).cgPath
        login_bg_avionPositionAnim.rotationMode = kCAAnimationRotateAuto
        login_bg_avionPositionAnim.duration  = 15
        login_bg_avionPositionAnim.beginTime = 3.02
        
        let login_bg_avionFlightCloudsAnim : CAAnimationGroup = QCMethod.group(animations: [login_bg_avionPositionAnim], fillMode:fillMode)
        login_bg_avion.add(login_bg_avionFlightCloudsAnim, forKey:"login_bg_avionFlightCloudsAnim")
    }
    
    func addFlightCloudsAllScreenAnimation(){
        self.layer.speed = 1
        self.animationAdded = false
        
        let fillMode : String = kCAFillModeForwards
        
        ////An infinity animation
        
        let Group3 = layers["Group3"] as! CALayer
        
        ////Group3 animation
        let Group3PositionAnim         = CAKeyframeAnimation(keyPath:"position")
        Group3PositionAnim.values      = [NSValue(cgPoint: CGPoint(x: -0.34837 * Group3.superlayer!.bounds.width, y: 0.75708 * Group3.superlayer!.bounds.height)), NSValue(cgPoint: CGPoint(x: 1.29162 * Group3.superlayer!.bounds.width, y: 0.75708 * Group3.superlayer!.bounds.height))]
        Group3PositionAnim.keyTimes    = [0, 1]
        Group3PositionAnim.duration    = 60
        Group3PositionAnim.repeatCount = Float.infinity
        
        let Group3FlightCloudsAllScreenAnim : CAAnimationGroup = QCMethod.group(animations: [Group3PositionAnim], fillMode:fillMode)
        Group3.add(Group3FlightCloudsAllScreenAnim, forKey:"Group3FlightCloudsAllScreenAnim")
        
        let login_bg_avion = layers["login_bg_avion"] as! CALayer
        
        ////Login_bg_avion animation
        let login_bg_avionPositionAnim       = CAKeyframeAnimation(keyPath:"position")
        login_bg_avionPositionAnim.path      = path2Path(bounds: (layers["path2"]?.superlayer??.convert((layers["path2"] as! CAShapeLayer).frame, to:layers["login_bg_avion"]?.superlayer))!).cgPath
        login_bg_avionPositionAnim.rotationMode = kCAAnimationRotateAuto
        login_bg_avionPositionAnim.duration  = 7
        login_bg_avionPositionAnim.beginTime = 0.7
        
        let login_bg_avionFlightCloudsAllScreenAnim : CAAnimationGroup = QCMethod.group(animations: [login_bg_avionPositionAnim], fillMode:fillMode)
        login_bg_avion.add(login_bg_avionFlightCloudsAllScreenAnim, forKey:"login_bg_avionFlightCloudsAllScreenAnim")
    }
    
    //MARK: - Animation Cleanup
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValue(forKey: anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
                updateLayerValues(forAnimationId: anim.value(forKey: "animId") as! String)
                removeAnimations(forAnimationId: anim.value(forKey: "animId") as! String)
            }
            completionBlock(flag)
        }
    }
    
    func updateLayerValues(forAnimationId identifier: String){
        if identifier == "Plane"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["nube"] as! CALayer).animation(forKey: "nubePlaneAnim"), theLayer:(layers["nube"] as! CALayer))
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["nube5"] as! CALayer).animation(forKey: "nube5PlaneAnim"), theLayer:(layers["nube5"] as! CALayer))
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["nube8"] as! CALayer).animation(forKey: "nube8PlaneAnim"), theLayer:(layers["nube8"] as! CALayer))
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["nube12"] as! CALayer).animation(forKey: "nube12PlaneAnim"), theLayer:(layers["nube12"] as! CALayer))
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["login_bg_avion"] as! CALayer).animation(forKey: "login_bg_avionPlaneAnim"), theLayer:(layers["login_bg_avion"] as! CALayer))
        }
        else if identifier == "Clouds"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["Group3"] as! CALayer).animation(forKey: "Group3CloudsAnim"), theLayer:(layers["Group3"] as! CALayer))
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["login_bg_avion"] as! CALayer).animation(forKey: "login_bg_avionCloudsAnim"), theLayer:(layers["login_bg_avion"] as! CALayer))
        }
        else if identifier == "FlightClouds"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["Group3"] as! CALayer).animation(forKey: "Group3FlightCloudsAnim"), theLayer:(layers["Group3"] as! CALayer))
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["login_bg_avion"] as! CALayer).animation(forKey: "login_bg_avionFlightCloudsAnim"), theLayer:(layers["login_bg_avion"] as! CALayer))
        }
        else if identifier == "FlightCloudsAllScreen"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["Group3"] as! CALayer).animation(forKey: "Group3FlightCloudsAllScreenAnim"), theLayer:(layers["Group3"] as! CALayer))
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["login_bg_avion"] as! CALayer).animation(forKey: "login_bg_avionFlightCloudsAllScreenAnim"), theLayer:(layers["login_bg_avion"] as! CALayer))
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "Plane"{
            (layers["nube"] as! CALayer).removeAnimation(forKey: "nubePlaneAnim")
            (layers["nube5"] as! CALayer).removeAnimation(forKey: "nube5PlaneAnim")
            (layers["nube8"] as! CALayer).removeAnimation(forKey: "nube8PlaneAnim")
            (layers["nube12"] as! CALayer).removeAnimation(forKey: "nube12PlaneAnim")
            (layers["login_bg_avion"] as! CALayer).removeAnimation(forKey: "login_bg_avionPlaneAnim")
        }
        else if identifier == "Clouds"{
            (layers["Group3"] as! CALayer).removeAnimation(forKey: "Group3CloudsAnim")
            (layers["login_bg_avion"] as! CALayer).removeAnimation(forKey: "login_bg_avionCloudsAnim")
        }
        else if identifier == "FlightClouds"{
            (layers["Group3"] as! CALayer).removeAnimation(forKey: "Group3FlightCloudsAnim")
            (layers["login_bg_avion"] as! CALayer).removeAnimation(forKey: "login_bg_avionFlightCloudsAnim")
        }
        else if identifier == "FlightCloudsAllScreen"{
            (layers["Group3"] as! CALayer).removeAnimation(forKey: "Group3FlightCloudsAllScreenAnim")
            (layers["login_bg_avion"] as! CALayer).removeAnimation(forKey: "login_bg_avionFlightCloudsAllScreenAnim")
        }
        self.layer.speed = 1
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            (layer as! CALayer).removeAllAnimations()
        }
        self.layer.speed = 1
    }
    
    //MARK: - Bezier Path
    
    func pathPath(bounds: CGRect) -> UIBezierPath{
        let pathPath = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        pathPath.move(to: CGPoint(x:minX, y: minY + 0.98826 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.07437 * w, y: minY + 0.99835 * h), controlPoint1:CGPoint(x:minX + 0.02479 * w, y: minY + 0.99162 * h), controlPoint2:CGPoint(x:minX + 0.04961 * w, y: minY + 1.00453 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.25452 * w, y: minY + 0.3351 * h), controlPoint1:CGPoint(x:minX + 0.15311 * w, y: minY + 0.97868 * h), controlPoint2:CGPoint(x:minX + 0.17798 * w, y: minY + 0.46753 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.58675 * w, y: minY + 0.58911 * h), controlPoint1:CGPoint(x:minX + 0.37459 * w, y: minY + 0.12737 * h), controlPoint2:CGPoint(x:minX + 0.46816 * w, y: minY + 0.73063 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.66173 * w, y: minY + 0.01346 * h), controlPoint1:CGPoint(x:minX + 0.62701 * w, y: minY + 0.54107 * h), controlPoint2:CGPoint(x:minX + 0.72774 * w, y: minY + 0.2085 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.57315 * w, y: minY + 0.3267 * h), controlPoint1:CGPoint(x:minX + 0.63698 * w, y: minY + -0.05967 * h), controlPoint2:CGPoint(x:minX + 0.55525 * w, y: minY + 0.18241 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.80214 * w, y: minY + 0.52015 * h), controlPoint1:CGPoint(x:minX + 0.6212 * w, y: minY + 0.71402 * h), controlPoint2:CGPoint(x:minX + 0.72381 * w, y: minY + 0.74926 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.85044 * w, y: minY + 0.27513 * h), controlPoint1:CGPoint(x:minX + 0.82265 * w, y: minY + 0.46015 * h), controlPoint2:CGPoint(x:minX + 0.83297 * w, y: minY + 0.35125 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.89552 * w, y: minY + 0.11335 * h), controlPoint1:CGPoint(x:minX + 0.86421 * w, y: minY + 0.21516 * h), controlPoint2:CGPoint(x:minX + 0.87823 * w, y: minY + 0.15231 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.94658 * w, y: minY + 0.05841 * h), controlPoint1:CGPoint(x:minX + 0.91109 * w, y: minY + 0.07824 * h), controlPoint2:CGPoint(x:minX + 0.92919 * w, y: minY + 0.0679 * h))
        pathPath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.05637 * h), controlPoint1:CGPoint(x:minX + 0.96425 * w, y: minY + 0.04878 * h), controlPoint2:CGPoint(x:minX + 0.98219 * w, y: minY + 0.05705 * h))
        
        return pathPath
    }
    
    func path2Path(bounds: CGRect) -> UIBezierPath{
        let path2Path = UIBezierPath()
        let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
        
        path2Path.move(to: CGPoint(x:minX, y: minY + 0.96865 * h))
        path2Path.addCurve(to: CGPoint(x:minX + 0.10632 * w, y: minY + 0.96865 * h), controlPoint1:CGPoint(x:minX + 0.03544 * w, y: minY + 0.96865 * h), controlPoint2:CGPoint(x:minX + 0.07106 * w, y: minY + 0.966 * h))
        path2Path.addCurve(to: CGPoint(x:minX + 0.54307 * w, y: minY + 0.98586 * h), controlPoint1:CGPoint(x:minX + 0.23087 * w, y: minY + 0.97802 * h), controlPoint2:CGPoint(x:minX + 0.41339 * w, y: minY + 1.02224 * h))
        path2Path.addCurve(to: CGPoint(x:minX + 0.99731 * w, y: minY + 0.4675 * h), controlPoint1:CGPoint(x:minX + 0.78405 * w, y: minY + 0.91826 * h), controlPoint2:CGPoint(x:minX + 1.02841 * w, y: minY + 0.65865 * h))
        path2Path.addCurve(to: CGPoint(x:minX + 0.71529 * w, y: minY), controlPoint1:CGPoint(x:minX + 0.97464 * w, y: minY + 0.32812 * h), controlPoint2:CGPoint(x:minX + 0.79092 * w, y: minY + 0.10577 * h))
        
        return path2Path
    }
    
    
}
