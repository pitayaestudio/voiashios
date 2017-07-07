//
//  PlaneView.swift
//
//  Code generated using QuartzCode 1.57.0 on 7/7/17.
//  www.quartzcodeapp.com
//

import UIKit


class PlaneView: UIView, CAAnimationDelegate {
    
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
    
    var flightAnimProgress: CGFloat = 0{
        didSet{
            if(!self.animationAdded){
                removeAllAnimations()
                addFlightAnimation()
                self.animationAdded = true
                layer.speed = 0
                layer.timeOffset = 0
            }
            else{
                let totalDuration : CGFloat = 6
                let offset = flightAnimProgress * totalDuration
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
        self.backgroundColor = UIColor.clear
        
        let img_avion = CALayer()
        self.layer.addSublayer(img_avion)
        img_avion.contents = UIImage(named:"login_bg_avion")?.cgImage
        layers["img_avion"] = img_avion
        
        let path = CAShapeLayer()
        self.layer.addSublayer(path)
        path.opacity     = 0
        path.fillColor   = UIColor.white.cgColor
        path.strokeColor = UIColor(red:1, green: 1, blue:1, alpha:0.96).cgColor
        path.lineWidth   = 0
        layers["path"] = path
        setupLayerFrames()
    }
    
    func setupLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let img_avion : CALayer = layers["img_avion"] as? CALayer{
            img_avion.frame = CGRect(x: 0.024 * img_avion.superlayer!.bounds.width, y: 0.12174 * img_avion.superlayer!.bounds.height, width: 0.074 * img_avion.superlayer!.bounds.width, height: 0.13043 * img_avion.superlayer!.bounds.height)
        }
        
        if let path : CAShapeLayer = layers["path"] as? CAShapeLayer{
            path.frame = CGRect(x: -0.05834 * path.superlayer!.bounds.width, y: 0.09367 * path.superlayer!.bounds.height, width: 1.26159 * path.superlayer!.bounds.width, height: 0.74309 * path.superlayer!.bounds.height)
            path.path  = pathPath(bounds: (layers["path"] as! CAShapeLayer).bounds).cgPath
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func addFlightAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 6.004
            completionAnim.delegate = self
            completionAnim.setValue("Flight", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.add(completionAnim, forKey:"Flight")
            if let anim = layer.animation(forKey: "Flight"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        self.layer.speed = 1
        self.animationAdded = false
        
        let fillMode : String = kCAFillModeForwards
        
        let img_avion = layers["img_avion"] as! CALayer
        
        ////Img_avion animation
        let img_avionPositionAnim             = CAKeyframeAnimation(keyPath:"position")
        img_avionPositionAnim.path            = pathPath(bounds: (layers["path"]?.superlayer??.convert((layers["path"] as! CAShapeLayer).frame, to:layers["img_avion"]?.superlayer))!).cgPath
        img_avionPositionAnim.rotationMode    = kCAAnimationRotateAuto
        img_avionPositionAnim.calculationMode = kCAAnimationPaced
        img_avionPositionAnim.duration        = 6
        
        let img_avionFlightAnim : CAAnimationGroup = QCMethod.group(animations: [img_avionPositionAnim], fillMode:fillMode)
        img_avion.add(img_avionFlightAnim, forKey:"img_avionFlightAnim")
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
        if identifier == "Flight"{
            QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["img_avion"] as! CALayer).animation(forKey: "img_avionFlightAnim"), theLayer:(layers["img_avion"] as! CALayer))
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "Flight"{
            (layers["img_avion"] as! CALayer).removeAnimation(forKey: "img_avionFlightAnim")
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
        
        pathPath.move(to: CGPoint(x:minX, y: minY + h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.4166 * w, y: minY + 0.64342 * h), controlPoint1:CGPoint(x:minX + 0.17613 * w, y: minY + 0.96609 * h), controlPoint2:CGPoint(x:minX + 0.35701 * w, y: minY + 0.90814 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.25973 * w, y: minY + 0.00088 * h), controlPoint1:CGPoint(x:minX + 0.46269 * w, y: minY + 0.43865 * h), controlPoint2:CGPoint(x:minX + 0.50448 * w, y: minY + -0.02288 * h))
        pathPath.addCurve(to: CGPoint(x:minX + 0.30528 * w, y: minY + 0.60208 * h), controlPoint1:CGPoint(x:minX + 0.02968 * w, y: minY + 0.02322 * h), controlPoint2:CGPoint(x:minX + 0.19311 * w, y: minY + 0.49969 * h))
        pathPath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.75755 * h), controlPoint1:CGPoint(x:minX + 0.49619 * w, y: minY + 0.77634 * h), controlPoint2:CGPoint(x:minX + 0.79144 * w, y: minY + 0.74382 * h))
        
        return pathPath
    }
    
    
}
