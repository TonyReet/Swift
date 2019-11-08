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
    }

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
