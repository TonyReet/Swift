//
//  06_ConstructBinaryTreeViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/10.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题6：
输入某二叉树的前序遍历和中序遍历的结果，请重建出该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。例如输入前序遍历序列{1,2,4,7,3,5,6,8}和中序遍历序列{4,7,2,1,5,3,8,6}，则重建出图2.6所示的二叉树并输出它的头结点。
*/
class _6_ConstructBinaryTreeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let preOrder = [1,2,4,7,3,5,6,8]
        let inOrder = [4,7,2,1,5,3,8,6]
        let binaryTreeNode = constructBinaryTree(preOrder: preOrder, inOrder: inOrder)
        
        AlgorithmDataStructure.preOrder(binaryTreeNode)
    }
    
    func constructBinaryTree(preOrder:[Int],inOrder:[Int]) -> BinaryTreeNode? {
        return _6_ConstructBinaryTreeViewController.constructBinaryTree(preOrder: preOrder, inOrder: inOrder)
    }
    
    class func constructBinaryTree(preOrder:[Int],inOrder:[Int]) -> BinaryTreeNode? {
        guard preOrder.count != 0, preOrder.count == inOrder.count else {
          return nil
        }

        guard let firstRoot = preOrder.first else {
            return nil
        }
        
        let binaryTree = BinaryTreeNode(val: firstRoot)
        
        /// 确定中序的根节点位置
        var inRootIndex = 0
        for value in inOrder {
            if value == firstRoot {
                break
            }
            
            inRootIndex += 1
        }
        
        var preOrderLeft:[Int] = []
        var preOrderRight:[Int] = []
        var inOrderLeft:[Int] = []
        var inOrderRight:[Int] = []
        
        let orderCount = preOrder.count
        var searchIndex = 0
        while searchIndex < orderCount{
            if searchIndex < inRootIndex {
                preOrderLeft.append(preOrder[searchIndex + 1])
                inOrderLeft.append(inOrder[searchIndex])
            }else if searchIndex > inRootIndex {
                preOrderRight.append(preOrder[searchIndex])
                inOrderRight.append(inOrder[searchIndex])
            }
            
            searchIndex += 1
        }
        
        binaryTree.left = constructBinaryTree(preOrder: preOrderLeft, inOrder: inOrderLeft)
        binaryTree.right = constructBinaryTree(preOrder: preOrderRight, inOrder: inOrderRight)
        
        return binaryTree
    }
}
