//  BaseViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController ,UIGestureRecognizerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge()
    
        view.backgroundColor = viewBackgroundColor
        
        initLeftBarItems(frame: CGRect(x: 0, y: 0, width: 60, height: 30), title:"返回", titleColor: navigationBarLeftBackColor, titleFontSize: 16)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print(debug:"离开的vc:" + NSStringFromClass(type(of: self)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print(debug:"进入的vc:" + NSStringFromClass(type(of: self)))
    }
    
    deinit{
        print(debug:"\(self) is die")
    }
}


//MARK:- 其他功能
extension BaseViewController {
    //返回键
    func initLeftBarItems(frame:CGRect,title:String? = nil,titleColor:UIColor,titleFontSize:CGFloat,image:UIImage? = nil) {
        //返回键
        let backBtn = UIButton(frame:frame)
        let barButtonItem = UIBarButtonItem(customView: backBtn)
        
        backBtn.titleEdgeInsets = UIEdgeInsets.zero
        backBtn.setTitleColor(titleColor, for: .normal)
        backBtn.setTitle(title, for: UIControl.State())
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: titleFontSize)
        backBtn.setImage(image, for: UIControl.State())
        backBtn.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        backBtn.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside)

        //间隙
        let  negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        negativeSpacer.width = -10
       
        if navigationController?.viewControllers.first == self {
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItems = [negativeSpacer,barButtonItem]
        }
    }
    
    //返回的处理事件
    @objc func backAction(){
       let _ =  navigationController?.popViewController(animated: true)
    }
}

