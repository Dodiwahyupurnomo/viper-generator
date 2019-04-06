//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

extension UIColor{
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static func compare(color1:UIColor,color2:UIColor,tolerance: CGFloat)->Bool{
        var r1,g1,b1,a1,r2,g2,b2,a2: CGFloat?
        color1.getRed(&r1!, green: &g1!, blue: &b1!, alpha: &a1!)
        color2.getRed(&r2!, green: &g2!, blue: &b2!, alpha: &a2!)
        
        return abs(r1!-r2!) <= tolerance && abs(g1!-g2!) <= tolerance && abs(b1!-b2!) <= tolerance && abs(a1!-a2!) <= tolerance
    }
}

