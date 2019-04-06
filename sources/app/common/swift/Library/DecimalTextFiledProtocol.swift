//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

private class DecimalTextFieldHelper: NSObject,UITextFieldDelegate{
    func decimalFormating(to textField: UITextField){
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldValueChanged(_ textField: UITextField){
        guard var text = textField.text else { return  }
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9.]", options: [])
            text = regex.stringByReplacingMatches(in: text, options: [], range: NSMakeRange(0, text.count), withTemplate: "")
        } catch  {
            printLog(error.localizedDescription, mode: .error)
            return
        }
        
        let arrayStr = text.components(separatedBy: ".")
        let number = Double(arrayStr[0])
        if arrayStr.count > 1 {
            textField.text = (number?.decimalString(9) ?? "") + "." + arrayStr.last!
        }else{
            textField.text = text.contains(".") ? (Double(text)?.decimalString(9) ?? "") + "." : Double(text)?.decimalString(9)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        guard let oldText = textField.text , let r = Range(range, in: oldText)else {
            return true
        }
       
        let decimalSparator = Locale.current.decimalSeparator ?? "."
        
        if oldText == "0", string != decimalSparator, string != "" {
            return false
        }
        
        var newText = oldText.replacingCharacters(in: r, with: string == decimalSparator ? "." : string)
        
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9.]", options: [])
            newText = regex.stringByReplacingMatches(in: newText, options: [], range: NSMakeRange(0, newText.count), withTemplate: "")
        } catch  {
            return false
        }
        
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        if numberOfDots == 1 , string == decimalSparator, oldText.count > 0 {
            textField.text = (Double(newText.prefix(newText.count - 1))?.decimalString(9) ?? "") + "."
            return false
        }
        
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: Character(".")) {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }

        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 9
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return textField.superDelegate?.textFieldShouldReturn?(textField) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superDelegate?.textFieldDidEndEditing?(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superDelegate?.textFieldDidBeginEditing?(textField)
    }
}

/// Create namespace
@objc protocol DecimalTextFiledDelegate:UITextFieldDelegate {
}

/// Create address memory to store decimal helper object
private var addrsDecimalHelper: UInt = 0

/// create extentiob
extension DecimalTextFiledDelegate {
    func decimalFormating(sender: UITextFieldDelegate? = nil, to textField: UITextField){
        var helper = objc_getAssociatedObject(self, &addrsDecimalHelper) as? DecimalTextFieldHelper
        if helper == nil {
            helper = DecimalTextFieldHelper()
            objc_setAssociatedObject(self, &addrsDecimalHelper, helper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        textField.superDelegate = sender
        helper?.decimalFormating(to: textField)
    }
}

extension UITextField {
    var doubleString: String?{
        get{
            guard var str = text else { return nil }
            do {
                let regex = try NSRegularExpression(pattern: "[^0-9.]", options: [])
                str = regex.stringByReplacingMatches(in: str, options: [], range: NSMakeRange(0, str.count), withTemplate: "")
                return str
            } catch  {
                return nil
            }
        }
    }
    
    var double: Double? {
        get{
            guard let str = doubleString else { return nil }
            return Double(str)
        }
    }
    
    /// Must implementing `DecimalTextFiledDelegate` in this method
    func setDecimal(_ text: String?){
        self.text = text
        self.sendActions(for: .editingChanged)
    }
}

/// Custom textfield delegate
private var saveDelegate: UInt = 0

private extension UITextField {
    var superDelegate: UITextFieldDelegate?{
        get{
            return objc_getAssociatedObject(self, &saveDelegate) as? UITextFieldDelegate
        }
        
        set{
            objc_setAssociatedObject(self, &saveDelegate, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
