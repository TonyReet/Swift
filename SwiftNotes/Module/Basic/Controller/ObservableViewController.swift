//
//  ObservableViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/11/5.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

enum ObservableError: Error {
    case errorFirst
    case errorSecond
}

class ObservableViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.just()  需要一个初始值
        let ob1 = Observable<String>.just("5")
        _ = ob1.subscribe { (event) in
            print(debug: "ob1:\(event)")
                }
            .disposed(by: disposeBag)
        
        //2. of() 这个方法可以接受可变数量的参数 （一定是要同类型）
        let ob2 = Observable.of("a","b","c")
        _ = ob2.subscribe { (event) in
            print(debug: "ob2:\(event)")
                }
            .disposed(by: disposeBag)
        
        //3. from() 这个方法需要一个数组，效果同Observable.of("a","b","c")
        let ob3 = Observable.from(["a","b","c"])
        _ = ob3.subscribe { (event) in
            print(debug: "ob3:\(event)")
                }
            .disposed(by: disposeBag)
        
        //4. empty() 是一个空内容的序列
        let ob4 = Observable<Int>.empty()
        _ = ob4.subscribe { (event) in
            print(debug: "ob4:\(event)")
                }
            .disposed(by: disposeBag)
        
        //5. never() 是永远不会发出event，也不会终止
        let ob5 = Observable<Int>.never()
        _ = ob5.subscribe { (event) in
            print(debug: "ob5:\(event)")
                }
            .disposed(by: disposeBag)
        
        //6. error()
        let ob6 = Observable<Int>.error(ObservableError.errorFirst)
        _ = ob6.subscribe { (event) in
            print(debug: "ob6:\(event)")
                }
            .disposed(by: disposeBag)
        
        //7. range() 创建一个范围的序列
        let ob7 = Observable.range(start: 1, count: 5)
        _ = ob7.subscribe { (event) in
            print(debug: "ob7:\(event)")
                }
            .disposed(by: disposeBag)
        
        //8. repeatElement() 无限发出给定元素的event （永不终止）
//        let ob8 = Observable.repeatElement(1)
//        _ = ob8.subscribe { (event) in
//            print(debug: "ob8:\(event)")
//            }
//        .disposed(by: disposeBag)
        
        //9. generate() 判断条件都为true，才会执行序列
        let ob9 = Observable.generate(initialState: 0, condition: { $0 <= 10 }, iterate: { $0 + 2 })
        _ = ob9.subscribe { (event) in
            print(debug: "ob9:\(event)")
                }
            .disposed(by: disposeBag)

        //10. create() 这个方法接受一个block形式的参数
        let ob10 = Observable<String>.create { ob10 in
            ob10.onNext("ob10 next")
            ob10.onCompleted()
            
            // 因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create {}
        }
        _ = ob10.subscribe { (event) in
            print(debug: "ob10:\(event)")
                }
            .disposed(by: disposeBag)
        
        //11. deferred()  创建一个工厂，
        var isOdd = true
        let ob11: Observable<Int> = Observable.deferred {
            isOdd = !isOdd
            
            return isOdd == true ?Observable.of(1,3,5,7):Observable.of(2,4,6,8)
        }
        //第一次订阅
        _ = ob11.subscribe{ event in
            print("ob11-1:\(isOdd)",event)
            }
            .disposed(by: disposeBag)
        
        //第二次订阅
        _ = ob11.subscribe{ event in
            print("ob11-2:\(isOdd)",event)
                }
            .disposed(by: disposeBag)
        
        //12. interval()
        let ob12 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                 
        _ = ob12.subscribe { (event) in
            print(debug: "ob12:\(event)")
                }
            .disposed(by: disposeBag)
        
        //13. timer()  创建一个经过设定的一段时间后，产生唯一的元素
        let ob13 = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        _ = ob13.subscribe { (event) in
            print(debug: "ob13:\(event)")
                }
            .disposed(by: disposeBag)
        
//        第二种 就是经过设定一段时间，每隔一段时间产生一个元素
//        第一个参数就是等待5秒，第二个参数为每个1秒产生一个元素
        
        let ob14 = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        _ = ob14.subscribe { (event) in
            print(debug: "ob14:\(event)")
                }
            .disposed(by: disposeBag)
    }
}
