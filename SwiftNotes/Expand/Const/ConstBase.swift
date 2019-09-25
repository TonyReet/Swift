//
//  ConstDefine.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit
import Foundation

/*
 *  screens
 */
let ScreenBounds    = UIScreen.main.bounds
let ScreenSize      = ScreenBounds.size
let ScreenWidth     = ScreenBounds.width
let ScreenHeight    = ScreenBounds.height

/*
 *  iPhones
 */
let iPhone4Series              = {
    return ScreenHeight == 480 && ScreenWidth == 320
}()

let iPhone5Series              = {
    return ScreenHeight == 568 && ScreenWidth == 320
}()

let iPhone6Series              = {
    return ScreenHeight == 667 && ScreenWidth == 375
}()

let iPhonePlusSeries           = {
    return ScreenHeight == 736 && ScreenWidth == 414
}()

let isiPhoneXSeries = { () -> Bool in
    
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        return false
    }
    
    if #available(iOS 11.0, *) {
        guard let mainWindow:UIWindow? = UIApplication.shared.delegate?.window else{
            return false
        }
        
        guard let safeBottom = mainWindow?.safeAreaInsets.bottom else{
            return false
        }
        
        if safeBottom > CGFloat(0.0) {
            return true
        }
    }
    
    return false
}()

/// 获取沙盒Document路径
let kDocumentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first!

/// 获取沙盒Cache路径
let kCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

/// 获取沙盒temp路径
let kTempPath = NSTemporaryDirectory()

/*
 *  threads
 */
func MainThreadAsync(_ method:@escaping ()->()){

    if Thread.isMainThread {
        method()
        return
    }

    DispatchQueue.main.async(execute: {
        method()
    })
}

func MainThreadSync(_ method:@escaping ()->()){
    if Thread.isMainThread {
        method()
        return
    }
    
    DispatchQueue.main.sync(execute: {
        method()
    })
}

func GlobalThreadAsync(_ method:@escaping ()->()){
    DispatchQueue.global().async {
        method()
    }
}

func GlobalThreadSync(_ method:@escaping ()->()){
    DispatchQueue.global().sync {
        method()
    }
}

func GCDAfterAsync(_ delay : Double, method:@escaping ()->()){
    
    let delayTime =  DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
        method()
    }
}

