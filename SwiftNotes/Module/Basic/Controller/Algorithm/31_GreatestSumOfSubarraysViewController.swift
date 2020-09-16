//
//  31_GreatestSumOfSubarraysViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/2/24.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:*
==================================================================
面试题31：
输入一个整型数组，数组里有正数也有负数。数组中一个或连续的多个整数组成一个子数组。求所有子数组的和的最大值。要求时间复杂度为O（n）。
 
例如输入的数组为{1,-2,3,10,-4,7,2,-5}，和最大的子数组为{3,10,-4,7,2}，因此输出为该子数组的和18。
*/
class _31_GreatestSumOfSubarraysViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let arrays = [1,-2,3,10,-4,7,2,-5]
        
        let greatestSumOfSubarrays = findGreatestSumOfSubArray(arr: arrays)
        
        print(debug: "字数组:\(String(describing: greatestSumOfSubarrays))")
    }
    

    func findGreatestSumOfSubArray(arr:[Int]) -> Int? {
        //求出最大的子数组之和
        guard !arr.isEmpty else {
            return nil
        }
        
        var curSum = 0
        
        // 最大的和
        var greatSum = 0
        var index = 0
        
        while index < arr.count {
            if curSum <= 0 {
                curSum = arr[index]
            } else {
                curSum += arr[index]
            }
            
            if curSum > greatSum {
                greatSum = curSum
            }
            index += 1
        }
        return greatSum
    }
}
