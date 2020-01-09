//
//  01_DuplicationInArrayViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/12/13.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题3：
在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数
*/

class _3_FindTargetInArrayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nums = [[1, 2, 8, 9], [2, 4, 9, 12], [4, 7, 10, 13], [6, 8, 11, 15]]
        
        /// 存在的数字
        let testCase1 = findTargetRightTop(7, nums)
        
        /// 不存在
        let testCase2 = findTargetRightTop(99, nums)
        
        /// 数组传空
        let testCase3 = findTargetRightTop(2, nil)
        
        print(debug: "findTargetRightTop:testCase1:\(testCase1),testCase2:\(testCase2),testCase3:\(testCase3)")
        
        /// 存在的数字
        let testCase4 = findTargetLeftBottom(7, nums)
        
        /// 不存在
        let testCase5 = findTargetLeftBottom(99, nums)
        
        /// 数组传空
        let testCase6 = findTargetLeftBottom(2, nil)
        
        print(debug: "findTargetLeftBottom:testCase4:\(testCase4),testCase5:\(testCase5),testCase6:\(testCase6)")
    }
    
    
    /// 右上角
    func findTargetRightTop(_ target:Int, _ arr: [[Int]]?) -> Bool {
        var isFindTarget = false
        
        guard let arr = arr, arr.count != 0,let firstArr = arr.first,firstArr.count != 0 else {
            return isFindTarget
        }
        
        let maxRow = arr.count - 1
        let maxColum = firstArr.count - 1
        
        var (currentRow,currentColum) = (0, maxColum)
        
        while (currentRow >= 0 && currentRow <= maxRow) && (currentColum >= 0 && currentColum <= maxColum) {
            
            let currentValue = arr[currentRow][currentColum]
            
            if (target == currentValue) {
                isFindTarget = true
                break
            }else if (target > currentValue){
                currentRow += 1
            }else {
                currentColum -= 1
            }
        }
        
        return isFindTarget
    }
    
    /// 左下角
    func findTargetLeftBottom(_ target:Int, _ arr: [[Int]]?) -> Bool {
        var isFindTarget = false
        
        guard let arr = arr, arr.count != 0,let firstArr = arr.first,firstArr.count != 0 else {
            return isFindTarget
        }
        
        let maxRow = arr.count - 1
        let maxColum = firstArr.count - 1
        
        var (currentRow,currentColum) = (maxRow, 0)
        
        while (currentRow >= 0 && currentRow <= maxRow) && (currentColum >= 0 && currentColum <= maxColum) {
            
            let currentValue = arr[currentRow][currentColum]
        
            if (target == currentValue) {
                isFindTarget = true
                break
            }else if (target < currentValue){
                currentRow -= 1
            }else {
                currentColum += 1
            }
        }
        
        return isFindTarget
    }
}
