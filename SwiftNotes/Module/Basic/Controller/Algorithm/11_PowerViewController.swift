//
//  11_PowerViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/23.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
 《剑指Offer:名企面试官精讲典型编程题》代码
==================================================================
面试题11：
实现函数double Power（double base, int exponent），求base的exponent次方。不得使用库函数，同时不需要考虑大数问题。
 
*/
class _11_PowerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(debug: "指数值为:\(power(2, exponent: 10))")
    }
    

    func power(_ base: Double, exponent: Int)-> Double{
        if exponent == 0 {
            return Double(1)
        }else if exponent == 1{
            return base
        }
        
        if exponent < 0 && (base - 0.0) < .ulpOfOne {
            print("指数<0的时候，底数不应该为0")
            return 0.0
        }
        
        var powerNormalNum = 0.0
        if exponent > 1 {
            powerNormalNum = powerNormal(base, exponent: exponent)
        }else {
            powerNormalNum = 1/powerNormal(base, exponent: exponent)
        }
        
        let powerNormalRecursion = powerRecursion(base, exponent: exponent)
        
        print(debug: "普通解法:\(powerNormalNum),递归解法:\(powerNormalRecursion)")
        
        return powerNormalNum
    }
        
    func powerNormal(_ base: Double, exponent: Int)-> Double{
        var result = 1.0
        for _ in 0...exponent {
            result = result * base
        }
        
        return result
    }
    
    func powerRecursion(_ base: Double, exponent: Int)-> Double{
        if (exponent == 1){
            return base
        }
        
        var result = powerRecursion(base, exponent: exponent >> 2)
        result = result * result
        
        ///如果为基数，则还要乘以base
        if (exponent & 0x01) > 0 {
            result = result * base
        }
        
        return result
    }
}
