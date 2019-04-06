//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

extension UIView {
    var accumulatedWidth: CGFloat  {
        get{
            return self.bounds.size.width + self.frame.origin.x
        }
    }
    
    var accumulatedHeight: CGFloat {
        get{
            return self.bounds.size.height + self.frame.origin.y
        }
    }
    
    func round(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners: corners, radius: radius)
    }
    
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
    }
    
    static func identifier()->String{
        let type = String(describing: self)
        return type
    }
    
    static func nib()->UINib{
        return UINib(nibName: self.identifier(), bundle: nil)
    }
    
    func setShadow(opacity:Float,widthOffset:CGFloat,heightOffset:CGFloat,radius:CGFloat,color:UIColor)  {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: widthOffset, height: heightOffset)
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
    }
    
    func setGlowsShadow(){
        setShadow(opacity: 0.3, widthOffset: 0.0, heightOffset: 0.0, radius: 8, color: .gray)
    }
    
    func setGlowsShadow(color: UIColor){
        setShadow(opacity: 0.3, widthOffset: 0.0, heightOffset: 0.0, radius: 8, color: color)
    }
     
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
