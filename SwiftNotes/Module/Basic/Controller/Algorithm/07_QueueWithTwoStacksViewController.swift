//
//  07_QueueWithTwoStacksViewController.swift
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
面试题7：
用两个栈实现一个队列。队列的声明如下，请实现它的两个函数appendTail和deleteHead，分别完成在队列尾部插入结点和在队列头部删除结点的功能。
*/
class _7_QueueWithTwoStacksViewController: BaseViewController {
    /// 0->x 栈底到栈顶
    var stackIn:[Int] = [Int]()
    
    /// 0->x 栈底到栈顶
    var stackOut:[Int] = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        self.appendTail(2)
        self.appendTail(3)
        self.appendTail(4)
        self.deleteHead()
        self.appendTail(6)
        self.deleteHead()
        self.deleteHead()
        self.deleteHead()
        self.appendTail(12)
        self.deleteHead()
    }
    
    func appendTail(_ node:Int){
        stackIn.append(node)
    }
    
    
    func deleteHead(){
        if stackIn.count == 0 {
            stackOut.remove(at: stackOut.count - 1)
            return
        }
        
        if stackOut.count == 0 {
            for value in stackIn.enumerated().reversed() {
                stackIn.removeLast()
                
                if value.offset != 0 {
                    stackOut.append(value.element)
                }
            }
        }else{
            stackOut.removeLast()
        }
    }
}
