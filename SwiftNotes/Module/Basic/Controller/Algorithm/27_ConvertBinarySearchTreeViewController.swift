//
//  27_ConvertBinarySearchTreeViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/2/24.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:****
==================================================================
面试题27：
输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的双向链表。要求不能创建任何新的结点，只能调整树中结点指针的指向。
*/
class _27_ConvertBinarySearchTreeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let preOrder = [10,6,4,8,14,12,16]
        let inOrder = [4,6,8,10,12,14,16]
        let binaryTreeNode =  _6_ConstructBinaryTreeViewController.constructBinaryTree(preOrder: preOrder, inOrder: inOrder)
        
        let convertBTN = convert(binaryTree: binaryTreeNode)
        print(debug: "转换后的树：\(String(describing: convertBTN))")
    }
    
    func convert(binaryTree:BinaryTreeNode?) -> BinaryTreeNode? {
        guard let binaryTreeNode = binaryTree else {
            return nil
        }
        
        //转换好的链表的最后一个结点
        var lastNodeInList:BinaryTreeNode? = nil
        convertNode(node: binaryTreeNode, lastNodeInList: &lastNodeInList)
        
        //从最后的节点往前查找，查找到最前面的节点
        var pHeadOfList = lastNodeInList
        while pHeadOfList != nil && pHeadOfList?.left != nil {
            pHeadOfList = pHeadOfList?.left
        }
        
        return pHeadOfList
    }

    func convertNode(node:BinaryTreeNode?,lastNodeInList:inout BinaryTreeNode?){
        if node == nil {
            return
        }
        
        let pCurrentNode = node!
        if pCurrentNode.left != nil {
            convertNode(node: pCurrentNode.left, lastNodeInList: &lastNodeInList)
        }
        
        //最后的节点指向当前节点
        pCurrentNode.left = lastNodeInList
        
        //将最后的节点的子节点(右节点)指向当前节点
        if lastNodeInList != nil {
            lastNodeInList!.right = pCurrentNode
        }
        
        //连接右子树
        lastNodeInList = pCurrentNode
        if pCurrentNode.right != nil {
            convertNode(node: pCurrentNode.right, lastNodeInList: &lastNodeInList)
        }

    }
}
