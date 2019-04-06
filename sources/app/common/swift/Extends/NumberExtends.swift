//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Foundation
import UIKit

protocol Number {
    func currencyString()->String?
    func decimalString(_ maxFractionDigits: Int)->String?
}

extension Number {
    /// Convert number format to currency
    func currencyString()->String?{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        guard let currency = formatter.string(for: self) else {return nil}
        
        #if TRIV
        return  currency.components(separatedBy: ".").first
        #else
        return currency
        #endif
    }
    
    func currencyWidgetString()->String?{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "en_US")
        guard let currency = formatter.string(for: self) else {return nil}
        
        #if TRIV
        return  currency.components(separatedBy: ".").first
        #else
        return currency
        #endif
    }
    
    func decimalString(_ maxFractionDigits: Int)->String? {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(for: self)
    }
    
    func coinDecimal()->String?{
        return decimalString(6)
    }
}

extension Int: Number {}
extension Float: Number {}
extension Double: Number {}
extension CGFloat: Number {}



