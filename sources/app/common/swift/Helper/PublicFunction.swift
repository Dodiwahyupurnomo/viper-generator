//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit


func printLog(_ message: String,mode: DebugingMode = .error, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    var modeMmsg = ""
    switch mode {
    case .error:
        modeMmsg = "❌ =>"
        break
    case .warning:
        modeMmsg = "⚠️ =>"
        break
    case .info:
        modeMmsg = "💡 =>"
        break
    default:
        modeMmsg = "👉 =>"
        break
    }
    
    let className = file.components(separatedBy: "/").last
    print("""
    \(modeMmsg) File: \(className ?? "")
        Function: \(function)
        Line: \(line)
        Message: \(message)
    """)
    //print("\(modeMmsg) File: \(className ?? ""), Function: \(function), Line: \(line), Message: \(message)")
    #endif
}

