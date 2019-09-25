//
//  RequestConst.swift
//  novelCartoon
//
//  Created by TonyReet on 2019/9/5.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import Foundation
import Alamofire

/// 网络请求成功闭包
public typealias SuccessClosure = (_ response : Any)->()

/// 网络请求失败闭包
public typealias FailtureClosure = (_ error : Error?)->()

/// 显示message闭包
public typealias ShowMessageClosure = (_ message:String?)->()

/// 显示loading闭包
public typealias ShowLoadingInViewClosure = (_ view:UIView?)->()

/// 关闭message
public typealias DismissMessageClosure = (_ view:UIView?)->()

/// 关闭loading
public typealias DismissLoadingInViewClosure = ()->()

/// 配置header
public typealias ConfigHeaderColosure = (_ headers:HTTPHeaders?) -> HTTPHeaders

//// 解析特定服务器数据，比如有的服务器是[res,data],[code,msg]
public typealias AnalyzeDataColosure = (_ jsonDic:Dictionary<String, Any>?) -> (error:RequestError?,jsonData:Dictionary<String, Any>?)

