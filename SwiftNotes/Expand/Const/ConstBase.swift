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
let iPhone4             = {
    return ScreenHeight == 480 && ScreenWidth == 320
}()

let iPhone5             = {
    return ScreenHeight == 568 && ScreenWidth == 320
}()

let iPhone6             = {
    return ScreenHeight == 667 && ScreenWidth == 375
}()

let iPhone6P             = {
    return ScreenHeight == 736 && ScreenWidth == 414
}()

let iPhoneX             = {
    return ScreenHeight == 812.0 && ScreenWidth == 375.0
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

/*
 *  paths
 */
let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!

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

