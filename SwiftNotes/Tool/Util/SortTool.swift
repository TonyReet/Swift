//
//  SortTool.swift
//  SwiftNotes
//
//  Created by tonyreet on 2020/2/24.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

class SortTool: NSObject {
    class func quickSort(data:inout [Int],low:Int,high:Int) -> Void {
        if low > high {
            return
        }
        let sortIndex = partition(data: &data, low: low, high: high)
        quickSort(data: &data, low: low, high: sortIndex-1)
        quickSort(data: &data, low: sortIndex+1, high: high)
    }
    
    
    private class func partition( data:inout [Int],low:Int,high:Int) -> Int {
        
        let root = data[high]
        var lowIndex = low
        for index in low...high {
            if data[index] < root {
                if index != lowIndex {
                    data.swapAt(index, lowIndex)
                }
                lowIndex = lowIndex+1
            }
        }
        
        if high != lowIndex {
            data.swapAt(high, lowIndex)
        }
        return lowIndex
    }
}
