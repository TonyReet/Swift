//
//  30_KLeastNumbersViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/9/12.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:*
==================================================================
面试题30：
输入n个整数，找出其中最小的k个数。例如输入4、5、1、6、2、7、3、8这8个数字，则最小的4个数字是1、2、3、4。
*/
class _30_KLeastNumbersViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nums = [4,5,1,6,2,7,3,8]
        
        let leastNumbers = kLeastNumbers(nums: nums, kNum: 4)
        
        let leastNumbers1 = kLeastNumbers1(nums: nums, kNum: 4)
        
        print(debug: "查找的最小数:\(String(describing: leastNumbers)),\(String(describing: leastNumbers1))")
    }
    
    func kLeastNumbers(nums:[Int]?, kNum: Int) -> [Int]? {
        guard var numArray:[Int] = nums, !numArray.isEmpty else {
            return nil
        }
        
        if kNum > numArray.count {
            return numArray
        }
            
        SortTool.quickSort(data: &numArray, low: 0, high: numArray.count - 1)
        
        let endIndex = min(numArray.count, kNum)
        
        return Array<Int>(numArray[0..<endIndex])
    }
    
    func kLeastNumbers1(nums:[Int]?, kNum: Int) -> [Int]? {
        guard let numArray:[Int] = nums, !numArray.isEmpty else {
            return nil
        }
        
        if kNum > numArray.count {
            return numArray
        }
            
        var newNums = [Int]()
        
        for index in 0..<numArray.count {
            let num = numArray[index]
            
            if newNums.count < kNum {
                newNumsAddWithNum(newNums: &newNums, num: num, kNum: kNum)
                continue
            }

            if num > newNums.last!{
                continue
            }
            
            newNumsAddWithNum(newNums: &newNums, num: num, kNum: kNum)
        }
        
        return newNums;
    }
    
    func newNumsAddWithNum(newNums:inout [Int], num: Int, kNum: Int){
        if newNums.isEmpty {
            newNums.append(num)
            return
        }
        
        if newNums.count < kNum {
            if newNums.last! < num {
                newNums.append(num)
            }else if num < newNums.first! {
                newNums.insert(num, at: 0)
            }
            
            return
        }
        
        for (newNumIndex,newNum) in newNums.enumerated() {
            if newNum > num {
                newNums.insert(num, at: newNumIndex)
                newNums.removeLast()
                break
            }
        }
    }
}
