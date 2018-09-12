//
//  WKTarget.swift
//  WKNetwork
//
//  Created by ayia on 2018/4/15.
//  Copyright © 2018年 ayia. All rights reserved.
//

import UIKit





public protocol WKTarget {
        
    //请求域名
    var baseURLString: String { get }
    //请求路径
    var URLPath: String? { get set }
    //请求方法
    var method: HTTPMethod { get }
    
    /// 请求头信息
    var headers: [String: String]? { get set }
    
    /// 参数编码方法
    var parameterEncoding: ParameterEncoding { get }
    
    ///
    var configuration: URLSessionConfiguration { get }
    
    var policies: [String : ServerTrustPolicy]? { get }

    /// 相应队列
    var responseQueue: DispatchQueue? { get }
    
    var host: String { get }
    
//    var status: (codeKey: String, successCode: Int, messageKey: String?, dataKeyPath: String?)? { get }
    
    var decoder: JSONDecoder { get }

}


public extension WKTarget {
    var URLPath: String? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    var method: HTTPMethod { return .get }
    
    var headers: [String: String]? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    var parameterEncoding: ParameterEncoding { return URLEncoding.default }
    
    var configuration: URLSessionConfiguration { return URLSessionConfiguration.default }
    
    var policies: [String : ServerTrustPolicy]? { return nil }

    
    var responseQueue: DispatchQueue? { return nil }
    
    var host: String {
        if let URL = URL(string: baseURLString), let host = URL.host {
            return host
        }
        return ""
    }
    
    var status: (codeKey: String, successCode: Int, messageKey: String?, dataKeyPath: String?)? { return nil }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
}

