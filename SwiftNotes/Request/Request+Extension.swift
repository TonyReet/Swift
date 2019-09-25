//
//  RxSwift.swift
//  novelCartoon
//
//  Created by TonyReet on 2019/9/5.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

//MARK:- 链式调用
extension Request {
    
    func showMessage(_ showMessage: @escaping ShowMessageClosure) -> Self {
        showMessageClosure = showMessage
        
        return self
    }
    
    func showLoadingInView(_ showLoadingInView: @escaping ShowLoadingInViewClosure) -> Self {
        showLoadingInViewClosure = showLoadingInView
        
        return self
    }
    
    func dismissMessage(_ dismissMessage: @escaping DismissMessageClosure) -> Self {
        dismissMessageClosure = dismissMessage
        
        return self
    }
    
    func dismissLoadingInView(_ dismissLoadingInView: @escaping DismissLoadingInViewClosure) -> Self {
        dismissLoadingInViewClosure = dismissLoadingInView
        
        return self
    }
    
    
    func configHeader(_ configHeader: @escaping ConfigHeaderColosure) -> Self {
        configHeaderColosure = configHeader
        
        return self
    }
    
    func analyzeData(_ analyzeData: @escaping AnalyzeDataColosure) -> Self {
        analyzeDataColosure = analyzeData
        
        return self
    }
}


//MARK:- RxSwift
extension Request {
    static func rxGet<T: Codable>(url: RequestRouter, paramters: Parameters? = nil, headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete: SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type) -> Observable<T> {
        return Observable<T>.create({ (observer: AnyObserver<T>) -> Disposable in
            Request.get(url: url, paramters: paramters, headers: headers, isNeedLoading: isNeedLoading, inView: inView, complete: complete, fail: fail, returnType: returnType,observer: observer)
            
            return Disposables.create()
        })
    }
    
    
    static func rxPost<T: Codable>(url: RequestRouter, paramters: Parameters? = nil, headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete: SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type) -> Observable<T> {
        return Observable<T>.create({ (observer: AnyObserver<T>) -> Disposable in
            Request.post(url: url, paramters: paramters, headers: headers, isNeedLoading: isNeedLoading, inView: inView, complete: complete, fail: fail, returnType: returnType,observer: observer)
            
            return Disposables.create()
        })
    }
    
    static func upLoadImages<T: Codable>(url: RequestRouter, paramters: Parameters? = nil, images: [UIImage],headers : HTTPHeaders? = nil,isNeedLoading:Bool? = true,inView:UIView? = nil,complete: SuccessClosure? = nil,fail:FailtureClosure? = nil,returnType: T.Type) -> Observable<T> {
        return Observable<T>.create({ (observer: AnyObserver<T>) -> Disposable in
            Request.upLoadImages(url: url, paramters: paramters, images: images, headers: headers, isNeedLoading: isNeedLoading, inView: inView, complete: complete, fail: fail, returnType: returnType, observer: observer)
            return Disposables.create()
        })
    }
}
