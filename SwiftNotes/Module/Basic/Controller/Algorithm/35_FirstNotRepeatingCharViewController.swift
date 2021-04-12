//
//  35_FirstNotRepeatingCharViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2021/4/12.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:**
==================================================================
面试题35：
在字符串中找出第一个只出现一次的字符。如输入"abaccdeff"，则输出'b'。

*/


class _35_FirstNotRepeatingCharViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let englishStr = "abaccdeff"//"Today was Sunday and I was very happy!In the morning!"
        
        let findChar = firstNotRepatingChar(str:Array(englishStr))
        
        print(debug: "查找到只出现一次的字符:\(String(describing: findChar))")
    }
    

    func firstNotRepatingChar(str:[Character]) -> Character? {
        guard !str.isEmpty else {
            return nil;
        }
        
        var hashTable  = [Character:Int]()
        for ch in str {
            if let cnt = hashTable[ch] {
                hashTable[ch] = cnt + 1
            } else {
                hashTable[ch] = 1
            }
        }

        var minIndex = Int.max
        for (key,value) in hashTable {
            if value == 1 {
                let curIndex =  str.firstIndex(of: key) ?? -1
                if minIndex > curIndex {
                    minIndex = curIndex
                }
            }
        }
        
        if minIndex != -1 {
            return str[minIndex]
        }
        return nil
    }
}
