//
//  10_NumberOf1InBinaryViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/19.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit


/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题10：
请实现一个函数，输入一个整数，输出该数二进制表示中1的个数。例如把9表示成二进制是1001，有2位是1。因此如果输入9，该函数输出2
 
*/
class _10_NumberOf1InBinaryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        print(debug: "numOf1有\(numOf1(9))位1")
        print(debug: "numOf2有\(numOf2(9))位1")
        print(debug: "numOf3有\(numOf3(9))位1")
    }
    

    /// 每次右移1为和1 与计算
    func numOf1(_ num: Int )->Int{
        var number = num
        var count = 0
        while number > 0 {
            if (number & 1) == 1 {
                count = count + 1
            }
            number = number >> 1
        }
        
        return count
    }
    
    /// 将1左移和输入的数字 与计算
    func numOf2(_ num: Int )->Int{
        var count = 0
        var flag = 1
        
        while flag > 0 {
            if (num & flag) == 1 {
                count = count + 1
            }
            flag = flag << 1
        }
        
        return count
    }
    
    /// 把一个整数减去1，再和原整数做与运算，会把该整数最右边一个1变成0。那么一个整数的二进制表示中有多少个1，就可以进行多少次这样的操作。例如1100减去1为1001，1100&1001 = 1000，重复此操作就可以算出次数
    func numOf3(_ num: Int )->Int{
        var number = num
        var count = 0
    
        while number > 0 {
            number = number & (number - 1)
            count = count + 1
        }
        
        return count
    }
}
