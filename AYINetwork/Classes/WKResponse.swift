//
//  WKResponse.swift
//  WKNetwork
//
//  Created by ayia on 2018/4/15.
//  Copyright © 2018年 ayia. All rights reserved.
//

import UIKit


public class WKResponse {
    
    public weak var request: WKRequest?
    
    public let urlRequest: URLRequest?
    
    public let httpURLResponse: HTTPURLResponse?
    
    public var data: Any?
    
    public var error: NSError?
    
    public var message: String?
    
    public var destinationURL: URL?
    
    init(request: WKRequest, urlRequest: URLRequest?, httpURLResponse: HTTPURLResponse?) {
        self.request = request
        self.urlRequest = urlRequest
        self.httpURLResponse = httpURLResponse
    }
    
    public var dataDictionary: [String: Any]? {
        if let dataDictionary = data as? [String: Any] {
            return dataDictionary
        }
        return nil
    }
    
    public var dataArray: [[String: Any]]? {
        if let dataArray = data as? [[String: Any]] {
            return dataArray
        }
        return nil
    }
    
    public func decode<T: Decodable>(to Model: T.Type) -> T? {
        var decodeData: Data = Data()
        do {
            if let data = self.data as? Data {
                decodeData = data;
            }
            else {
                if let data = self.data {
                    decodeData = try JSONSerialization.data(withJSONObject: data)
                }
            }
            if let target = self.request?.target {
                let data: T = try target.decoder.decode(Model.self, from: decodeData)
                return data
            }
        } catch {
            self.error = error as NSError
            debugPrint(error)
        }
        return nil
    }

    
}

extension WKResponse: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        let dataString = destinationURL == nil ? "data:\(data ?? "")" : "destinationURL:\(destinationURL?.absoluteString ?? "")"
        
        return """
        ------------------------ WKResponse ----------------------
        URL:\(request?.URLString ?? "")
        \(dataString)
        error:\(String(describing: error))
        ------------------------ WKResponse ----------------------
        
        """
    }
    
}
