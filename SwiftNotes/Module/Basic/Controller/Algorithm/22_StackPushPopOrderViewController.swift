//
//  22_StackPushPopOrderViewController.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/6/4.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题22：
输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是否为该栈的弹出顺序。假设压入栈的所有数字均不相等。例如序列1、2、3、4、5是某栈的压栈序列，序列4、5、3、2、1是该压栈序列对应的一个弹出序列，但4、3、5、1、2就不可能是该压栈序列的弹出序列。
*/
class _22_StackPushPopOrderViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var result = false
        let pushStack = [1,2,3,4,5]
        let popStack = [4,5,3,2,1]
        result = isPopOrder(pushStack: pushStack, popStack: popStack)
        
        print(debug: "是否包含:\(result ? "是":"否")")
        let pushStack2 = [1,2,3,4,5]
        let popStack2 = [4,3,5,1,2]
        result = isPopOrder(pushStack: pushStack2, popStack: popStack2)
        
        print(debug: "是否包含:\(result ? "是":"否")")
    }
    

    func isPopOrder(pushStack: [Int], popStack: [Int]) -> Bool {
        guard !pushStack.isEmpty && !popStack.isEmpty else {
            return false
        }
        
        var auxiliaryStack = [Int]()
        var push = 0
        var pop = 0
        
        while push <= pushStack.count && pop < popStack.count {
            if !auxiliaryStack.isEmpty && auxiliaryStack.first == popStack[pop] {
                auxiliaryStack.removeFirst()
                pop += 1
            }else if push < pushStack.count  {
                auxiliaryStack.insert(pushStack[push], at: 0)
                push += 1
            }else {
                break
            }
        }
        
        return auxiliaryStack.isEmpty
    }
}
