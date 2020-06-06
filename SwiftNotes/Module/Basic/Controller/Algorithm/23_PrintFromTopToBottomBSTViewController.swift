//
//  23_PrintFromTopToBottomBSTViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/6/6.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题23：
从上往下打印出二叉树的每个结点，同一层的结点按照从左到右的顺序打印。例如输入图4.5中的二叉树，则依次打印出8、6、10、5、7、9、11。

 二叉树  8
      /   \
    6      10
  /   \   /  \
  5   7  9   11
*/
class _23_PrintFromTopToBottomBSTViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let preOrder = [8,6,5,7,10,9,11]
        let inOrder = [5,6,7,8,9,10,11]
        let binaryTreeNode =  _6_ConstructBinaryTreeViewController.constructBinaryTree(preOrder: preOrder, inOrder: inOrder)
     
        printFromTopToBottom(binaryTreeNode: binaryTreeNode)
    }
    

    func printFromTopToBottom(binaryTreeNode: BinaryTreeNode?){
        guard let binaryTree = binaryTreeNode else {
            return
        }
        
        var queue:[BinaryTreeNode] = [binaryTree]
        
        while !queue.isEmpty {
            let node:BinaryTreeNode = queue.first!
            queue.removeFirst()
            
            print(node.val, terminator: ",")
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
}
