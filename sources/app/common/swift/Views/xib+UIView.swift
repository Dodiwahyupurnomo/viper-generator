//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit


class UIViewFromXIB: UIView {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var containerHeight: NSLayoutConstraint? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        viewContainer = loadViewFromNib()
        viewContainer.frame = bounds
        viewContainer.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addSubview(viewContainer)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}
