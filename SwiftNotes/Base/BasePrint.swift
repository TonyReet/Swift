//
//  BasePrint.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

public func print(debug: Any...,
                  function: String = #function,
                  file: String = #file,
                  line: Int = #line) {
    #if DEBUG
    var filename = file
    if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
        filename = String(filename[match])
    }
    Swift.print("Debug Log:\(filename),line:\(line),function:\(function)\n\(debug) \n")
    #endif
}

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    
    #if DEBUG
    Swift.print(items, separator:separator, terminator: terminator)
    #endif
}

public func print<Target>(_ items: Any..., separator: String = " ", terminator: String = "\n", to output: inout Target) where Target : TextOutputStream {
    
    #if DEBUG
    Swift.print(items, separator: separator, terminator: terminator)
    #endif
}

public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    Swift.debugPrint(items, separator: separator, terminator: terminator)
    #endif
}

public func debugPrint<Target>(_ items: Any..., separator: String = " ", terminator: String = "\n", to output: inout Target) where Target : TextOutputStream {
    #if DEBUG
    Swift.debugPrint(items, separator: separator, terminator: terminator)
    #endif
}

public func NSLog(message:String){
    #if DEBUG
    Foundation.NSLog(message)
    #endif
}
public func NSLog(format:String, _ args:CVarArg...){
    #if DEBUG
    Foundation.NSLog(String(format: format, arguments: args))
    #endif
}
