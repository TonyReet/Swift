//
//  13_DeleteNodeInListViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/30.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题13：
给定单向链表的头指针和一个结点指针，定义一个函数在O（1）时间删除该结点
 
*/
class _13_DeleteNodeInListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var listNode:ListNode? = AlgorithmDataStructure.listNodeFrom([1, 2, 3, 4, 5, 6, 7, 8, 9])
        var beDelete:ListNode? = listNode?.next?.next
        deleteNode(pHead: &listNode, beDelete: &beDelete)
        
        var listNode1:ListNode? = AlgorithmDataStructure.listNodeFrom([1, 2, 3])
        var beDelete1:ListNode? = listNode1?.next?.next
        deleteNode(pHead: &listNode1, beDelete: &beDelete1)
        
        var listNode2:ListNode? = nil
        var beDelete2:ListNode? = nil
        deleteNode(pHead: &listNode2, beDelete: &beDelete2)
        
        print(debug: "第一个链表:\(String(describing: listNode)),第二个链表:\(String(describing: listNode1)),第三个链表:\(String(describing: listNode2))")
    }
    
    func deleteNode(pHead:inout ListNode?, beDelete:inout ListNode?){
        if pHead == nil ||  beDelete == nil {
            return
        }
        
        if pHead == beDelete{
            
            // 只有一个节点，头结点和删除的节点是同一个
            pHead = nil
        }else if let nextListNode = beDelete?.next {
            // 将next清空，当前接点改为Next节点
            
            beDelete?.val = nextListNode.val
            beDelete?.next = nextListNode.next
        }else {
            // 删除的节点是尾节点，没有下个节点，只有遍历删除
            var pNode :ListNode = pHead!
            
            while pNode.next != beDelete {
                pNode = pNode.next!
            }
            
            pNode.next = nil
            beDelete = nil
        }
    }
}
