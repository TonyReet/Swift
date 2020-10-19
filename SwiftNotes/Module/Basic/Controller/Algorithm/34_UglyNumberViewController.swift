//
//  34_UglyNumberViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/10/19.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*
==================================================================
《剑指Offer:名企面试官精讲典型编程题》代码   理解难度:****
==================================================================
面试题34：
我们把只包含因子2、3和5的数称作丑数（Ugly Number）。求按从小到大的顺序的第1500个丑数。例如6、8都是丑数，但14不是，因为它包含因子7。习惯上我们把1当做第一个丑数。

*/


class _34_UglyNumberViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let indexUglyNum = getUglyNumber(index: 1500)
        
        print(debug: "第\(indexUglyNum)个丑数:\(indexUglyNum)")
    }
    

    func getUglyNumber(index:UInt) -> UInt {
        guard index > 0 else{
            return 0
        }
        
        var uglyNumbers:[UInt] = [UInt](repeating: 0, count: Int(index))
        
        // 第一个丑数1
        uglyNumbers[0] = 1
        
        var nextUglyIndex = 1
        var (p2,p3,p5) = (0,0,0)
        
        while nextUglyIndex < index  {
            // 取最小值
            let minV = min(uglyNumbers[p2] * 2, uglyNumbers[p3] * 3, uglyNumbers[p5] * 5)

            // 如果小于最小值，完后移一位
            while uglyNumbers[p2] * 2 <= minV {
                p2 += 1
            }
            
            // 如果小于最小值，完后移一位
            while uglyNumbers[p3] * 3 <= minV {
                p3 += 1
            }
            
            // 如果小于最小值，完后移一位
            while uglyNumbers[p5] * 5 <= minV {
                p5 += 1
            }
            
            uglyNumbers[nextUglyIndex] = minV
            nextUglyIndex += 1
        }
        
        return uglyNumbers[nextUglyIndex - 1]
    }

}
