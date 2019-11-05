//
//  ConstDefine.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit
import Foundation

/// 导入第三方库
@_exported import SnapKit
@_exported import RxSwift
@_exported import RxCocoa
@_exported import RxDataSources

/*
 *  screens
 */
let kScreenBounds    = UIScreen.main.bounds
let kScreenSize      = kScreenBounds.size
let kScreenWidth     = kScreenBounds.width
let kScreenHeight    = kScreenBounds.height

//APP版本号
let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
//当前系统版本号
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue

// UserDefaults 操作
let kUserDefaults = UserDefaults.standard
func kUserDefaultsRead(_ KeyStr: String) -> Any? {
    return kUserDefaults.value(forKey: KeyStr)
}

func kUserDefaultsWrite(_ obj: Any, _ KeyStr: String) {
    kUserDefaults.set(obj, forKey: KeyStr)
}


//判断是否为iPhone
let kDeviceIsiPhone = (UI_USER_INTERFACE_IDIOM() == .phone)
//判断是否为iPad
let kDeviceIsiPad = (UI_USER_INTERFACE_IDIOM() == .pad)

func kScreenWidthRatio(_ width: CGFloat) -> CGFloat {
    return width*kScreenWidth / 375.0
}
func kScreenHeightRatio(_ height: CGFloat) -> CGFloat {
    return height*kScreenHeight / 667.0
}

//获取状态栏、标题栏、导航栏高度
let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
let kNavigationBarHeight: CGFloat =  iPhoneXSeries ? 88 : 44
let KTabBarHeight: CGFloat = iPhoneXSeries ? 83 : 49

// 注册通知
func kNotifyAdd(observer: Any, selector: Selector, name: String) {
    return NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(rawValue: name), object: nil)
}
// 发送通知
func kNotifyPost(name: String, object: Any) {
    return NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object)
}
// 移除通知
func kNotifyRemove(observer: Any, name: String) {
    return NotificationCenter.default.removeObserver(observer, name: Notification.Name(rawValue: name), object: nil)
}

//代码缩写
let kApplication = UIApplication.shared
let kAPPKeyWindow = kApplication.keyWindow
let kAppDelegate = kApplication.delegate
let kAppNotificationCenter = NotificationCenter.default
let kAppRootViewController = kAppDelegate?.window??.rootViewController

//字体 字号
func kFontSize(_ a: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: a)
}
func kFontBoldSize(_ a: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: a)
}

/*
 *  iPhones
 */
let iPhone4Series              = {
    return kScreenHeight == 480 && kScreenWidth == 320
}()

let iPhone5Series              = {
    return kScreenHeight == 568 && kScreenWidth == 320
}()

let iPhone6Series              = {
    return kScreenHeight == 667 && kScreenWidth == 375
}()

let iPhonePlusSeries           = {
    return kScreenHeight == 736 && kScreenWidth == 414
}()

let iPhoneXSeries = { () -> Bool in
    
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

//颜色
func kRGBAColor(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat) -> UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: a)
}

func kRGBColor(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat) -> UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
}

func kHexColorA(_ HexString: String,_ a: CGFloat) ->UIColor {
    return UIColor.init(hexString: HexString, transparency: a)
}

func kHexColor(_ HexString: String) ->UIColor {
    return UIColor.init(hexString: HexString)
}


func kLocalizedString(_ key:String?) -> String {
    guard let key = key else {
        return ""
    }
    
    return NSLocalizedString(key, comment: key)
}
