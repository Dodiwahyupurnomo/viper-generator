//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

protocol HideableHairlineViewController {
    
    func hideHairline()
    func showHairline()
}

extension HideableHairlineViewController where Self: UIViewController {
    
    func hideHairline() {
        findHairline()?.isHidden = true
    }
    
    func showHairline() {
        findHairline()?.isHidden = false
    }
    
    private func findHairline() -> UIImageView? {
        let navBar = navigationController?.navigationBar
        let views = navBar?.subviews.flatMap({$0.subviews})
        let imageViews = views?.compactMap({$0 as? UIImageView})
        let findViewWithEqualWidth = imageViews?.filter({ $0.bounds.size.width == self.navigationController?.navigationBar.bounds.size.width})
        let findViewWithHeighLessThan2 = findViewWithEqualWidth?.filter({$0.bounds.size.height <= 2})
        return findViewWithHeighLessThan2?.first
    }
    
}
