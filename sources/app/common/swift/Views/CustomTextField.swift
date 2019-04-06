//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open var placeholder: String?{
        didSet{
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:FONTS.mediumRegular!])
        }
    }
    
    private func setup(){
        self.backgroundColor = UIColor(red: 0x25, green: 0x27, blue: 0x3E).withAlphaComponent(0.8)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        leftView = view
        leftViewMode = .always
        
        rightView = view
        rightViewMode = .always
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        textColor = .white
        font = FONTS.mediumRegular
        
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:FONTS.mediumRegular!])

    }
}
