//
//  RestClient.swift
//  PushNotifyManagement
//
//  Created by Orhan Özgün Ergen on 3.01.2023.
//  Edited by Umut Boz 19.09.2023.

import Foundation


class Weak<Object: AnyObject> {
    private(set) weak var object: Object?
    
    init(object: Object) {
        self.object = object
    }
}
private let tag = "RestClient"
private func printTagged(_ string: String) {
    print("[" + tag + "] " + string)
}

public protocol RestClientIntercepter {
    
    
    func error(code: Int, response: Data?, identifier: String?)
    func success(response: Data?)
    
}

public class RestClient {
    public enum Error: Swift.Error {
        public enum Data: Swift.Error {
            case missing
            case read(underlying: DecodingError)
            case write(underlying: EncodingError)
        }
        
        case corruptedURL
        case existingIdentifier
        case connection(reason: Swift.Error)
        case http(code: Int)
        case data(reason: Data)
        case server(code: Bool, description: String)
        case other
    }
    
    public static let `default`: RestClient = RestClient()
    
    private static var baseUrl = ""
    
    private let urlSession: URLSession
    private var taskPool: [String : Weak<URLSessionTask>] = [:]
    private static var header: [String: String]?
    public var intercepter: RestClientIntercepter?
    
    private init() {
        self.urlSession = URLSession(
            configuration: .default,
            delegate: nil,
            delegateQueue: .main
        )
    }
    
    init(session: URLSession) {
        self.urlSession = session
    }
 
 
    @discardableResult
    private func makeRequest<Q: Request, S: Decodable>(
        identifier: String?,
        request: Q,
        body: Data?,
        completionHandler: @escaping (S?, Error?) -> Void
    ) -> URLSessionTask? {
        
        var baseUrl = ""
        if let request = request as? GenericRequest,
           let _baseUrl = request.baseUrl {
            baseUrl = _baseUrl
        } else {
            baseUrl = RestClient.baseUrl
        }
        
        let mainUrl = baseUrl + request.endpoint
        var urlComponents = URLComponents(string: mainUrl)
        if !request.onlyFullPathUrlWithQueries {
            urlComponents?.queryItems = request.queryParameters
        }
        
        guard let url = urlComponents?.url else {
            completionHandler(nil,.corruptedURL)
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = body
        urlRequest.timeoutInterval = 30.0
        urlRequest.allHTTPHeaderFields = RestClient.header
        urlRequest.setValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        if !request.headerParameters.isEmpty {
            for parameters in request.headerParameters {
                urlRequest.setValue(parameters.value, forHTTPHeaderField: parameters.name)
            }
        }

#if DEBUG
        debugRequestAndHeader(
            request: request,
            urlRequest: urlRequest,
            identifier: identifier,
            body: body
        )
#endif
        
        let task = urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            let _ = identifier.map { self?.taskPool.removeValue(forKey: $0) }
            
#if DEBUG
            printTagged("✅ <----------Response----------> ✅")
            identifier.map { printTagged("Identifier: " + $0) }
            printTagged("Method: " + request.method.rawValue)
            printTagged("URL: " + url.absoluteString)
            
            defer {
                printTagged("-------------------------------------------------------")
            }
#endif
            
            if let error = error {
#if DEBUG
                printTagged("🚫Connection Error: " + error.localizedDescription)
               
#endif
                
                completionHandler(nil, .connection(reason: error))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
#if DEBUG
                printTagged("🚫     !!!NO RESPONSE!!!     ")
#endif
                
                completionHandler(nil, .other)
                
                return
            }
            
            if response.statusCode < 200 || response.statusCode >= 400 {
#if DEBUG
                printTagged("🚫HTTP Error: " + String(describing: response.statusCode))
                printTagged("Response " + String(data: data!, encoding: .utf8)!)
#endif
                
                completionHandler(nil, .http(code: response.statusCode))
            } else {
                guard let data = data else {
#if DEBUG
                    printTagged("🚫       !!!NO DATA!!!       ")
#endif
                    
                    completionHandler(nil, .data(reason: .missing))
                    
                    return
                }
                
#if DEBUG
                printTagged("-------------------------------------------------------")
                printTagged("Response: " + (String(data: data, encoding: .utf8) ?? "CORRUPTED"))
#endif
                do {
                    let response = try Coders.decoder.decode(S.self, from: data)
                    completionHandler(response, nil)
                } catch let error as DecodingError {
                    completionHandler(nil, .data(reason: .read(underlying: error)))
                } catch {
                    completionHandler(nil, .other)
                }
            }
        }
        
        if let identifier = identifier, !identifier.isEmpty {
            if taskPool.keys.contains(identifier) {
                completionHandler(nil, .existingIdentifier)
                return nil
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    public func makeRequest<Q: Request & Encodable, S: Decodable>(
        request: Q,
        apiKey:String,
        completionHandler: @escaping (S?, Error?) -> Void
    ) -> URLSessionTask? {
        do {
            if request.method == .get {
                return makeRequest(
                    identifier: request.endpoint,
                    request: request,
                    body: nil,
                    completionHandler: completionHandler
                )
            } else {
                let body = try Coders.encoder.encode(request)
                return makeRequest(
                    identifier: request.endpoint,
                    request: request,
                    body: body,
                    completionHandler: completionHandler
                )
            }
        } catch let error as EncodingError {
            completionHandler(nil, .data(reason: .write(underlying: error)))
            return nil
        } catch {
            completionHandler(nil, .other)
            return nil
        }
    }
    
    
    func cancelRequest(identifier: String) {
        taskPool[identifier]?.object?.cancel()
        
    }
}

extension RestClient {
    
    public class func setBaseUrl(url: String) {
        RestClient.baseUrl = url
    }
    
    public class func getBaseUrl() -> String {
        RestClient.baseUrl
    }
    
    public class func setHeaderValue(header: [String: String]) {
        RestClient.header = header
    }
    
    public class func appendHeaderValue(key: String, value: String) {
        if RestClient.header == nil {
            RestClient.header = [String: String]()
        }

        RestClient.header?[key] = value
    }
    
    public class func removeRequestHeaderForKey(key: String) {
        RestClient.header?.removeValue(forKey: key)
    }
}

// MARK: - Debug Network Client
private extension RestClient {
    
    func debugRequestAndHeader<Q: Request>(
        request: Q,
        urlRequest: URLRequest,
        identifier: String?,
        body: Data?
    ) {
        printTagged("✅ ----------Request---------- ✅")
        identifier.map { printTagged("Identifier: " + $0) }
        printTagged("Method: " + request.method.rawValue + " 🚀")
        printTagged("URL: " + (urlRequest.url?.absoluteString ?? "-"))
        body.map { String(data: $0, encoding: .utf8).map { printTagged("Body: " + $0) } }
        
        var allHTTPHeaderFields = urlRequest.allHTTPHeaderFields
        
        if !request.headerParameters.isEmpty {
            for parameters in request.headerParameters {
                allHTTPHeaderFields?[parameters.name] = parameters.value
            }
        }
        let header = allHTTPHeaderFields?.reduce("", { (result, parameter) -> String in
            return result + parameter.key + "=" + parameter.value + ", "
        }) ?? ""
        
        printTagged("Header: " + header)
        body.map { String(data: $0, encoding: .utf8).map { printTagged("Body: " + $0) } }
        printTagged("-------------------------------------------------------")
    }
}
