//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

struct SCREEN {
    static let width                : CGFloat = UIScreen.main.bounds.width
    static let height               : CGFloat = UIScreen.main.bounds.height
    static let maxLength            : CGFloat = max(SCREEN.width, SCREEN.height)
    static let minLength            : CGFloat = min(SCREEN.width, SCREEN.height)
    static let ResolutionWidth      : CGFloat = UIScreen.main.nativeBounds.width
    static let ResolutionHeight     : CGFloat = UIScreen.main.nativeBounds.height
    static let maxResolutionLength  : CGFloat = max(SCREEN.ResolutionWidth, SCREEN.ResolutionHeight)
    static let minResolutionLength  : CGFloat = min(SCREEN.ResolutionWidth, SCREEN.ResolutionHeight)
}

struct DEVICE {
    static let model                : String = UIDevice.modelName
    static let isIpad               : Bool = UI_USER_INTERFACE_IDIOM() == .pad
    static let isIphone             : Bool = UI_USER_INTERFACE_IDIOM() == .phone
    static let isRetina             : Bool = UIScreen.main.scale >= 2.0
    static let isIphone4OrLess      : Bool = DEVICE.isIphone && SCREEN.maxLength < 568.0
    static let isIphone5            : Bool = DEVICE.isIphone && SCREEN.maxLength == 568.0
    static let isIphone6            : Bool = DEVICE.isIphone && SCREEN.maxLength == 667.0
    static let isIphone6Plus        : Bool = DEVICE.isIphone && SCREEN.maxLength == 736.0
    //iPhone X🅂 Max Screen bounds: (0.0, 0.0, 414.0, 896.0), Screen resolution: (0.0, 0.0, 1242.0, 2688.0), scale: 3.0
    static let isIphoneXSMax        : Bool = DEVICE.isIphone && SCREEN.maxLength == 896.0 && SCREEN.maxResolutionLength == 2688.0
    //iPhone X🅁 Screen bounds: (0.0, 0.0, 414.0, 896.0), Screen resolution: (0.0, 0.0, 828.0, 1792.0), scale: 2.0
    static let isIphoneXR           : Bool = DEVICE.isIphone && SCREEN.maxLength == 896.0 && SCREEN.maxResolutionLength == 1792.0
    //iPhone X🅂 and X Screen bounds: (0.0, 0.0, 375.0, 812.0), Screen resolution: (0.0, 0.0, 1125.0, 2436.0), scale: 3.0
    static let isIphoneX            : Bool = DEVICE.isIphone && SCREEN.maxLength == 812.0
    static let isIphoneXS           : Bool = DEVICE.isIphone && SCREEN.maxLength == 812.0
    static let isLanscape           : Bool = UIDevice.current.orientation.isLandscape
}


struct FONTS {
    static func regular(_ size: CGFloat)-> UIFont?{
        return UIFont(name: "Roboto-Regular", size: size)
    }
    static let regularSmall                     = UIFont(name: "Roboto-Regular", size: 11.5)
    static let regularRegular                   = UIFont(name: "Roboto-Regular", size: 13)
    static let regularLarge                     = UIFont(name: "Roboto-Regular", size: 15)
    
    static func bold(_ size: CGFloat)-> UIFont?{
        return UIFont(name: "Roboto-Bold", size: size)
    }
    static let boldSmall                        = UIFont(name: "Roboto-Bold", size: 11.5)
    static let boldRegular                      = UIFont(name: "Roboto-Bold", size: 13)
    static let boldLarge                        = UIFont(name: "Roboto-Bold", size: 15)
    
    static func light(_ size: CGFloat)-> UIFont? {
        return UIFont(name: "Roboto-Light", size: size)
    }
    static let lightSmall                       = UIFont(name: "Roboto-Light", size: 11.5)
    static let lightRegular                     = UIFont(name: "Roboto-Light", size: 13)
    static let lightLarge                       = UIFont(name: "Roboto-Light", size: 15)
    
    static func italic(_ size: CGFloat)-> UIFont? {
        return UIFont(name: "Roboto-Italic", size: size)
    }
    static let italicSmall                      = UIFont(name: "Roboto-Italic", size: 11.5)
    static let italicRegular                    = UIFont(name: "Roboto-Italic", size: 13)
    static let italicLarge                      = UIFont(name: "Roboto-Italic", size: 15)
    
    static func medium(_ size: CGFloat)-> UIFont? {
        return UIFont(name: "Roboto-Medium", size: size)
    }
    static let mediumSmall                      = UIFont(name: "Roboto-Medium", size: 11.5)
    static let mediumRegular                    = UIFont(name: "Roboto-Medium", size: 13)
    static let mediumLarge                      = UIFont(name: "Roboto-Medium", size: 15)
}

struct API {
    enum APIPath {
        case path
        
        var string: String {
            switch self {
            case .path: return "/path"
            }
        }
    }
    
    static let requestTimeOut                   = 60.0
    static let baseUrl                          = "https://"
    static func url(_ endpoint: String = API.baseUrl,path: APIPath)->String{
        return  endpoint + path.string
    }
}

struct DATE {
    static let defaultAPIDateFormat             = "yyyy-MM-dd HH-mm-ss'.000000'"
    static let defaultDateFormat                = "yyyy-MM-dd HH:mm:ss"
}

struct kUserDefaults {
}

enum DebugingMode: Int {
    case error = 0
    case warning = 1
    case debug = 2
    case info = 3
}
