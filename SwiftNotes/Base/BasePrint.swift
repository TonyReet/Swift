//
//  BasePrint.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class BasePrint: NSObject {
    //创建单例
    static let shared      = BasePrint()
    
    //MARK: - 打印的方法
    //log
    class func log<T>(_ message : T,fileName: String = #file, methodName: String = #function, lineNumber: Int = #line)  {
        
        #if DEBUG
            //获取类名
            let className : String = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
            
        print("\(className)function:\(methodName)[\(lineNumber)] - :\n\(message)\n")
        #endif
    }
}
