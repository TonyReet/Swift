//  BaseViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController ,UIGestureRecognizerDelegate{
    let backgroundColor = UIColor { (trainCollection) -> UIColor in
        if trainCollection.userInterfaceStyle == .dark {
            return .black
        } else {
            return .white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = backgroundColor
        
        let leftBarFrame = CGRect(x: 0, y: 0, width: 60, height: 30)
        let minBarWidthHeight = 10
        let leftBarImage = UIImage.image(named: "0xf3b3", imageSize: CGSize(width:minBarWidthHeight, height: minBarWidthHeight),imageColor:mainThemeColor)
        
        initLeftBarItems(frame: leftBarFrame, image: leftBarImage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print(debug:"leave vc:" + NSStringFromClass(type(of: self)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print(debug:"enter vc:" + NSStringFromClass(type(of: self)))
    }
    
    deinit{
        print(debug:"\(self) is die")
    }
}


//MARK:- other function
extension BaseViewController {
    //backButton
    func initLeftBarItems(frame:CGRect,title:String? = nil,titleColor:UIColor? = .label,titleFontSize:CGFloat = 14,image:UIImage? = nil) {
        let backBtn = UIButton(frame:frame)
        let barButtonItem = UIBarButtonItem(customView: backBtn)
        
        if title?.isEmpty == false {
            backBtn.titleEdgeInsets = UIEdgeInsets.zero
            backBtn.setTitleColor(.label, for: .normal)
            backBtn.setTitle(title, for: UIControl.State())
            backBtn.titleLabel?.font = UIFont.systemFont(ofSize: titleFontSize)
        }

        if image != nil {
            backBtn.setImage(image, for: .normal)
            backBtn.contentHorizontalAlignment = .left
            backBtn.contentVerticalAlignment = .center
        }
        
        backBtn.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside)

        if navigationController?.viewControllers.first == self {
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItem = barButtonItem
        }
    }
    
    //backAction
    @objc func backAction(){
       let _ =  navigationController?.popViewController(animated: true)
    }
}

