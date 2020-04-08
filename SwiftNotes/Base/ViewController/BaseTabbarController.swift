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
        
        tabBar.isTranslucent = false
        tabBar.tintColor = tabBarSelectColor
    }
    
    func addChildVC(_ viewController:UIViewController,title:String,normalImg:String?,selectedImg:String?)  {
        let navigationController = BaseNavigationController.init(rootViewController: viewController)
        
        viewController.title = title
        
        if let normalImg = normalImg {
            let normalImage = UIImage.image(named: normalImg, fontSize: 10, imageColor: tabBarNormalColor)
            viewController.tabBarItem.image = normalImage?.withRenderingMode(.alwaysOriginal)
        }
        
        if let selectedImg = selectedImg {
            let selectedImage = UIImage.image(named: selectedImg, fontSize: 10, imageColor: tabBarSelectColor)
            
            viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        }
        
        addChild(navigationController)
    }
}


