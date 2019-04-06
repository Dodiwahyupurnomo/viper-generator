//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit
import MobileCoreServices

enum HTTPRequestMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
    
    var value: T? {
        if case .success(let value) = self { return value }
        return nil
    }
    
    var error: Error? {
        if case .failure(let error) = self { return error }
        return nil
    }
}

enum APIError: Error {
    case requestFailed(HTTPStatus?,String?)
    case jsonConversionFailure(HTTPStatus?,String?)
    case invalidData(HTTPStatus?,String?)
    case responseUnsuccessful(HTTPStatus?,String?)
    case jsonParsingFailure(HTTPStatus?,String?)
    case baseError(String?)
    var localizedDescription: String {
        switch self {
        case .requestFailed(_,let message): return "\(message != nil ? "\n" + message! : "Request Failed")"
        case .invalidData(_,let message): return "Invalid Data\(message != nil ? "\n" + message! : "")"
        case .responseUnsuccessful(_,let message): return "\(message != nil ? "\n" + message! : "")"
        case .jsonParsingFailure(_,let message): return "JSON Parsing Failure\(message != nil ? "\n" + message! : "")"
        case .jsonConversionFailure(_,let message): return "JSON Conversion Failure\(message != nil ? "\n" + message! : "")"
        case .baseError(let message): return message ?? "Unknown error"
        }
        
    }
    
    var responseCode: HTTPStatus? {
        switch self {
        case .requestFailed(let code,_): return code
        case .invalidData(let code,_): return code
        case .responseUnsuccessful(let code,_): return code
        case .jsonParsingFailure(let code,_): return code
        case .jsonConversionFailure(let code,_): return code
        case .baseError(_): return nil
        }
    }
    
}


final class APIClient:NSObject {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    static let shared = APIClient()
    
    var session: URLSession!
    
    private var tasks = [URL: [JSONTaskCompletionHandler]]()
    
    init(configuration: URLSessionConfiguration) {
        super.init()
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    override convenience init() {
        self.init(configuration: .default)
    }
    
    func httpRequest<T:Decodable>(url: String, method: HTTPRequestMethod = .get,parameters:[String:Any]?,headers: [String:String]?,decode: @escaping (Decodable) -> T?,_ completion: @escaping (Result<T,APIError>)->Void){
        var strUrl = url
        
        var allheaders: [String:String] = [
            "Accept": "application/json",
            "Cache-Control": "no-cache",
            "User-Agent":"tpro-app"]

        headers?.forEach({ (arg) in
            let (key, value) = arg
            allheaders[key] = value
        })
        
        if method == .get {
            if let param = parameters {
                strUrl += "?" + param.queryString()
            }
        }

        guard let encodedString = strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            print("Failed to encoding string")
            return
        }

        guard let url = URL(string: encodedString) else {
            print("Failed to generate url")
            return
        }

        let urlrequest = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval:API.requestTimeOut)
        urlrequest.allHTTPHeaderFields = allheaders
        urlrequest.httpMethod = method.rawValue
        
        if method != .get, let params = parameters {
            do{
                try urlrequest.setMultipartFormData(params, encoding: .utf8)
            }catch{
                printLog(error.localizedDescription, mode: .error)
            }
        }
        fetch(with: urlrequest as URLRequest, decode: decode, completion: completion)
    }
    
    private func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData(nil,nil)))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure(nil,nil)))
                }
            }
        }
        task?.resume()
    }
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask? {
        
        if tasks.keys.contains(request.url!) {
            tasks[request.url!]?.append(completion)
            return nil
        }else {
            tasks[request.url!] = [completion]
            let task = session.dataTask(with: request) { [weak self] (data, response, error) in
                
                #if DEBUG
                let httpRes = response as? HTTPURLResponse
                print("""
                    
                    ///////////////////////////
                    Finished network task
                    code : \(httpRes?.statusCode ?? 0)
                    URL  : \(String(describing: httpRes?.url))
                    ///////////////////////////
                    
                    """)
                #endif
 
                guard let completions = self?.tasks[request.url!] else {return}
                
                for handler in completions{
                    guard let httpResponse = response as? HTTPURLResponse,let status = HTTPStatus(rawValue: httpResponse.statusCode) else {
                        handler(nil, .requestFailed(nil,error?.localizedDescription))
                        self?.tasks[request.url!] = nil
                        return
                    }
                   
                    if status.isSuccess() {
                        if let data = data {
                            do {
        
                                #if DEBUG
                                let obj = try JSONSerialization.jsonObject(with: data, options: [])
                                printLog("\(String(describing: request.url?.path)) => \(obj)", mode: .debug)
                                #endif

                                let genericModel = try JSONDecoder().decode(decodingType, from: data)
                                handler(genericModel, nil)
                            } catch let exc{
                                handler(nil, .jsonConversionFailure(status,exc.localizedDescription))
                            }
                        } else {
                            handler(nil, .invalidData(status,nil))
                        }
                    }else {
                        var message: String?
                        
                        if let d = data {
                            do{
                                let genericModel = try JSONDecoder().decode(ErrorResponse.self, from: d)
                                message = genericModel.error?.message
                            }catch{
                                message = nil
                            }
                        }
                        let statusCode = HTTPStatus(rawValue: httpResponse.statusCode)
                        
                        handler(nil,.responseUnsuccessful(status,"\(statusCode?.sortDescription ?? "Failed")\(message != nil ? "\n\(message!)" : "")"))
                    }
                }
                self?.tasks[request.url!] = nil
            }
            return task
        }
    }
}

extension APIClient: URLSessionDelegate,URLSessionTaskDelegate, URLSessionDataDelegate{
    //MARK: - URLSessionDelegate
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        printLog("Session invalidate \(error?.localizedDescription ?? "null")", mode: .error)
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
    }
    
    //MARK: - URLSessionTaskDelegate
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        printLog("Task end with send bytes \(task.countOfBytesSent) and received bytes \(task.countOfBytesReceived)", mode: .debug)
    }
}

extension NSMutableURLRequest {
    
    /**
     Configures the URL request for `multipart/form-data`. The request's `httpBody` is set, and a value is set for the HTTP header field `Content-Type`.
     
     - Parameter parameters: The form data to set.
     - Parameter encoding: The encoding to use for the keys and values.
     
     - Throws: `EncodingError` if any keys or values in `parameters` are not entirely in `encoding`.
     
     - Note: The default `httpMethod` is `GET`, and `GET` requests do not typically have a response body. Remember to set the `httpMethod` to e.g. `POST` before sending the request.
     */
    func setMultipartFormData(_ parameters: [String: Any], encoding: String.Encoding) throws {
        let boundary = String(format: "------------------------%08X%08X", arc4random(), arc4random())
        
        let contentType: String = try {
            guard let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(encoding.rawValue)) else {
                throw APIError.baseError("Internal error with error code 1001, please contact admin")
            }
            return "multipart/form-data; charset=\(charset); boundary=\(boundary)"
            }()
        addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        httpBody = try {
            var body = Data()
            
            for (rawName, rawValue) in parameters {
                if !body.isEmpty {
                    body.append("\r\n".data(using: .utf8)!)
                }
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                
                guard
                    rawName.canBeConverted(to: encoding),
                    let disposition = "Content-Disposition: form-data; name=\"\(rawName)\"\r\n".data(using: .utf8) else {
                        throw APIError.baseError("Internal error with code 1001, please contact admin")
                }
                body.append(disposition)
                
                body.append("\r\n".data(using: .utf8)!)
                
                guard let value = "\(rawValue)".data(using: encoding) else {
                    throw APIError.baseError("Internal error with code 1001, please contact admin")
                }
                
                body.append(value)
            }
            
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            return body
            }()
    }
}
