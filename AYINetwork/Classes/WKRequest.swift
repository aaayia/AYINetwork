//
//  WKRequest.swift
//  WKNetwork
//
//  Created by ayia on 2018/4/15.
//  Copyright © 2018年 ayia. All rights reserved.
//

import UIKit


public protocol WKReflection {
    
    func toJSONObject() -> Any?
    
}

extension WKReflection{
    public func toJSONObject() -> Any? {
        let mirror = Mirror(reflecting: self)
        if mirror.children.count > 0, let _ = mirror.displayStyle {
            var dict: [String: Any] = [:]
            for (optionalKey, value) in mirror.children {
                if let propertyNameString = optionalKey, let reflectionValue = value as? WKReflection {
                    dict[propertyNameString] = reflectionValue.toJSONObject()
                }
            }
            return dict.count > 0 ? dict : nil
        }
        return self
    }

}

extension Optional: WKReflection {
    public func toJSONObject() -> Any? {
        if let x = self {
            if let value = x as? WKReflection {
                return value.toJSONObject()
            }
        }
        return nil
    }
}

extension Array: WKReflection {
    public func toJSONObject() -> Any? {
        let mirror = Mirror(reflecting: self)
        if mirror.children.count > 0 {
            var array: [Any] = []
            for (_, value) in mirror.children {
                if let reflectionValue = value as? WKReflection, let obj = reflectionValue.toJSONObject() {
                    array.append(obj)
                }
            }
            return array.count > 0 ? array : nil
        }
        return self
    }
}


extension Dictionary: WKReflection {
    public func toJSONObject() -> Any? {
        if self.count > 0 {
            var dict: [String: Any] = [:]
            for (key, obj) in self {
                if let keyString = key as? String, let reflectionValue = obj as? WKReflection {
                    dict[keyString] = reflectionValue.toJSONObject()
                }
            }
            return dict.count > 0 ? dict : nil
        }
        return self
    }
}


extension Bool: WKReflection {}

extension Int: WKReflection {}
extension Int8: WKReflection {}
extension Int16: WKReflection {}
extension Int32: WKReflection {}
extension Int64: WKReflection {}
extension Float: WKReflection {}
extension Double: WKReflection {}
extension Decimal: WKReflection {}
extension String: WKReflection {}



open class WKRequest{
    
    
    public init(method: HTTPMethod = .get,
                URLString: String? = nil,
                path: String = "",
                parameters: Parameters? = nil,
                parameterEncoding: ParameterEncoding = URLEncoding.default,
                headers: [String: String]? = nil) {
        self.storeMethod = method
        self.storeURLString = URLString
        self.path = path
        self.storeParameters = parameters
        self.headers = headers
        loadRequest()
        
    }
    
    
    open func loadRequest() {}

    internal var originalRequest: Request?
    
    public var requestID: String {
        return URLString.data(using: .utf8)?.base64EncodedString() ?? ""
    }
    
    public var method: HTTPMethod {
        get {
            return storeMethod ?? .get
        }
        set {
            storeMethod = newValue
        }
    }
    
    public var path: String = ""
    
    public var URLString: String {
        get {
            return storeURLString ?? ""
        }
        set {
            storeURLString = newValue
        }
    }
    
    public var parameters: Parameters? {
        get {
            if let parameters = storeParameters {
                return parameters
            }
            else if let parameters = toJSONObject() as? Parameters {
                storeParameters = parameters
                return parameters
            }
            return nil
        }
        set {
            storeParameters = newValue
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        get {
            return storeParameterEncoding ?? URLEncoding.default
        }
        set {
            storeParameterEncoding = newValue
        }
    }
    
    public  var target: WKTarget? {
        get {
            return storeTarget
        }
        set {
            if storeMethod == nil {
                storeMethod = newValue?.method
            }
            if storeURLString == nil {
                if let URLString = newValue?.URLPath {
                    storeURLString = URLString + path
                    if let host = newValue?.host {
                        if headers == nil {
                            headers = [WKHostKey : host]
                        }
                        else {
                            headers![WKHostKey] = host
                        }
                    }
                }
                else if let baseURLString = newValue?.baseURLString {
                    storeURLString = baseURLString + path
                }
            }
            if storeParameterEncoding == nil {
                storeParameterEncoding = newValue?.parameterEncoding
            }
            if let targetHeaders = newValue?.headers, targetHeaders.count > 0 {
                if headers == nil {
                    headers = targetHeaders
                }
                else {
                    for (key, obj) in targetHeaders {
                        if !(headers?.keys.contains(key))! {
                            headers![key] = obj
                        }
                    }
                }
            }
            if dataKeyPath == nil {
                dataKeyPath = newValue?.status?.dataKeyPath
            }
            storeTarget = newValue
        }
    }
    
    public var headers: [String: String]?
    
    public var credential: URLCredential?
    
    public var dataKeyPath: String?
    
    //MARK: - Private
    private var storeMethod: HTTPMethod?
    
    private var storeURLString: String?
    
    private var storeParameters: Parameters?
    
    private var storeParameterEncoding: ParameterEncoding?
    
    private  var storeTarget: WKTarget?
}

extension WKRequest:WKReflection{
    
}

extension WKRequest: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return """
        ------------------------ WKRequest -----------------------
        URL:\(URLString)
        headers:\(String(describing: headers))
        parameters:\(String(describing: parameters))
        ------------------------ WKRequest -----------------------
        
        """
    }
    
}





