//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Foundation

extension KeyedDecodingContainer {
    subscript<T: Decodable>(key: KeyedDecodingContainer.Key) -> T? {
        return try? decode(T.self, forKey: key)
    }
}
