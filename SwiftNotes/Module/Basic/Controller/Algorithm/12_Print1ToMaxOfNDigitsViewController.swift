//
//  12_Print1ToMaxOfNDigitsViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/27.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题12：
输入数字n，按顺序打印出从1最大的n位十进制数。比如输入3，则打印出1、2、3一直到最大的3位数即999。
 
*/
class _12_Print1ToMaxOfNDigitsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print1ToMaxOfNDigits(digitCount: 1)
        
        print1ToMaxOfNDigits(digitCount: -1)
        
        print1ToMaxOfNDigits(digitCount: 0)
        
        print1ToMaxOfNDigits(digitCount: 3)
    }
    

    // 普通进位
    func print1ToMaxOfNDigits(digitCount:Int) {
        if digitCount <= 0 {
            print(debug: "输入位数小于0，输入为：\(digitCount)")
            return
        }
        
        var number:[String] = [String].init(repeating: "0", count: digitCount)
        while !self.increment(number: &number) {
            let result = self.printNumber(data: number.joined())
            print(debug: "输出数字：\(result)")
        }
    }
    
    // 如果最高为加1之后，会溢出，普通位直接+1输出，如果是大于10，设置carry为1，继续输出
    func increment(number:inout [String]) -> Bool {
        
        var isOverflow:Bool = false
        var carry:Int = 0
        var sum:Int = 1
        
        /// 倒序，现在个位加1，然后再进位
        for i in (0..<number.count).reversed() {
            sum = Int(number[i])! + carry
            // 个位数加1
            if i == number.count-1 {
                sum += 1
            }
            
            // 需要进位
            if sum >= 10 {
                
                // 如果是第一位，所有的结束
                if i==0 {
                    isOverflow = true
                } else {// 不是第一位，进位
                    sum -= 10
                    
                    // 进位标志
                    carry = 1
                    number[i] = String(sum)
                }
            } else {
                // 不需要进位，直接修改值，结束循环
                number[i] = String(sum)
                break
            }
        }
        return isOverflow
    }
    
    func printNumber(data:String) -> String {
        var start:String.Index = data.index(data.startIndex, offsetBy: 0)
        let result:String = data
        
        let charArray = Array(data)
        
        // 查找到截取字符串的起点
        for i in 0..<charArray.count {
            let index:String.Index = data.index(data.startIndex, offsetBy: i)
            let currentChar: Character = data[index]
            
            // 查找第一个不是0的char
            if currentChar != "0"{
                start = index
                break
            }
            
            // 最后一个如果还是0，就取最后一个
            if i == charArray.count - 1 && currentChar == "0" {
                start = index
                break
            }
        }
    
        return String(result[start..<result.endIndex])
    }

}
