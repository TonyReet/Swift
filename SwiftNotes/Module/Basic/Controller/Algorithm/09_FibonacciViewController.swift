//
//  09_FibonacciViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/17.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题9：
写一个函数，输入n，求斐波那契（Fibonacci）数列的第n项。
 
           /  0                          n=0
 f(n)=        1                          n=1
           \  f(n-1)+f(n-2)               n>1
 
*/
class _9_FibonacciViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 普通的斐波那契函数
        fibonacci(10)
        
        /// 青蛙普通跳
        frogJump(10)
        
        /// 青蛙高级跳法
        frogAdvancedJump(10)
    }

    
    func fibonacci(_ num: Int){
        
        print(debug: "斐波那契递归调用:\(fibonacciRecursion(num))")
        
        print(debug: "斐波那契循环for调用:\(fibonacciForCycle(num))")
        
        print(debug: "斐波那契循环while调用:\(fibonacciWhileCycle(num))")
    }
        
    func fibonacciRecursion(_ num: Int) -> Int{
        
        if num == 0 || num == 1 {
            return num
        }
        
        let fibonacciNum = fibonacciRecursion(num - 1) + fibonacciRecursion(num - 2)
        
        return fibonacciNum
    }
    
    func fibonacciForCycle(_ num: Int) -> Int{
        
        if num == 0 || num == 1 {
            return num
        }
        
        var fibonacciNumOne: Int = 1
        var fibonacciNumTwo: Int = 0
        var fibonacciNumFinal: Int = 0
        for _ in 2...num {
            
            fibonacciNumFinal = fibonacciNumOne + fibonacciNumTwo
            fibonacciNumTwo = fibonacciNumOne
            fibonacciNumOne = fibonacciNumFinal
        }
        
        
        return fibonacciNumFinal
    }
    
    func fibonacciWhileCycle(_ num: Int) -> Int{
        
        if num == 0 || num == 1 {
            return num
        }
        
        var fibonacciNumOne: Int = 0
        var fibonacciNumTwo: Int = 1
        var fibonacciNumFinal: Int = 0
        var index = 2
        
        while index <= num {
            fibonacciNumFinal = fibonacciNumOne + fibonacciNumTwo
            fibonacciNumOne = fibonacciNumTwo
            fibonacciNumTwo = fibonacciNumFinal
            
            index = index + 1
        }
        
        
        return fibonacciNumFinal
    }
}

/// 一个台阶总共有n级，如果一次可以跳1级，也可以跳2级。求总共有多少总跳法，并分析算法的时间复杂度。
/*
 
           /  1                          n=1
 f(n)=        2                          n=2
           \  f(n-1)+(f-2)               n>2
 */
extension _9_FibonacciViewController {
    func frogJump(_ num: Int){
        
        print(debug: "跳青蛙递归调用:\(frogJumpRecursion(num))")
        
        print(debug: "跳青蛙for调用:\(frogJumpForCycle(num))")
        
        print(debug: "跳青蛙while调用:\(frogJumpWhileCycle(num))")
    }
        
    func frogJumpRecursion(_ num: Int) -> Int{
        if num <= 2{
            return num
        }
        
        let fibonacciNum = frogJumpRecursion(num - 1) + frogJumpRecursion(num - 2)
        
        return fibonacciNum
    }
    
    func frogJumpForCycle(_ num: Int) -> Int{
        
        if num <= 2 {
            return num
        }
        
        var fibonacciNumOne: Int = 2
        var fibonacciNumTwo: Int = 1
        var fibonacciNumFinal: Int = 0
        for _ in 3...num {
            
            fibonacciNumFinal = fibonacciNumOne + fibonacciNumTwo
            fibonacciNumTwo = fibonacciNumOne
            fibonacciNumOne = fibonacciNumFinal
        }
        
        
        return fibonacciNumFinal
    }
    
    func frogJumpWhileCycle(_ num: Int) -> Int{
        
        if num <= 2 {
            return num
        }
        
        var fibonacciNumOne: Int = 1
        var fibonacciNumTwo: Int = 2
        var fibonacciNumFinal: Int = 0
        var index = 3
        
        while index <= num {
            fibonacciNumFinal = fibonacciNumOne + fibonacciNumTwo
            fibonacciNumOne = fibonacciNumTwo
            fibonacciNumTwo = fibonacciNumFinal
            
            index = index + 1
        }
        
        
        return fibonacciNumFinal
    }
}

/// 如果青蛙可以一次跳 1 级，也可以一次跳 2 级，一次跳 3 级，…，一次跳 n 级。问要跳上第 n 级台阶有多少种跳法？
/*

          /  1                          n=0
f(n)=        1                          n=1
          \  2*f(n-1)                   n>2
*/
extension _9_FibonacciViewController {
    func frogAdvancedJump(_ num: Int){
        
        print(debug: "高级跳青蛙递归调用:\(frogAdvancedJumpRecursion(num))")
        
        print(debug: "高级跳青蛙循环for调用:\(frogAdvancedJumpForCycle(num))")
        
        print(debug: "高级跳青蛙循环while调用:\(frogAdvancedJumpWhileCycle(num))")
    }
        
    func frogAdvancedJumpRecursion(_ num: Int) -> Int{
        if num <= 1 {
            return 1
        }
        
        let fibonacciNum = 2*frogAdvancedJumpRecursion(num - 1)
        
        return fibonacciNum
    }
    
    func frogAdvancedJumpForCycle(_ num: Int) -> Int{
        
        if num <= 1 {
            return 1
        }
        
        var fibonacciNumOne: Int = 1
        var fibonacciNumFinal: Int = 0
        for _ in 2...num {
            fibonacciNumFinal = 2*fibonacciNumOne
            fibonacciNumOne = fibonacciNumFinal
        }
        
        return fibonacciNumFinal
    }
    
    func frogAdvancedJumpWhileCycle(_ num: Int) -> Int{
        
        if num <= 1 {
            return 1
        }
        
        var fibonacciNumOne: Int = 1
        var fibonacciNumFinal: Int = 0
        var index = 2
        
        while index <= num {
            fibonacciNumFinal = 2*fibonacciNumOne
            fibonacciNumOne = fibonacciNumFinal
            
            index = index + 1
        }
        
        
        return fibonacciNumFinal
    }
}
