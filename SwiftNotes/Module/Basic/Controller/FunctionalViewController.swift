//
//  FunctionalViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/11/7.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit
import Foundation

/// 代码摘自《Swifter - Swift 必备 Tips》 (第四版)

class FunctionalViewController: BaseViewController {
    var foo = "foo"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Currying
        functionalCurrying()

        /// sequence
        functionalSequence()

        /// tuple
        functionalTuple()

        /// escaping
        functionalEscaping()

}

/// Currying
extension FunctionalViewController {
    func functionalCurrying() {
        
        let resutl0One = addTo(2)
        let resutl01ne = resutl0One(6)
        
        print(debug: "functionalCurrying_one:result:\(resutl01ne)")
        
        let greaterThan10 = greaterThan(10);

        let resutl1One = greaterThan10(13)
        let resutl2One = greaterThan10(9)
        
        print(debug: "functionalCurrying_two:resutl1One:\(String(describing: resutl1One)),resutl2One:\(resutl2One)")
    }
    
    func addTo(_ adder: Int) -> (Int) -> Int {
        return {
            // num回传function的参数
            num in
            return num + adder
        }
    }
    
    func greaterThan(_ comparer: Int) -> (Int) -> Bool {
    
        // $0回传闭包的参数
        return {$0 > comparer }
    }
}

///Sequence
extension FunctionalViewController {
    func functionalSequence(){
        let arr = [1,2,3,4,5]
        
        for i in ReverseSequence.init(array: arr) {
            print(i)
        }
    }
}

class ReverseIterator<T>: IteratorProtocol {
    
    typealias Element = T
    
    var array: [Element]
    var currentIndex = 0
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        }else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

struct ReverseSequence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    typealias Iterator = ReverseIterator<T>
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}

// tuple
extension FunctionalViewController {
    func functionalTuple(){
        var a = 2
        var b = 3
        
        swapMe2(a: &a, b: &b)
        
        print(debug: "swapData:\((a,b))")
    }
    
    func swapMe2<T>( a: inout T, b: inout T) {
        (a,b) = (b,a)
    }
}


// escaping
extension FunctionalViewController {
    func functionalEscaping(){
        doWork {
            print("doWork_out")
        }
        
        doWorkAsync {
            DispatchQueue.global().async {
                print("doWorkAsync_out")
            }
        }
        
        method1()// 对应OC的block，捕获了并创建了临时数据
        method2()// 对应OC的block，指向数据，没有创建临时数据
    }
    
    func doWork(block: ()->()) {
        print("doWork-begin")
        
        block()
        
        print("doWork-end")
    }

    func doWorkAsync(block: @escaping ()->()) {
        print("doWorkAsync-begin")
        
        DispatchQueue.main.async {
            block()
        }
        
        print("doWorkAsync-end")
    }

    func method1() {
        doWork {
            print(debug: foo)
        }
        foo = "bar"
    }

    func method2() {
        doWorkAsync {
            print(debug: self.foo)
        }
        foo = "bar"
    }
}
