//
//  16_ReverseListViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/2/6.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题16：
定义一个函数，输入一个链表的头结点，反转该链表并输出反转后链表的头结点。
 
*/

class _16_ReverseListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let listNode:ListNode? = AlgorithmDataStructure.listNodeFrom([1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        let listReverse = reverseList(pHead: listNode)
        print(debug: "反转以后的链表:\(String(describing: listReverse))")
        
        let listReverseRecursion = reverseListRecursion(pHead: listReverse)
        print(debug: "再次反转以后的链表:\(String(describing: listReverseRecursion))")
    }
    
    /*
    输入一个链表，反转链表后，输出链表的所有元素。
    
    pNext = pNode->next;        //  保存其下一个节点
    pNode->next = pPrev;        //  指针指向反转
    // 下面开始指针的后移
    pPrev = pNode;              //  保存前一个指针
    pNode = pNext;              //  递增指针, 指向下一个结点
    
    
    #三指针滑动pPrev -> pNode -> pNext;
    
    A->B->C->D
    pre: A cur:B next:C
    pre = cur
    cur = cur.next
    next = cur.next
    cur->next = pre

    */
    func reverseList(pHead: ListNode?) -> ListNode? {
        // pHead为nil，pHead不需要反转
        guard pHead != nil , pHead?.next != nil else {
            return pHead
        }
        
        var pNode:ListNode? = pHead
        var pReverseHead: ListNode? = nil
        var pPreNode:ListNode? = nil
        while pNode != nil {
            let pNextNode = pNode!.next

            // 尾部
            if pNextNode == nil {
                pReverseHead = pNode
            }

            // 指向上一个
            pNode?.next = pPreNode

            // 上一个指向node
            pPreNode = pNode

            // node指向next
            pNode = pNextNode
        }
        return pReverseHead
    }
    
    /// 递归
    func reverseListRecursion(pHead: ListNode?) -> ListNode? {
        // pHead为nil，pHead不需要反转
        guard pHead != nil , pHead?.next != nil else {
            return pHead
        }
        
        let pReverseHead = reverseListRecursion(pHead: pHead?.next)
        
        //再将当前节点设置为后面节点的后续节点
        pHead?.next?.next = pHead
        pHead?.next = nil
        
        return pReverseHead
    }
}
