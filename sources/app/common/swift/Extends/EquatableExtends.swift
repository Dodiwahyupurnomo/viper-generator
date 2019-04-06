//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit
#if !TRIV_WIDGET
extension Equatable {
    func share() {
        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        UIApplication.shared.keyWindow?.rootViewController?.topViewController()?.present(activity, animated: true, completion: nil)
    }
}
#endif
