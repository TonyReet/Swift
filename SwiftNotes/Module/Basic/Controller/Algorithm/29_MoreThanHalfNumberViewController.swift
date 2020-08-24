//
//  29_MoreThanHalfNumberViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/8/24.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:*
==================================================================
面试题29：
数组中有一个数字出现的次数超过数组长度的一半，请找出这个数字。例如输入一个长度为9的数组{1,2,3,2,2,2,5,4,2}。由于数字2在数组中出现了5次，超过数组长度的一半，因此输出2。
*/
class _29_MoreThanHalfNumberViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nums = [1,2,3,2,2,2,5,4,2]
        let result = moreThanHalfNum(nums: nums)
        let result1 = moreThanHalfNum1(nums: nums)
        
        print(debug: "查找超过一半的数字是:\((String(describing: result))),\(String(describing: result1))")
    }
    
    func moreThanHalfNum(nums:[Int]?) -> Int? {
        guard var numArray = nums, !numArray.isEmpty else {
            return nil
        }
        
       
        SortTool.quickSort(data: &numArray, low: 0, high: numArray.count - 1)
        
        let middle = numArray.count / 2
        return numArray[middle]
    }
   
    func moreThanHalfNum1(nums:[Int]?) -> Int? {
        guard let numArray = nums, !numArray.isEmpty else {
            return nil
        }
        
        var findNum: Int = numArray.first!
        var findNumCount = 1
        for index in 1..<numArray.count {
            let num = numArray[index]
            
            if num == findNum {
                findNumCount += 1
                continue
            }
                   
            findNumCount -= 1
            
            if findNumCount == 0 {
                findNumCount = 1
                findNum = num
            }
        }
        
        if checkMoreThanHalf(nums: numArray, target: findNum) == true {
            return findNum
        }else{
            return nil
        }
    }
    
    func checkMoreThanHalf(nums:[Int],target:Int) -> Bool {
        var times = 0
        for val in nums {
            if val == target {
                times += 1
            }
        }
        return times * 2 > nums.count
    }
}
