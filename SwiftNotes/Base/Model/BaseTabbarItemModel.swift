//
//  BaseTabbarItemModel.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import Foundation

struct BaseTabbarItemModel {
    var name:String
    
    var imgNormalName:String
    
    var imgHighlighName:String?
    
    var viewControllerName:String
    
    init(name:String, imgNormalName:String, imgHighlighName:String? = nil,viewControllerName:String) {

        self.name = name
        self.imgNormalName = imgNormalName
        self.imgHighlighName = imgHighlighName
        self.viewControllerName = viewControllerName
    }
}

