//
//  24_SquenceOfBSTViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/2/20.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题24：
输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历的结果。如果是则返回true，否则返回false。假设输入的数组的任意两个数字都互不相同。
*/
class _24_SquenceOfBSTViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstOrder = [5,7,6,9,11,10,8]
        let secondOrder = [7,4,6,5]
      
        let result = squenceOfBST(order:firstOrder)
        let result1 = squenceOfBST(order:secondOrder)
        print(debug: "第一个是否是:\(result ?"是":"否")，第二个是否是:\(result1 ?"是":"否")")
    }
    

    func squenceOfBST(order: [Int]?) -> Bool{
        guard let orderNode = order, !orderNode.isEmpty else {
            return false
        }
        
        let root = orderNode.last!
        
        // 左子节点的index
        var leftIndex = 0
        
        //二叉搜索树左子树的节点小于根节点
        while orderNode[leftIndex] < root {
            leftIndex += 1
        }
        
        //二叉搜索树右子树的节点大于根节点
        var rightIndex = leftIndex
        while rightIndex < orderNode.count {
            if orderNode[rightIndex] < root {
                return false
            }
            
            rightIndex += 1
        }
        
        var leftIsBST = true
        //判断左子树是否是二叉搜索树
        if leftIndex > 0 {
            let orderLeft = orderNode[0..<leftIndex]
            leftIsBST = squenceOfBST(order: Array(orderLeft))
        }
        
        var rightIsBST = true
        //判断右子树是否是二叉搜索树
        if leftIndex < orderNode.count - 1  {
            let orderLeft = orderNode[leftIndex..<(orderNode.count - 1)]
            rightIsBST = squenceOfBST(order: Array(orderLeft))
        }
        
        return leftIsBST && rightIsBST
    }
}
