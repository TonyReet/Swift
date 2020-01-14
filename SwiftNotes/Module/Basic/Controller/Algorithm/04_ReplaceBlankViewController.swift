//
//  04_ModifySpaceViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/1/14.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit
/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题4：
请实现一个函数，把字符串中的每个空格替换成"%20"。例如输入“We are happy.”，则输出“We%20are%20happy.”。
*/

class _4_ReplaceBlankViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let spaceString1 = "test space string"
        let replaceString1 = replaceBlank(spaceString1)
        
        let spaceString2 = "test  space string"
        let replaceString2 = replaceBlank(spaceString2)
        
        let spaceString3:String? = nil
        let replaceString3 = replaceBlank(spaceString3)
        
        let spaceString4 = "      test space string"
        let replaceString4 = replaceBlank(spaceString4)
        
        let spaceString5 = "test space string        "
        let replaceString5 = replaceBlank(spaceString5)
        
        
        print(debug: "replaceString1:\(replaceString1),replaceString2:\(replaceString2),replaceString3:\(replaceString3),replaceString4:\(replaceString4),replaceString5:\(replaceString5)")
    }
    
    func replaceBlank(_ spaceString:String?)->String{
        
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
        var indexOfOriginal = chars.count - 1
        var indexOfNew = count - 1
        
        //先给 array 扩容。
        for _ in 0..<blankCount*2 {
            chars.append(" ")
        }
        
        while indexOfOriginal >= 0 && indexOfNew > indexOfOriginal {
            
            if chars[indexOfOriginal] == " " {
                chars[indexOfNew] =  "0"
                indexOfNew -= 1
                chars[indexOfNew] =  "2"
                indexOfNew -= 1
                chars[indexOfNew] = "%"
                indexOfNew -= 1
            } else {
                chars[indexOfNew] = chars[indexOfOriginal]
                indexOfNew -= 1
            }
            
            indexOfOriginal -= 1
        }
        return String(chars)
    }
}
