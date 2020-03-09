//
//  14_ReorderArrayViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/2/1.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题14：
输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数位于数组的前半部分，所有偶数位于数组的后半部分
 
*/

class _14_ReorderArrayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var array = [1,2,3,4,5,6,7,8]
        reorderArray(array: &array) { (value) -> Bool in
            return (value & 0x01) == 1
        }

        
        var array1 = [1]
        reorderArray(array: &array1) { (value) -> Bool in
            return (value & 0x01) == 1
        }
        
        var array2 = [2,1]
        reorderArray(array: &array2) { (value) -> Bool in
            return (value & 0x01) == 1
        }
        
        var array3 = [Int]()
        reorderArray(array: &array3) { (value) -> Bool in
            return (value & 0x01) == 1
        }
        
        print(debug: "排序数组:\(array),array1:\(array1),array2:\(array2),array3:\(array3)")
        
        var array4 = [1,2,3,4,5,6,7,8]
        reorderArray2(array: &array4)
        
        var array5 = [1]
        reorderArray2(array: &array5)

        var array6 = [2,1]
        reorderArray2(array: &array6)
        
        var array7 = [Int]()
        reorderArray2(array: &array7)
        
        print(debug: "排序数组 reorderArray2:\(array4),array5:\(array5),array6:\(array6),array7:\(array7)")
    }
    
    // 将判断条件通过闭包传入
    func reorderArray(array:inout [Int],isTrueClosure: (Int) -> Bool) {
        guard array.count > 1 else {
            return
        }

        var beginIndex = 0
        var endIndex = array.count - 1
        
        while beginIndex < endIndex {
            var beginValue = array[beginIndex]
            
            // 直到查找到偶数
            while beginIndex < endIndex && isTrueClosure(beginValue) {
                beginValue = array[beginIndex]
                beginIndex = beginIndex + 1
            }
            beginIndex = max(beginIndex - 1, 0)
            
            // 直到查找到奇数
            var endvalue = array[endIndex]
            while beginIndex < endIndex && !isTrueClosure(endvalue) {
                endvalue = array[endIndex]
                endIndex = endIndex - 1
            }
            endIndex = min(array.count - 1, endIndex + 1)
            
            if beginIndex < endIndex {
                array[beginIndex] = endvalue
                array[endIndex] = beginValue
                
                if abs(endIndex - beginIndex) == 1 {
                    break
                }
            }
        }
    }
    /*
    使用辅助空间
     
     原来的数组保存的是奇数，新添一个数组保存偶数
    */
    func reorderArray2(array:inout [Int]){
        guard array.count > 1 else {
            return
        }
        
        var evenArr = [Int]()
        for val in array {
            if val % 2 == 0 {
                evenArr.append(val)
            }
        }
        
        array =  array.filter {!evenArr.contains($0)}
        array += evenArr
    }
}
