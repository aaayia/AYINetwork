//
//  WKNetwork.swift
//  WKNetwork
//
//  Created by ayia on 2018/4/15.
//  Copyright © 2018年 ayia. All rights reserved.
//

import UIKit
import Alamofire

private let WKNetworkResponseQueue: String          = "com.WKNetwork.ResponseQueue"

public class WKNetwork {
    
    public typealias CompletionClosure = (WKResponse) -> Void
    
    public let sessionManager: SessionManager
    
    public var target: WKTarget
    
    private lazy var responseQueue = { return DispatchQueue(label: WKNetworkResponseQueue) }()
    private lazy var reachabilityManager: NetworkReachabilityManager? = {
        let reachabilityManager = NetworkReachabilityManager(host: self.target.host)
        return reachabilityManager
    }()
    
    
    public init(_ target: WKTarget) {
        self.target = target
        
        let configuration = target.configuration
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        var policyManager: ServerTrustPolicyManager?
        if let policies = target.policies {
            policyManager = ServerTrustPolicyManager(policies: policies)
        }
        
        self.sessionManager = SessionManager(configuration: configuration, serverTrustPolicyManager:policyManager)
        
        
    }

}

extension WKNetwork {
    
    public var URLString: String {
        get {
            return target.URLPath ?? ""
        }
        set {
            target.URLPath = newValue
        }
    }
    
}


extension WKNetwork {
    
    public func request(_ request: WKRequest, completionClosure: @escaping CompletionClosure) {
        request.target = target
        
        debugPrint(request)
        
        let dataRequest = sessionManager.request(request.URLString,
                                                 method: request.method,
                                                 parameters: request.parameters,
                                                 encoding: request.parameterEncoding,
                                                 headers: request.headers)
        
        if let credential = request.credential {
            dataRequest.authenticate(usingCredential: credential)
        }
        
        dataRequest.responseData(queue: target.responseQueue) { [weak self] (originalResponse) in
            guard let strongSelf = self else { return }
            
            strongSelf.dealResponseOfDataRequest(request: request, originalResponse: originalResponse, completionClosure: completionClosure)
            
        }
        request.originalRequest = dataRequest
    }
    
}

extension WKNetwork {
    
    public func dealResponseOfDataRequest(request: WKRequest, originalResponse: DataResponse<Data>, completionClosure: @escaping CompletionClosure) {
        
        let response = WKResponse(request: request, urlRequest: originalResponse.request, httpURLResponse: originalResponse.response)
        
        switch originalResponse.result {
        case .failure(let error):
            response.error = error as NSError
            
        case .success(let data):
            response.data = data
        }
        
//        if let _ = response.data {
//            toJsonObject(response: response)
//
//            decode(request: request, response: response)
//        }
        
        debugPrint(response)
        
        DispatchQueue.main.async {
            completionClosure(response)
            
            request.originalRequest = nil
        }
        
    }

}
