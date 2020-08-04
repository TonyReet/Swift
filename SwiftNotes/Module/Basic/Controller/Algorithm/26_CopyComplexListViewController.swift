//
//  26_CopyComplexListViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/2/22.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
 ==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:****
 ==================================================================
 面试题26：
 请实现函数ComplexListNode* Clone（ComplexListNode* pHead），复制一个复杂链表。在复杂链表中，每个结点除了有一个m_pNext指针指向下一个结点外，还有一个m_pSibling 指向链表中的任意结点或者NULL
 */
class _26_CopyComplexListViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nodeList1 = ComplexListNode(val: 1)
        let nodeList2 = ComplexListNode(val: 2)
        let nodeList3 = ComplexListNode(val: 3)
        nodeList1.next = nodeList2
        nodeList1.sibling = nodeList3
        
        nodeList2.next = nodeList3
        nodeList3.sibling = nodeList2
        
        let cloneList = clone(head: nodeList1)
        guard cloneList != nil else {
            return
        }
        
        print(debug: cloneList!)
    }
    
    func clone(head:ComplexListNode?) -> ComplexListNode? {
        guard head != nil else {
            return nil
        }
        
        var node = head
        
        while node != nil {
            let clone = ComplexListNode(val: node!.val)
            clone.next = node?.next
            node?.next = clone
            node = clone.next
        }
        
        node = head
        while node != nil {
            let pNode = node!.next
            pNode?.sibling = node?.sibling?.next
            node = pNode!.next
        }
        
        //拆分链表
        node = head
        let newHead:ComplexListNode = node!.next!
        var newNode:ComplexListNode? = newHead
        node = newHead.next
        
        while node != nil {
            newNode?.next = node?.next
            newNode = newNode?.next
            node?.next = newNode?.next
            node = node?.next
        }
        
        return newHead
    }
}

class ComplexListNode : Hashable{
    static func == (lhs: ComplexListNode, rhs: ComplexListNode) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    // Synthesized by compiler
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.val)
        if let next = self.next {
            hasher.combine(next)
        }
        if let sibling = self.sibling {
            hasher.combine(sibling);
        }
        
    }
    
    // Default implementation from protocol extension
    var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
    
    var val = 0
    var next:ComplexListNode?
    var sibling:ComplexListNode?
    
    init(val:Int) {
        self.val = val
    }
}

