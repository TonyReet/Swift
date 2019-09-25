//
//  RequestError.swift
//  novelCartoon
//
//  Created by TonyReet on 2019/9/25.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import Foundation


public enum RequestError: Error {
    /// 普通的错误信息
    case error(errorMessage: String)
    
    /// 数据不是json格式
    case dataJSON(errorMessage: String)
    
    /// 数据不匹配
    case dataMatch(errorMessage: String)
    
    /// 数据为空
    case dataEmpty(errorMessage: String)
    
    /// 网络错误
    case netError(errorMessage: String)

    /// 服务器数据不匹配
    case serverMatch(errorMessage: String)
 
    
    ///  网络错误处理
    static func apiError(with error: NSError) -> RequestError {
        BasePrint.log("错误信息是 \(error)")
        
        if error.domain == "Alamofire.AFError" {
            //处理自带的错误
            if error.code == 4 {
                return RequestError.dataEmpty(errorMessage: "数据为空")
            }
        }
        return RequestError.netError(errorMessage: "未知网络错误")
    }
}
