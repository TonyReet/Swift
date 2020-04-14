//
//  18_SubstructureInTreeViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/2/10.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题18：
 输入两颗二叉树A，B，判断B是不是A的子结构。
 
 二叉树的镜像定义：源二叉树  8       子数：    6
                       /   \           /   \
                      6     10        5     7
                    /   \   /  \
                    5   7  9   11
*/
class _18_SubstructureInTreeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let preOrder = [8,6,5,7,10,9,11]
        let inOrder = [5,6,7,8,9,10,11]
        let pRoot1 =  _6_ConstructBinaryTreeViewController.constructBinaryTree(preOrder: preOrder, inOrder: inOrder)
  
        let pRoot2 = BinaryTreeNode(val: 6, left: BinaryTreeNode(val: 5), right: BinaryTreeNode(val: 7))
        
        let result = hasSubstree(pRoot1: pRoot1, pRoot2: pRoot2)
        
        print(debug: "是否是子结构:\(result)")
    }
    

    func hasSubstree(pRoot1: BinaryTreeNode?,pRoot2:BinaryTreeNode?) -> Bool {
        var result = false
        
        if (pRoot1 == nil || pRoot2 == nil) {return result}
        
        if (pRoot1?.val == pRoot2?.val){
            result = doesTree1HasTree2(pTree1: pRoot1, pTree2: pRoot2)
        }
        
        if (result == false){
            result = hasSubstree(pRoot1: pRoot1?.left, pRoot2: pRoot2)
        }
        
        if (result == false){
            result = hasSubstree(pRoot1: pRoot1?.right, pRoot2: pRoot2)
        }
        
        return result
    }
    
    func doesTree1HasTree2(pTree1:BinaryTreeNode?,pTree2:BinaryTreeNode?) -> Bool {
        if (pTree2 == nil){return true}
        
        if (pTree1 == nil){return false}
        
        if (pTree1?.val != pTree2?.val) {return false}
        
        return doesTree1HasTree2(pTree1: pTree1?.left, pTree2: pTree2?.left) && doesTree1HasTree2(pTree1: pTree1?.right, pTree2: pTree2?.right)
        
    }
}
