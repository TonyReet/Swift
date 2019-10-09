//
//  BaseTabbarController.swift
//  TruckDriver
//
//  Created by liyang on 16/6/7.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class BaseTabbarController: UITabBarController {
    convenience init(itemArray:Array<BaseTabbarItemModel>) {
        self.init()

        for index in 0..<itemArray.count {
            guard let tabbarItemModel = Optional.some(itemArray[index]) else {
                continue
            }

            guard let viewController = SystemTool.classFromString(tabbarItemModel.viewControllerName)
                as? UIViewController.Type else {
                continue
            }
            
            let instanceVC = viewController.init()

            var imgHighlighName:String
            if let tabbarImgHighlighName = tabbarItemModel.imgHighlighName {
                imgHighlighName = tabbarImgHighlighName
            }else{
                imgHighlighName = tabbarItemModel.imgNormalName
            }
            
            addChildVC(instanceVC, title: tabbarItemModel.name, normalImg: tabbarItemModel.imgNormalName, selectedImg: imgHighlighName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //避免受默认的半透明色影响，关闭
        tabBar.isTranslucent = false
        
        // tabbar高亮颜色
        tabBar.tintColor = tabBarTintColor
        
        tabBar.backgroundColor = tabBarBackgroundColor
    }
    
    func addChildVC(_ viewController:UIViewController,title:String,normalImg:String?,selectedImg:String?)  {
        let navigationController = BaseNavigationController.init(rootViewController: viewController)
        
        viewController.title = title
        
        if let normalImg = normalImg {
            let normalImage = UIImage.image(named: normalImg, imageSize: CGSize.init(width: 14, height: 14), imageColor: UIColor.black)
            
            viewController.tabBarItem.image = normalImage?.withRenderingMode(.alwaysOriginal)
        }
        
        if let selectedImg = selectedImg {
            let selectedImage = UIImage.image(named: selectedImg, imageSize: CGSize.init(width: 14, height: 14), imageColor: UIColor.black)
            
            viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        }
        
        addChild(navigationController)
    }
}


