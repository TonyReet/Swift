//
//  25_PathInTreeViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/2/21.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
 ==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:***
 ==================================================================
 面试题25：
 输入一棵二叉树和一个整数，打印出二叉树中结点值的和为输入整数的所有路径。从树的根结点开始往下一直到叶结点所经过的结点形成一条路径。
 */
class _25_PathInTreeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preOrder = [10,5,4,7,12]
        let inOrder = [4,5,7,10,12]
        let binaryTreeNode =  _6_ConstructBinaryTreeViewController.constructBinaryTree(preOrder: preOrder, inOrder: inOrder)

        findPath(binaryTree: binaryTreeNode, expectedSum: 22)
    }
    
    func findPath(binaryTree: BinaryTreeNode?, expectedSum: Int) {
        guard let binaryTreeNode = binaryTree else {
            return
        }
        
        // 创建一个链表，用于存放根结点到当前处理结点的所经过的结
        var listNode = [Int]()
        
        findPathAuxiliary(binaryTree: binaryTreeNode,curNum: 0, expectedSum: expectedSum, result: &listNode)
    }
    
    func findPathAuxiliary(binaryTree: BinaryTreeNode ,curNum: Int, expectedSum: Int, result: inout Array<Int>) {
        
        // 加上当前结点的值
        let currentSum = curNum + binaryTree.val
        
        // 将当前结点入队
        result.append(binaryTree.val)
        
        // 如果当前结点的值小于期望的和
        if (currentSum < expectedSum) {
            
            // 递归处理左子树
            if let btLeft = binaryTree.left {
                findPathAuxiliary(binaryTree: btLeft,curNum: currentSum, expectedSum: expectedSum, result: &result)
            }
            
            // 递归处理右子树
            if let btRight = binaryTree.right {
                findPathAuxiliary(binaryTree: btRight,curNum: currentSum, expectedSum: expectedSum, result: &result)
            }
        }else if (currentSum == expectedSum) {// 如果当前和与期望的和相等
            // 当前结点是叶结点，则输出结果
            if binaryTree.left == nil && binaryTree.right == nil {
                print(debug: "\(result)")
            }
        }
        
        // 大于，直接移除当前结点
        result.removeLast()
    }
}
