//
//  19_MirrorOfBinaryTreeViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/4/24.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题19：
请完成一个函数，输入一个二叉树，该函数输出它的镜像。
 
 操作给定的二叉树，将其变换为源二叉树的镜像。
 
 二叉树的镜像定义：源二叉树  8       镜像：   8
                       /   \           /   \
                      6     10        10     6
                    /   \   /  \     /   \   /  \
                    5   7  9   11   11   9  7    5
*/
class _19_MirrorOfBinaryTreeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let preOrder = [8,6,5,7,10,9,11]
        let inOrder = [5,6,7,8,9,10,11]
        let binaryTreeNode =  _6_ConstructBinaryTreeViewController.constructBinaryTree(preOrder: preOrder, inOrder: inOrder)
        
        AlgorithmDataStructure.preOrder(binaryTreeNode)
        
        let mirrorBinaryTreeNode = mirrorRecursively(treeNode: binaryTreeNode)
        
        AlgorithmDataStructure.preOrder(mirrorBinaryTreeNode)
    }

    func mirrorRecursively(treeNode: BinaryTreeNode?) -> BinaryTreeNode? {
        if (treeNode == nil) {
            return nil
        }
        
        let mirrorTreeNode = treeNode
        swap(&mirrorTreeNode!.left, &mirrorTreeNode!.right)
        
        mirrorTreeNode?.left = mirrorRecursively(treeNode: mirrorTreeNode?.left)
        mirrorTreeNode?.right = mirrorRecursively(treeNode: mirrorTreeNode?.right)
        
        return mirrorTreeNode
    }
}
