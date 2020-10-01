//
//  32_NumberOf1ViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/10/1.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:****
==================================================================
面试题32：
输入一个整数n，求从1到n这n个整数的十进制表示中1出现的次数。例如输入12，从1到12这些整数中包含1 的数字有1，10，11和12，1一共出现了5次。
 
 解题思路参考，剑指Offer看不懂
 https://blog.csdn.net/yi_Afly/article/details/52012593
*/

class _32_NumberOf1ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let num = numOf1(num: 21345)
        
        print(debug: "包含1的个数:\(num)")
    }
    
    func numOf1(num:Int) -> Int {
        guard num > 1 else {
            return 0
        }
        var count = 0//记录有多少个1
        var base = 1//代表走1round出现几次1
        var round = num
        
        while round > 0 { //第几round。先从个位开始
            let weight = round % 10 //权重就是当前位的数字
            round /= 10
            count += round * base
            if weight == 1 {
                count += num % base + 1
            }
            if weight > 1 {
                count += base
            }
            base *= 10
        }
        return count
    }

}
