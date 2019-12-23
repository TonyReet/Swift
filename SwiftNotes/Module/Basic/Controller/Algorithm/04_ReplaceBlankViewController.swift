//
//  04_ModifySpaceViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/12/17.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class _4_ModifySpaceViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let spaceString1 = "test space string"
        let modifyString1 = modifySpace(spaceString1)
        
        let spaceString2 = "test  space string"
        let modifyString2 = modifySpace(spaceString2)
        
        let spaceString3:String? = nil
        let modifyString3 = modifySpace(spaceString3)
        
        let spaceString4 = "      test space string"
        let modifyString4 = modifySpace(spaceString4)
        
        let spaceString5 = "test space string        "
        let modifyString5 = modifySpace(spaceString5)
        
        
        print(debug: "modifySpace,modifyString1:\(modifyString1),modifyString2:\(modifyString2),modifyString3:\(modifyString3),modifyString4:\(modifyString4),modifyString5:\(modifyString5)")
    }
    
    func modifySpace(_ spaceString:String?)->String{
        
        //判断异常情况
        //判断空格情况，计算空格长度
        //从最后往前面拷贝，遇到空格，就替换成%20
        guard let spaceString = spaceString else {
            return ""
        }
        
        var chars = Array(spaceString)
        
        guard chars.count > 0  else{
            return ""
        }
        var blankCount = 0
        for char in chars {
            if char == " " {
                blankCount += 1
            }
        }
        
        let count = chars.count + blankCount * 2
        var indexOfOriginal = chs.count - 1
        var j = count - 1
        
        //先给 array 扩容。
        for _ in 0..<blankCount*2 {
            chs.append(" ")
        }
        
        while i >= 0 && j >= 0 {
            if chs[i] == " " {
                chs[j] =  "0"
                j -= 1
                chs[j] =  "2"
                j -= 1
                chs[j] = "%"
                j -= 1
                i -= 1
            } else {
                chs[j] = chs[i]
                j -= 1
                i -= 1
            }
        }
        return String(chs)
    }
}
