//
//  RequestRouter.swift
//  novelCartoon
//
//  Created by TonyReet on 2019/9/4.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit
import Alamofire

/// all sub url
enum RequestRouter: String, URLConvertible {

    case articleList = "ArticleList"
}

/// baseUrl、protocol、function
extension RequestRouter {
    /// baseUrl
    static var baseUrl: String  = "http://test.j.hcxdi.com/"

    /// protocol
    func asURL() throws -> URL {
        return URL(string: urlString())!
    }
    
    /// 返回拼接好的接口地址字符
    private func urlString() -> String {
        let requestRouterString = RequestRouter.baseUrl.appending(rawValue)
        BasePrint.log("请求的url:\(requestRouterString)")
        
        return requestRouterString
    }
}


