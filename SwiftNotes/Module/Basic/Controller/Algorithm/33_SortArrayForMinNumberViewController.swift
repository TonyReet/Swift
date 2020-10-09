//
//  33_SortArrayForMinNumberViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/9/10.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:****
==================================================================
面试题33：
输入一个正整数数组，把数组里所有数字拼接起来排成一个数，打印能拼接出的所有数字中最小的一个。例如输入数组{3,32,321}，则打印出这3个数字能排成的最小数字321323。

*/

class _33_SortArrayForMinNumberViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let num1 = printMinNumber([3,5,1,4,2])
        let num2 = printMinNumber([3,32,321])
        let num3 = printMinNumber([3,323,32123])
        let num4 = printMinNumber([1,12,131])
        let num5 = printMinNumber([321])
        
        print(debug: "拼接的数字:\(num1!),\(num2!),\(num3!),\(num4!),\(num5!)")
    }
    
    /**
     根据输入数组，返回数组里所有数字拼接起来能排成的最小数字
     - Parameters:
        - nums: 数组
     - Returns: 最小的数字
     */
    func printMinNumber(_ nums: [Int]) -> Int? {
        if nums.count == 0 { return nil }
        let digitCount = nums.reduce(0, { x, y in
            x + String(y).count
        })
        if digitCount > 10 {
            return nil
        }
        
        //核心解法：将问题转换为排序，然后将输入的数字转换成字符串，再将$0和$1进行拼接比较，小的排在前面
        let nums = nums.map{String($0)}.sorted{return $0+$1 < $1+$0 }
        let minNumber = nums.reduce("", {x, y in
            x + y
        })
        return Int(minNumber)
    }
}
