//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

extension UILabel{
    func getAtributes()->NSMutableAttributedString  {
        var mainAtribute : NSMutableAttributedString? = self.attributedText as? NSMutableAttributedString
        if (mainAtribute == nil) {
            mainAtribute = NSMutableAttributedString()
        }
        return mainAtribute!
    }
    
    func addAtribute(name:NSAttributedString.Key,value:Any,range:NSRange) {
        let textString = getAtributes()
        textString.addAttribute(name, value: value, range: range)
        self.attributedText = textString
    }
    
    func setText(text:String,image:UIImage,offsetX:CGFloat,offsetY:CGFloat){
        //Create Attachment
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: offsetX, y: offsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = getAtributes()
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: text)
        completeText.append(textAfterIcon)
        self.textAlignment = .center;
        self.attributedText = completeText;
    }
    
    func setLineSpacing(space:CGFloat) {
        let textString = getAtributes()
        if(textString.length>0){
            let textRange = NSRange(location: 0, length: textString.length)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = space
            textString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: textRange)
            self.attributedText = textString
        }
    }
    
    func setLineSpacing(text: String,space: CGFloat){
        let textString = NSMutableAttributedString(string: text)
        self.attributedText = textString
        setLineSpacing(space: space)
    }
    
    func setImage(image:UIImage){
        let attchment : NSTextAttachment = NSTextAttachment()
        attchment.image = image
        let offsetY: CGFloat = -4.5
        attchment.bounds = CGRect(x: 0, y: offsetY, width: (attchment.image?.size.width)!, height: (attchment.image?.size.height)!)
        
        let textString : NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attchment))
        textString.append(getAtributes())
        
        self.attributedText = textString
    }
}
