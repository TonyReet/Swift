//
//  Request.swift
//  novelCartoon
//
//  Created by TonyReet on 2019/9/25.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public class Request: NSObject {
    static let shared = Request()
    
    let requestTimeOut:TimeInterval = 20
    
    var manager = SessionManager()
    
    public var showMessageClosure: ShowMessageClosure?
    
    public var showLoadingInViewClosure: ShowLoadingInViewClosure?
    
    public var dismissMessageClosure: DismissMessageClosure?
    
    public var dismissLoadingInViewClosure: DismissLoadingInViewClosure?
    
    public var configHeaderColosure: ConfigHeaderColosure?
    
    public var analyzeDataColosure: AnalyzeDataColosure?
    
    override init() {
        let configuration = URLSessionConfiguration.default

        //timeoutIntervalForResource：整个任务(上传或下载)完成的最长时间，默认值为1周；
        //timeoutIntervalForRequest：两个数据包之间的最大时间间隔；
        configuration.timeoutIntervalForRequest = requestTimeOut
        configuration.timeoutIntervalForResource = requestTimeOut
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders

        manager = Alamofire.SessionManager(configuration: configuration)
    }

    static func post<T: Codable>(url: RequestRouter, paramters: Parameters? = nil, headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete: SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type,observer: AnyObserver<T>? = nil){

        let httpRequest = Request.shared

        httpRequest.request(type: .post, url: url, paramters: paramters, headers: headers, isNeedLoading: isNeedLoading, inView: inView, complete: complete,fail:fail,returnType: returnType,observer: observer)
    }


    //MARK:GET
    static func get<T: Codable>(url: RequestRouter, paramters: Parameters? = nil, headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete: SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type,observer: AnyObserver<T>? = nil){

        let httpRequest = Request.shared

        httpRequest.request(type: .get, url: url, paramters: paramters, headers: headers, isNeedLoading: isNeedLoading, inView: inView, complete: complete,fail:fail,returnType: returnType,observer: observer)
    }

    //MARK:上传图片
    static func upLoadImages<T: Codable>(url: RequestRouter, paramters: Parameters? = nil, images: [UIImage],headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete:SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type,observer: AnyObserver<T>? = nil){

        let httpRequest = Request.shared

        httpRequest.upLoadImageRequest(url: url, paramters: paramters, images: images, headers: headers, isNeedLoading: isNeedLoading, inView: inView, complete: complete,fail:fail,returnType: returnType,observer: observer)
    }
}

//MARK:- 基础封装
extension Request {
    fileprivate func request<T: Codable>(type: HTTPMethod, url: RequestRouter, paramters: Parameters? = nil, headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete:SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type,observer: AnyObserver<T>? = nil) {

        let (isReachAblity,headers) = checkNetworkConfigHeaders(headers: headers, isNeedLoading: isNeedLoading, inView: inView, complete: complete,fail:fail,paramters:paramters,url:url,observer: observer)

        if isReachAblity == false {
            return
        }

        // 配置类型
        var encoding : ParameterEncoding?
        if type == .get {
            encoding = URLEncoding.default
        }else {
            encoding = JSONEncoding.default
        }

        // 发送网络请求Alamofire.
        Request.shared.manager.request(url, method: type, parameters: paramters,encoding:encoding!,headers: headers).responseJSON { (response:DataResponse) in

            switch response.result{
            case .success:
                self.successHandle(result:response, inView:inView, complete: complete,fail: fail,returnType: returnType,observer: observer)
            case .failure(let error):

                self.failtureHandle(inView:inView, error:RequestError.apiError(with: error as NSError), fail: fail,observer: observer)
            }
        }
    }

    //上传多张图片
    fileprivate func upLoadImageRequest<T: Codable>(url: RequestRouter, paramters:Parameters? = nil, images: [UIImage],headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete:SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type,observer: AnyObserver<T>? = nil){

        let (isReachAblity,headers) = checkNetworkConfigHeaders(headers: headers, isNeedLoading: isNeedLoading, inView: inView, complete: complete,fail:fail,paramters:paramters,url:url,observer: observer)

        if isReachAblity == false {
            return
        }

        
        Alamofire.upload(multipartFormData: { multipartFormData in
            //添加参数
            if let paramters = paramters {
                for (key, value) in paramters {
                    multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                }
            }

            //添加图片
            for index in 0..<images.count {
                let fileName = "name" + String(index)

                let imageData = images[index].jpegData(compressionQuality: 1.0)

                if let data = imageData {
                    multipartFormData.append(data, withName: "image", fileName: fileName, mimeType: "image/jpeg")
                }
            }
        },to: url,headers: headers,encodingCompletion: {result in

            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    self.successHandle(result: response, inView:inView,complete: complete,fail: fail,returnType: returnType,observer: observer)
                }
            case .failure(let error):
                self.failtureHandle(inView:inView,error: RequestError.apiError(with: error as NSError), fail: fail,observer: observer)
            }
        })
    }
}

//MARK:- 网络检查和配置headers
extension Request {
    
    fileprivate func checkNetworkConfigHeaders<T: Codable>(headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete:SuccessClosure? = nil,fail:FailtureClosure? = nil,paramters:Parameters? = nil,url: RequestRouter,observer: AnyObserver<T>? = nil) -> (isReachAblity : Bool,headers:HTTPHeaders?){
        
        // 检查网络
        let isReachability = checkNetwork(fail: fail,observer: observer)
        if isReachability == false {
            return (false, headers)
        }
        
        //弹出框
        if isNeedLoading == true {
            _ = showLoadingInViewClosure?(inView)
        }
        
        //打印请求参数
        BasePrint.log("请求参数:\(String(describing: paramters))")
        
        /// 配置headers
        let tmpHeader = configHeaders(headers: headers)
        
        return (true, tmpHeader)
    }
    
    fileprivate func checkNetwork<T: Codable>(fail:FailtureClosure?,observer: AnyObserver<T>? = nil) -> Bool {
        
        guard let networkReachability = NetworkReachabilityManager() else {
            return false
        }
        
        //网络不佳，请检查网络
        if networkReachability.isReachable != true {
            let errorMessage = "网络不佳，请检查网络"
            showMessageClosure?(errorMessage)
            
            failtureHandle(error: RequestError.netError(errorMessage: errorMessage), fail: fail,observer: observer)
            return false
        }
        
        return true
    }
    
    fileprivate func configHeaders(headers : HTTPHeaders? = nil) -> HTTPHeaders?{
        //header
        guard var tmpHeader = headers else {
            return headers
        }
        
        tmpHeader["Accept-Encoding"] = "gzip,deflate"
        tmpHeader["Content-Type"] = "application/json"
        
        guard let configHeaderColosure = configHeaderColosure else {
            return tmpHeader
        }
        
        return configHeaderColosure(tmpHeader)
    }
}

//MARK:- success、failture
extension Request {
    //统一的成功回调
    fileprivate func successHandle<T: Codable>(result:DataResponse<Any>,inView:UIView? = nil,complete:SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type,observer: AnyObserver<T>? = nil){
        
        _ = dismissMessageClosure?(inView)

        //BasePrint.log("返回数据 \(String(describing: result.value))")
        
        // 如果解析出来的不是json
        guard let json = result.value, let jsonDic = json as? Dictionary<String, Any> else {
            failtureHandle(inView: inView, error: RequestError.dataJSON(errorMessage: "非JSON格式的数据"), fail: fail,observer: observer)
            return
        }

        var jsonData:Dictionary<String, Any>? = jsonDic
        
        // 如果存在解析服务器数据的闭包，由闭包处理
        if let analyzeDataColosure = analyzeDataColosure {
            var error:RequestError?
            (error,jsonData) = analyzeDataColosure(jsonData)
            
            if error != nil {
                failtureHandle(inView: inView, error: error, fail: fail,observer: observer)
                return
            }
        }
        
        
        guard let jsonDecodeData = jsonData?.toData() else {
            failtureHandle(inView: inView, error: RequestError.dataEmpty(errorMessage: "数据为空"), fail: fail,observer: observer)
            return
        }
        
        do {
            let responseModel = try JSONDecoder().decode(returnType, from: jsonDecodeData)
            
            BasePrint.log("返回数据 \(responseModel)")
            
            complete?(responseModel)
            
            observer?.onNext(responseModel)
            observer?.onCompleted()
        } catch let error as NSError {
            // 异常处理
            failtureHandle(inView: inView, error: RequestError.error(errorMessage: error.description), fail: fail,observer: observer)
        }
    }
    
    //统一的失败回调
    fileprivate func failtureHandle<T: Codable>(inView:UIView? = nil,error:RequestError? = nil,fail : FailtureClosure?,observer: AnyObserver<T>? = nil){
        
        BasePrint.log("error:\(String(describing: error))")
        
        _ = dismissMessageClosure?(inView)
        _ = dismissLoadingInViewClosure?()
        
        fail?(error)
        

        guard let error = error else {
            return
        }
        
        observer?.onError(error)
        observer?.onCompleted()
    }
}
