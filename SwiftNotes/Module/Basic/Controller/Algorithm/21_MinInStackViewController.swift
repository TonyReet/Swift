//
//  21_MinInStackViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/5/14.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码    理解难度:****
==================================================================
面试题21：
定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的min函数。在该栈中，调用min、push及pop的时间复杂度都是O（1)。
*/

class _21_MinInStackViewController: BaseViewController {
    var dataStack = [Int]()//数据栈
    var minStack = [Int]()//最小栈
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        push(element: 3)
        push(element: 4)
        push(element: 2)
        push(element: 1)
        pop()
        pop()
        push(element: 0)
        
        print(debug: "dataStack:\(dataStack),minStack:\(minStack)")
    }
    
    
    func push(element:Int) {
        dataStack.insert(element, at: dataStack.count)
        
        let minElement = Swift.min(element, minStack.last ?? element)
        minStack.insert(minElement, at: minStack.count)
    }
    
    func pop() {
        guard !dataStack.isEmpty && !minStack.isEmpty else {
            return
        }
        
        dataStack.removeLast()
        minStack.removeLast()
    }

    func min() -> Int {
        if (minStack.isEmpty){
            return 0
        }
        
        return minStack.last ?? 0
    }
}
