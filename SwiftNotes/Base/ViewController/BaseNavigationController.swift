//
//  BaseNavigationController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//
import Foundation
import UIKit

class BaseNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent      = false
        
//        navigationBar.tintColor        = navigationBarTintColor
//        navigationBar.barTintColor     = navigationBarBarTintColor
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:navigationBar.tintColor!]
//        view.backgroundColor = UIColor.white
        
        //隐藏底部的线
        getBottomLineView(navigationBar)?.isHidden = true
        
        enableHandlePop()
    }
}

//MARK:- Methods
extension BaseNavigationController {
    func getBottomLineView(_ view:UIView) -> UIImageView?{
        if view is UIImageView && view.bounds.size.height <= 1.0{
            
            return view as? UIImageView
        }
        
        for subview in view.subviews{
            if let bottomView =  getBottomLineView(subview){
                return bottomView
            }
        }
        return nil
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
      
    func enableHandlePop() {
        /// 解决自定义返回按钮导致侧滑返回被禁止问题
        if self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) == true {
            interactivePopGestureRecognizer?.delegate = (self as! UIGestureRecognizerDelegate)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
}
