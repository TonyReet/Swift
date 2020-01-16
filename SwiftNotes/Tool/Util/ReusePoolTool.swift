//
//  ReusePoolTool.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/10.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

class ReusePoolTool: NSObject {
    var waitUseQueue = NSMutableSet()
    
    var usingQueue = NSMutableSet()
    
    // 从重用池当中取出一个可重用
    func dequeueReusableView() -> UIView? {
        let useView = waitUseQueue.anyObject()
        guard let noNilUseView = useView as? UIView else {
            return nil
        }
        
        waitUseQueue.remove(noNilUseView)
        usingQueue.add(noNilUseView)
        
        return noNilUseView
    }
    
    // 向重用池当中添加一个视图
    func addUsingView(_ view: UIView?){
        guard let addView = view else {
            return
        }
        
        usingQueue.add(addView)
    }
    
    // 重置方法，将当前使用中的视图移动到可重用队列当中
    func reset(){
        usingQueue.enumerateObjects(options: .reverse) { (object, stop) in
            usingQueue.remove(object)
            waitUseQueue.add(object)
        }
    }
}
