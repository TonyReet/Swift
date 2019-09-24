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

        //避免受默认的半透明色影响，关闭
        navigationBar.isTranslucent      = false
        
        navigationBar.tintColor        = navigationBarTintColor
        navigationBar.barTintColor     = navigationBarBarTintColor
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:navigationBar.tintColor!]
        view.backgroundColor = UIColor.white
        
        //隐藏底部的线
        getBottomLineView(navigationBar)?.isHidden = true
    }
}

//MARK:- Methods
extension BaseNavigationController {
    //底部线
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
