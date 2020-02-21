//
//  08_MinNumberInRotatedArrayViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/15.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题8：
把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。例如数组{3,4,5,1,2}为{1,2,3,4,5}的一个旋转，该数组的最小值为1。
*/
class _8_MinNumberInRotatedArrayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let (isFind,minNum) = minNumberInRotated(rotateArray: [1,2,3,4,5])
        if isFind {
            print(debug: "[1,2,3,4,5]查找的最小数是:\(minNum)")
        }
        
        
        let (isFind1,minNum1) = minNumberInRotated(rotateArray: [3,4,5,1,2])
        if isFind1 {
            print(debug: "[3,4,5,1,2]查找的最小数是:\(minNum1)")
        }
        
        
        let (isFind2,minNum2) = minNumberInRotated(rotateArray: [4,5,1,2,3])
        if isFind2 {
            print(debug: "[4,5,1,2,3]查找的最小数是:\(minNum2)")
        }
        
        let (isFind3,minNum3) = minNumberInRotated(rotateArray: [])
        if isFind3 {
            print(debug: "[]查找的最小数是:\(minNum3)")
        }else{
            print(debug: "[]没有查找到")
        }
    }
    
    func minNumberInRotated(rotateArray: [Int] ) -> (Bool,Int) {
        guard rotateArray.count != 0 else {
            return (false,0)
        }

        var startIndex = 0
        var endIndex = rotateArray.count - 1
        var middleIndex: Int = 0
        var middleNum: Int = NSIntegerMax

        while rotateArray[startIndex] >= rotateArray[endIndex] {

            if endIndex - startIndex <= 1 {

                middleIndex = endIndex
                break
            }

            middleIndex = (startIndex + endIndex) / 2
            middleNum = rotateArray[middleIndex]

            if middleNum >= rotateArray[startIndex] {
                startIndex = middleIndex
            }else if middleNum <= rotateArray[endIndex] {
                endIndex = middleIndex
            }
        }
        return (true, rotateArray[middleIndex])
    }

}
