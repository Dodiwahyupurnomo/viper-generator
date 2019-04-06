//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

private var associateObjectValue: Int = 0
private var runingAnimationObjectValue: Int = 0

private extension UIView {
    
    @IBInspectable var shimmerAnimation: Bool  {
        get {
            return isAnimate
        }
        set {
            self.isAnimate = newValue
        }
    }
    
    private var isAnimate: Bool {
        get {
            return objc_getAssociatedObject(self, &associateObjectValue) as? Bool ?? false
        }
        set {
            return objc_setAssociatedObject(self, &associateObjectValue,
                                            newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
    private var runningAnimation: Bool {
        get{
            return objc_getAssociatedObject(self, &runingAnimationObjectValue) as? Bool ?? false
        }
        set{
            return objc_setAssociatedObject(self, &runingAnimationObjectValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}

extension UIView {
    
    func startAnimation(color: UIColor = .white,repeatCount: Float? = .infinity,duration: Double = 1.5,_ completion: (()->Void)? = nil) {
        for animateView in getSubViewsForAnimate() {
            guard !runningAnimation else {return}
            runningAnimation = true
            CATransaction.begin()
            if repeatCount == nil {
                CATransaction.setCompletionBlock({
                    self.stopAnimation()
                    completion?()
                })
            }else{
                CATransaction.setCompletionBlock(completion)
            }
            animateView.clipsToBounds = true
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
            gradientLayer.frame = animateView.bounds
            animateView.layer.mask = gradientLayer
            
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = duration
            animation.fromValue = -animateView.frame.size.width
            animation.toValue = animateView.frame.size.width
            if let count = repeatCount {
                animation.repeatCount = count
            }
            gradientLayer.add(animation, forKey: "VDSShimmerAnimation")
            CATransaction.commit()
        }
    }
    
    func stopAnimation() {
        
        for animateView in getSubViewsForAnimate() {
            animateView.layer.removeAllAnimations()
            animateView.layer.mask = nil
        }
        
        runningAnimation = false
    }
}

// MARK: - Other Method(s)
private extension UIView {
    
    func getSubViewsForAnimate() -> [UIView] {
        var obj: [UIView] = []
        for objView in subviewsRecursive() {
            obj.append(objView)
        }
        return obj.filter({ (obj) -> Bool in
            obj.shimmerAnimation
        })
    }
}

