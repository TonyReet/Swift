//
//  AlgorithmDataStructure.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/10.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

class AlgorithmDataStructure: NSObject {
    
    class func listNodeFrom(_ arr : [Int] ) -> ListNode {
        var head:ListNode? = nil
        var node:ListNode?
        
        for val in arr {
            if head == nil {
                head = ListNode(val)
                node = head!
            } else {
                let newNode = ListNode(val)
                node!.next = newNode
                node = newNode
            }
        }
        return head!
    }
    
    /// 前序遍历
    class func preOrder(_ binaryTree: BinaryTreeNode?){
        guard let binaryTree = binaryTree else {
            return
        }
        
        print(debug: binaryTree.val)
        preOrder(binaryTree.left)
        preOrder(binaryTree.right)
    }

    /*中序遍历*/
    class func inOrder(_ binaryTree: BinaryTreeNode?) {
        guard let binaryTree = binaryTree else {
            return
        }
        
        preOrder(binaryTree.left)
        print(debug: binaryTree.val)
        preOrder(binaryTree.right)
    }
}

extension String {
    subscript (i:Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

public class TreeNode: Equatable {
    var value:Int
    weak var parent:TreeNode?
    var childRen = [TreeNode]()
    init(value:Int,childRen child:[TreeNode]? = nil) {
        self.value = value
        guard let child = child else {
            return
        }
        
        self.childRen = child
    }
    
    func addChildren(_ node:TreeNode) {
        childRen.append(node)
        node.parent = self
    }
    
    public static func ==(lhs:TreeNode,rhs:TreeNode)->Bool {
        if lhs.value == rhs.value && lhs.childRen == rhs.childRen {
            return true
        }
        return false
    }
    
}

public class BinaryTreeNode: Equatable {
    var val:Int
    var left:BinaryTreeNode?
    var right:BinaryTreeNode?
    
    init(val:Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    init(val:Int, left: BinaryTreeNode, right: BinaryTreeNode) {
        self.val = val
        self.left = left
        self.right = right
    }
    
    public static func ==(lhs:BinaryTreeNode,rhs:BinaryTreeNode) -> Bool {
        guard lhs.val == rhs.val && lhs.left == rhs.left && lhs.right == rhs.right else {
            return false
        }
        return true
    }
}

public class ListNode :NSObject {
    public var val:Int
    public var next:ListNode?
    public init(_ val:Int) {
        self.val = val
        self.next =  nil
    }
    
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        let isValEqual = lhs.val == rhs.val
        let isNextEqual = lhs.next == rhs.next
        return isValEqual && isNextEqual
        
    }

    override public var description: String {
        if self.next == nil {
            return ""
        }
        
        var nodeString = "\(self.val)"
        
        var listNode = self
        while listNode.next != nil {
            let nextNode = listNode.next!
            nodeString.append("->\(nextNode.val)")

          listNode = listNode.next!
        }

        return nodeString
    }
}
