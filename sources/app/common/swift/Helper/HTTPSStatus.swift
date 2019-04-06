//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Foundation

/**
 Enum for HTTP response codes.
 */
enum HTTPStatus: Int {
    
    //1xx Informationals
    case `continue` = 100
    case switchingProtocols = 101
    case internalError = 110
    
    //2xx Successfuls
    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    
    //3xx Redirections
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case unused = 306
    case temporaryRedirect = 307
    
    //4xx Client Errors
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestURITooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case unknownStatus = 419
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case reservedForWebDAV = 425
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequest = 429
    case requestHeaderFieldTooLarge = 431
    case noResponse = 444
    case retryWith = 449
    case unavailableForLegalReasons = 451
    case clientClosedRequest = 499
    
    //5xx Server Errors
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    
    func isSuccess()->Bool{
        switch self {
        case .ok:
            return true
        case .created:
            return true
        case .accepted:
            return true
        case .nonAuthoritativeInformation:
            return true
        case .noContent:
            return true
        case .resetContent:
            return true
        case .partialContent:
            return true
        default:
            return false
        }
    }
    
    
    
    static let getAll = [
        `continue`,
        switchingProtocols,
        ok,
        created,
        accepted,
        nonAuthoritativeInformation,
        noContent,
        resetContent,
        partialContent,
        multipleChoices,
        movedPermanently,
        found,
        seeOther,
        notModified,
        useProxy,
        unused,
        temporaryRedirect,
        badRequest,
        unauthorized,
        paymentRequired,
        forbidden,
        notFound,
        methodNotAllowed,
        notAcceptable,
        proxyAuthenticationRequired,
        requestTimeout,
        conflict,
        gone,
        lengthRequired,
        preconditionFailed,
        requestEntityTooLarge,
        requestURITooLong,
        unsupportedMediaType,
        requestedRangeNotSatisfiable,
        expectationFailed,
        internalServerError,
        notImplemented,
        badGateway,
        serviceUnavailable,
        gatewayTimeout,
        httpVersionNotSupported,
        unprocessableEntity
    ]
    
    var sortDescription: String {
        get{
            switch self {
            //1xx Informationals
            case .`continue`:
                return "Continue"
            case .switchingProtocols:
                return "Switching Protocols"
            case .internalError:
                return "Internal error"
                
            //2xx. Successfuls
            case .ok:
                return "OK"
            case .created:
                return "Created"
            case .accepted:
                return "Accepted"
            case .nonAuthoritativeInformation:
                return "Non Authoritative Information"
            case .noContent:
                return "No Content"
            case .resetContent:
                return "Reset Content"
            case .partialContent:
                return "Partial Content"
                
            //3xx. Redirections
            case .multipleChoices:
                return "Multiple Choices"
            case .movedPermanently:
                return "Move Permanently"
            case .found:
                return "Found"
            case .seeOther:
                return "See Other"
            case .notModified:
                return "Not Modified"
            case .useProxy:
                return "User Proxy"
            case .unused:
                return "Unused"
            case .temporaryRedirect:
                return "Temporary Redirect"
                
            //4xx. Client Errors
            case .badRequest:
                return "Bad Request"
            case .unauthorized:
                return "Unauthorized"
            case .paymentRequired:
                return "Payment Required"
            case .forbidden:
                return "Forbidden"
            case .notFound:
                return "Not Found"
            case .methodNotAllowed:
                return "Method Not Allowed"
            case .notAcceptable:
                return "Not Acceptable"
            case .proxyAuthenticationRequired:
                return "Proxy Authentication Required"
            case .requestTimeout:
                return "Request Time Out"
            case .conflict:
                return "Conflict"
            case .gone:
                return "Gone"
            case .lengthRequired:
                return "Length Required"
            case .preconditionFailed:
                return "Precondition Failed"
            case .requestEntityTooLarge:
                return "Request Entity Too Large"
            case .requestURITooLong:
                return "Request URI Too Long"
            case .unsupportedMediaType:
                return "Unsupported Media Type"
            case .requestedRangeNotSatisfiable:
                return "Request Range Not Satisfiable"
            case .expectationFailed:
                return "Expectation Failed"
            case .unknownStatus:
                return "Unknown Status"
            case .unprocessableEntity:
                return "Unprocessable Entity"
            case .locked:
                return "Locked"
            case .failedDependency:
                return "Failed Dependency (WebDAV)"
            case .reservedForWebDAV:
                return "Reserved for WebDAV"
            case .upgradeRequired:
                return "Upgrade Required"
            case .preconditionRequired:
                return "Precondition Required"
            case .tooManyRequest:
                return "Too Many Requests"
            case .requestHeaderFieldTooLarge:
                return "Request Header Fields Too Large"
            case .noResponse:
                return "No Response (Nginx)"
            case .retryWith:
                return "Retry With (Microsoft)"
            case .unavailableForLegalReasons:
                return "Unavailable For Legal Reasons"
            case .clientClosedRequest:
                return "Client Closed Request (Nginx)"
                
            //5xx. Server Errors
            case .internalServerError:
                return "Internal Server Error"
            case .notImplemented:
                return "Not Implemented"
            case .badGateway:
                return "Bad Gateway"
            case .serviceUnavailable:
                return "Service Unavailable"
            case .gatewayTimeout:
                return "gateway Timeout"
            case .httpVersionNotSupported:
                return "HTTP Version Not Supported"
                
            }
        }
    }

}

