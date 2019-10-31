//
//  AppDelegate+Extension.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

extension AppDelegate {
    func initRootViewController(isLogin:Bool? = true) {
        
        // 配置数据
        var itemArray = Array<BaseTabbarItemModel>()
        
        
        
        let basicString = kLocalizedString("Basic")
        itemArray.append(BaseTabbarItemModel.init(name: basicString, imgNormalName: Iconfont.homeNormal.rawValue,imgHighlighName: Iconfont.homeSelect.rawValue, viewControllerName: "BasicViewControler"))
        
        let mediaString = kLocalizedString("Media")
        itemArray.append(BaseTabbarItemModel.init(name: mediaString, imgNormalName: Iconfont.folderNormal.rawValue,imgHighlighName: Iconfont.folderSelect.rawValue, viewControllerName: "MediaViewController"))
  
        let tabbarController = BaseTabbarController.init(itemArray:itemArray)
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
    }
}
