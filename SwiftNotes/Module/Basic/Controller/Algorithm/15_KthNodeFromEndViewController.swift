//
//  15_KthNodeFromEndViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/2/4.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题15：
输入一个链表，输出该链表中倒数第k个结点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾结点是倒数第1个结点。例如一个链表有6个结点，从头结点开始它们的值依次是1、2、3、4、5、6。
 
*/

class _15_KthNodeFromEndViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let listNode:ListNode? = AlgorithmDataStructure.listNodeFrom([1, 2, 3, 4, 5, 6, 7, 8, 9])
        let (_,findNum) = findKthToTail(pHead: listNode, kNum: 3)
        
        let listNode1:ListNode? = AlgorithmDataStructure.listNodeFrom([1, 2, 3])
        let (_,findNum1) = findKthToTail(pHead: listNode1, kNum: 0)
        
        let listNode2:ListNode? = nil
        let (_,findNum2) = findKthToTail(pHead: listNode2, kNum: 3)
        
        let listNode3:ListNode? = AlgorithmDataStructure.listNodeFrom([1, 2, 3])
        let (_,findNum3) = findKthToTail(pHead: listNode3, kNum: 4)
        
        print(debug: "第一个数字:\(findNum)，第二个数字:\(findNum1)，第三个数字:\(findNum2)，第四个数字:\(findNum3)")
    }
    

    func findKthToTail(pHead: ListNode?,kNum:Int) -> (Bool,Int){
        guard pHead != nil && kNum != 0 else {
            return (false, 0)
        }
        
        var pFirstNode = pHead
        var pSecondNode = pHead
        
        var index = 0
        while index < kNum - 1 && (pFirstNode?.next != nil){
            pFirstNode = pFirstNode?.next
            index = index + 1
        }
        
        if index != kNum - 1 {
            print(debug: "链表长度没有kNum:\(kNum)")
            return (false,0)
        }
        
        while pFirstNode?.next != nil {
            pFirstNode = pFirstNode?.next
            pSecondNode = pSecondNode?.next
        }
        
        guard let kNumVal = pSecondNode?.val else {
            return (false, 0)
        }
        
        return (true, kNumVal)
    }
    
}
