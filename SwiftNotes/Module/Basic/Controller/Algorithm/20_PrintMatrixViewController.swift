//
//  20_PrintMatrixViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/4/29.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
 ==================================================================
  《剑指Offer:名企面试官精讲典型编程题》代码    理解难度:****
 ==================================================================
 面试题20：
 输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字，
 
 例如， 如果输入如下矩阵：
 
 1   2   3   4
 5   6   7   8
 9  10  11  12
 13  14  15  16
 
 则依次打印出数字
 
 1,2,3,4, 8,12,16,15,14,13,9,5, 6,7,11,10
 */

class _20_PrintMatrixViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let matrix = [
            [1,2,3,4],
            [5,6,7,8],
            [9,10,11,12],
            [13,14,15,16]
        ]
        
        printMatrix(matrix)
    }
    
    
    func printMatrix(_ matrix:[[Int]]) {
        guard matrix.count > 0 && matrix.first?.count ?? 0 > 0 else {
            print("The matrix should not be empty")
            return
        }
        
        var start = 0
        let rows = matrix.count
        let columns = matrix.first!.count
        
        while rows > start * 2 && columns > start * 2 {
            printMatrixInCicrcle(num: matrix, columns: columns, rows: rows, start: start)
            start += 1
        }
        
    }
    
    func printMatrixInCicrcle(num:[[Int]],columns:Int,rows:Int,start:Int) {
        let endX = columns - 1 - start
        let endY = rows - 1 - start
        
        //从左到右打印一行,这步是肯定有的
        var i = start
        while i <= endX {
            print(num[start][i])
            i += 1
        }
        
        //从上到下，需要判断条件，只有一个数字的时候，不需要第二步
        if start < endY {
            i = start  + 1
            while i <= endY {
                print(num[i][endX])
                i += 1
            }
        }
        
        //从右到左，需要判断条件，只有一行
        if start < endX &&  start < endY {
            i = endX - 1
            while i >= start {
                print(num[endY][i])
                i -= 1
            }
        }
        
        //从下到上，需要判断条件，至少有三行两列
        if start < endX && start < endY - 1{
            i = endY - 1
            while i > start {
                print(num[i][start])
                i -= 1
            }
        }
    }
}
