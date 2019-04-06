//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

@IBDesignable
class TextFieldWithLabel: UITextField {
    
    @IBInspectable var titlelabel: String? = nil {
        didSet{
            if titlelabel != nil, titlelabel!.count > 0 {
                label.text = titlelabel
                rightViewMode = .always
                rightView = label
            }else{
                rightViewMode = .never
                rightView = nil
            }
        }
    }
    
    fileprivate var label: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 42, height: 32))
        lbl.font = FONTS.medium(12)
        lbl.textColor = .white
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        self.backgroundColor = UIColor(red: 0x25, green: 0x27, blue: 0x3E)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        leftView = view
        leftViewMode = .always
        
        layer.cornerRadius = 8
        layer.masksToBounds = true

        textColor = .white
        font = FONTS.mediumRegular
        attributedPlaceholder = NSAttributedString(string: "0",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:FONTS.mediumRegular!])
    }
}
