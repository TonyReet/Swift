//
//  05_PrintListReversinglyIteratively.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/10.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题5：
输入一个链表的头结点，从尾到头反过来打印出每个结点的值。
*/

class _5_PrintListReversinglyIterativelyViewController: BaseViewController {
    override func viewDidLoad() {
        let listNode =  AlgorithmDataStructure.listNodeFrom([1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        let listNodeArray = printListReversinglyIteratively(listNode)
        
        listNodeArray?.forEach{
            print(debug: $0.val)
        }
    }
    

    
    func printListReversinglyIteratively(_ head: ListNode?)->Array<ListNode>?{
        guard var listNode = head else {
            return nil
        }
  
        var listNodeArray:Array<ListNode> = [listNode]
        while listNode.next != nil {
            listNodeArray.insert(listNode.next!, at: 0)
            
            listNode = listNode.next!
        }
        
        return listNodeArray
    }
}
