//
//  WKNetwork+Alamofire.swift
//  WKNetwork
//
//  Created by ayia on 2018/4/15.
//  Copyright © 2018年 ayia. All rights reserved.
//

import Foundation
import AYINetwork
import Alamofire


public typealias SessionManager = Alamofire.SessionManager
internal typealias Request = Alamofire.Request
internal typealias DownloadRequest = Alamofire.DownloadRequest
internal typealias UploadRequest = Alamofire.UploadRequest
internal typealias DataRequest = Alamofire.DataRequest
public typealias DataResponse = Alamofire.DataResponse
internal typealias SessionDelegate = Alamofire.SessionDelegate

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias Parameters = Alamofire.Parameters

public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias JSONEncoding = Alamofire.JSONEncoding
public typealias URLEncoding = Alamofire.URLEncoding
public typealias PropertyListEncoding = Alamofire.PropertyListEncoding

public typealias DownloadOptions = Alamofire.DownloadRequest.DownloadOptions
public typealias MultipartFormData = Alamofire.MultipartFormData

public typealias ServerTrustPolicyManager = Alamofire.ServerTrustPolicyManager
public typealias ServerTrustPolicy = Alamofire.ServerTrustPolicy

internal typealias NetworkReachabilityManager = Alamofire.NetworkReachabilityManager
public typealias Listener = Alamofire.NetworkReachabilityManager.Listener

public let WKHostKey = "Host"


