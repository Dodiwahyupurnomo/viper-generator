//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate , UIGestureRecognizerDelegate{
    var isKeyboardAnimate = true
    
    private let KEYBOARD_ANIMATION_DURATION: CGFloat = 0.25
    private let MINIMUM_SCROLL_FRACTION: CGFloat = 0.2
    private let MAXIMUM_SCROLL_FRACTION: CGFloat = 0.8
    private let PORTRAIT_KEYBOARD_HEIGHT: CGFloat = 150
    private let LANDSCAPE_KEYBOARD_HEIGHT: CGFloat = 140
    private var animatedDistance: CGFloat = 0.0
    private var defaultPointY: CGFloat = 0
    
    fileprivate var isLeftMenuShow: Bool = false
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        defaultPointY = view.frame.origin.y
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textDidBeginEdinting(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textDidEndEditing()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        textDidBeginEdinting(textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textDidEndEditing()
    }
    
    //MARK: - Method
    func textDidBeginEdinting(_ textField: UIView){
        let textFieldRect: CGRect = view.window!.convert(textField.bounds, from: textField)
        let viewRect: CGRect = view.window!.convert(view.bounds, from: view)
        let midline: CGFloat = textFieldRect.origin.y + 0.5 * textFieldRect.size.height
        let numerator: CGFloat = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height
        let denominator: CGFloat = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height
        var heightFraction: CGFloat = numerator / denominator
        
        if heightFraction < 0.0 {
            heightFraction = 0.0
        } else if heightFraction > 1.0 {
            heightFraction = 1.0
        }
        
        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        if orientation == .portrait || orientation == .portraitUpsideDown {
            animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction)
        } else {
            animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction)
        }
        
        var viewFrame: CGRect = view.frame
        viewFrame.origin.y -= animatedDistance + defaultPointY
        
        if isKeyboardAnimate {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(TimeInterval(KEYBOARD_ANIMATION_DURATION))
            
            view.frame = viewFrame
            
            UIView.commitAnimations()
        } else {
            view.frame = viewFrame
        }
    }
    
    func textDidEndEditing(){
        var viewFrame: CGRect = view.frame
        viewFrame.origin.y = defaultPointY
        
        if isKeyboardAnimate {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(TimeInterval(KEYBOARD_ANIMATION_DURATION))
            
            view.frame = viewFrame
            
            UIView.commitAnimations()
        } else {
            view.frame = viewFrame
        }
    }
    
    func closeKeyboard() {
        var viewFrame: CGRect = view.frame
        viewFrame.origin.y = defaultPointY
        
        if isKeyboardAnimate {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(TimeInterval(KEYBOARD_ANIMATION_DURATION))
            
            view.frame = viewFrame
            
            UIView.commitAnimations()
        } else {
            view.frame = viewFrame
        }
    }
    
    //MASK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
