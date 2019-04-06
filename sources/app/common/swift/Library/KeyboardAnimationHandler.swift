//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit


protocol KeyboardAnimationHandlerProtocol:class {
    var scrollViewBottomConstraint: NSLayoutConstraint! {get set}
    var mainScrolView: CustomScrollView! {get set}
    var keyboardAnimationHandler: KeyboardAnimationHandler? {get set}
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
}


class KeyboardAnimationHandler {
    var controller: UIViewController!
    var scrollViewBottomConstraint: NSLayoutConstraint!
    var mainScrolView: CustomScrollView!
    
    init(sender: UIViewController!, scrollView: CustomScrollView!,bottomConstraint: NSLayoutConstraint!) {
        self.controller = sender
        self.scrollViewBottomConstraint = bottomConstraint
        self.mainScrolView = scrollView
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        controller.view.addGestureRecognizer(gesture)
    
    }
    
    @objc func keyboardWillShow(_ notif: Notification){
        let userInfo = notif.userInfo
        let keyboadHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero).height
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.1
        
        scrollViewBottomConstraint.constant = keyboadHeight
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(TimeInterval(duration))
        UIView.setAnimationBeginsFromCurrentState(true)
        mainScrolView.layoutIfNeeded()
        controller.view.layoutIfNeeded()
        UIView.commitAnimations()
    }
    
    @objc func keyboardWillHide(_ notif:Notification){
        let userInfo = notif.userInfo
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.1
        
        scrollViewBottomConstraint.constant = 0
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(TimeInterval(duration))
        UIView.setAnimationBeginsFromCurrentState(true)
        mainScrolView.layoutIfNeeded()
        controller.view.layoutIfNeeded()
        UIView.commitAnimations()
    }
    
    @objc  func hideKeyboard(){
        controller.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension KeyboardAnimationHandlerProtocol where Self: UIViewController {
    
    func initKeyboardAnimationHandler(){
        keyboardAnimationHandler = KeyboardAnimationHandler(sender: self, scrollView: mainScrolView, bottomConstraint: scrollViewBottomConstraint)
    }
    
    func willTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // Save the contentOffsetRatio before we rotate so we can
        // properly determine the new content offset
        let ratio = mainScrolView.contentOffsetRatio
        coordinator.animateAlongsideTransition(in: nil, animation: { (contex) in
            self.mainScrolView.determineNewContentOffsetForRatio(ratio: ratio)
        }, completion: nil)
    }
}
