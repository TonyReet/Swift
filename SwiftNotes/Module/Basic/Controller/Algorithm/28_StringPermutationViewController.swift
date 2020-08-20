//
//  28_StringPermutationViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/8/21.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:***
==================================================================
面试题28：
 输入一个字符串，打印出该字符串中字符的所有排列。例如输入字符串abc，则打印出由字符a、b、c所能排列出来的所有字符串abc、acb、bac、bca、cab和cba。
*/
class _28_StringPermutationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let str1 = Array("")
        permutation(str: str1)
        
        
        let str2 = Array("abc")
        permutation(str: str2)
        
//        let str3 = Array("abcd")
//        permutation(str: str3)
    }
    

    func permutation(str:[Character]) {
        guard !str.isEmpty else {
            return
        }
        permutation(str: str, begin: 0)
    }

    func permutation(str:[Character],begin:Int) {
        
        if begin == str.count - 1 {
            print(debug: str)
            return
        }
        
        var index = begin
        var charsets = str
        
        while index < charsets.count {
            // 交换位置
            var tmp = charsets[index]
            charsets[index] = charsets[begin]
            charsets[begin] = tmp
            
            permutation(str: charsets, begin: begin + 1)
            
            // 还原
            tmp = charsets[index]
            charsets[index] = charsets[begin]
            charsets[begin] = tmp
            
            index += 1
        }
    }
}
