//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

extension UINavigationBar{
    
    func findHairlineImageViewUder(view:UIView)-> UIImageView? {
        if(view is UIImageView && view.bounds.size.height <= 1){
            return (view as! UIImageView)
        }
        
        for view in view.subviews {
            let imageView : UIImageView? = self.findHairlineImageViewUder(view: view)
            if(imageView != nil){
                return imageView!
            }
        }
        return nil
    }
    
    func hideBottomHairline(){
        let navBarHeirlineImageView : UIImageView? = self.findHairlineImageViewUder(view: self)
        navBarHeirlineImageView?.isHidden = true
    }
    
    func showBottomHairlaine(){
        //show 1px hairlaine of transculancent navbar
        let navBarHairlaineImageview : UIImageView = self.findHairlineImageViewUder(view: self)!
        navBarHairlaineImageview.isHidden = false
    }
    
    func makeTransparent(){
        self.setBackgroundImage(UIImage(), for: .default)
        self.isTranslucent = true
        self.backgroundColor = .clear
        self.shadowImage = UIImage()
        self.hideBottomHairline()
    }
    
    func makeDefault(){
        self.isTranslucent = true
        self.setBackgroundImage(nil, for: .default)
        self.backgroundColor = nil
        self.shadowImage = nil
        self.showBottomHairlaine()
    }
    
    func setColor(color:UIColor){
        self.isTranslucent = false
        self.setBackgroundImage(nil, for: .default)
        self.backgroundColor = color
        self.shadowImage = nil
        self.barTintColor = color
        self.shadowImage = UIImage()
        self.hideBottomHairline()
    }
    
    func setColorWithLine(color: UIColor){
        self.setColor(color: color)
        self.showBottomHairlaine()
    }
    
}


