//
//  17_MergeListViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/2/8.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题17：
输入两个递增排序的链表，合并这两个链表并使新链表中的结点仍然是按照递增排序的。例如输入图3.7中的链表1和链表2，则合并之后的升序链表如链表3所示。
 
 样例输入
 
 1 3 5 7 9 2 4
 
 样例输出
 
 1 2 3 4 5 7 9
 
 思路是，先判断l1.l2是否空，空就返回另一个
 先存储头部较小节点
 使用cur 节点去同事遍历两个链表，把较小的串到cur上并修改cur，
 串上剩余的节点
*/
class _17_MergeSortedListsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let listNode1:ListNode? = AlgorithmDataStructure.listNodeFrom([1,3,5,7,9])
        let listNode2:ListNode? = AlgorithmDataStructure.listNodeFrom([1,3,5,7,9])
        
        let mergeListNode:ListNode? = mergeList(listNode1: listNode1, listNode2: listNode2)
        
        print(debug: "循环合并后的节点:\(String(describing: mergeListNode))")
        
        let listNode3:ListNode? = AlgorithmDataStructure.listNodeFrom([1,3,5,7,9])
        let listNode4:ListNode? = AlgorithmDataStructure.listNodeFrom([1,3,5,7,9])
        let mergeRecursionListNode:ListNode? = mergeListRecursion(listNode1: listNode3, listNode2: listNode4)
        
        print(debug: "递归合并后的节点:\(String(describing: mergeRecursionListNode))")
    }
   
    func mergeList(listNode1: ListNode?, listNode2: ListNode?) -> ListNode? {
        if listNode1 == nil  {
            return listNode2
        }

        if listNode2 == nil {
            return listNode1
        }

    
        var l1 = listNode1
        var l2 = listNode2

        var head: ListNode!
        var curentNode:ListNode!
        if l1!.val < l2!.val {
            head = l1!

            l1 = l1?.next
        }else {
            head = l2!

            l2 = l2?.next
        }

        curentNode = head
        while l1 != nil && l2 != nil {
            if l1!.val < l2!.val {
                curentNode.next = l1
        
                l1 = l1!.next
            } else {
                curentNode.next = l2

                l2 = l2!.next
            }
            
            curentNode = curentNode.next
        }

        if l1 == nil {
            curentNode.next = l2
        }

        if l2 == nil {
            curentNode.next = l1
        }

        return head
    }
    
    func mergeListRecursion(listNode1 list1: ListNode?, listNode2 list2: ListNode?) -> ListNode? {

        if(list1 == nil) {
            return list2
        }
        
        if(list2 == nil) {
            return list1
        }

        var head:ListNode?

        if list1!.val <= list2!.val{
            head = list1!
            head?.next = mergeListRecursion(listNode1:list1?.next,listNode2:list2)
        }
        else{
            head = list2!
            head?.next = mergeListRecursion(listNode1:list2?.next,listNode2:list1)
        }

        return head;
    }
}
