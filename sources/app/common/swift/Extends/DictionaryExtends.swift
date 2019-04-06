//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Foundation

extension Dictionary{
    func queryString()->String{
        return self.compactMap({ (key,value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
    }
}
