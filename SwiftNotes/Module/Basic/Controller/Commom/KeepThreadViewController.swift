//
//  KeepThreadViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/4/11.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

/*  通过测试，如果只是单纯的添加Observer，然后去启动runloop，runloop并不能长期的运行，会直接退出轮询。而另外的Source、Timer则能保证runloop正常运行。
 */

class KeepThreadViewController: BaseViewController {

    var thread:Thread?
    var runLoopWorkingIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addRunloopButton()
        addTestButton()
        addStopButton()
    }
    
    func addRunloopButton(){
        let titles = ["Source","Observer","Timer","Port"]
        let fixedItemSpacing = 10
        var preView:UIView = view
        let titleWidth = (UIScreen.main.bounds.size.width - CGFloat((titles.count + 1)*fixedItemSpacing))/CGFloat(titles.count)
        
        for index in 0..<titles.count {
            let title = titles[index]
            
            let titleButton = UIButton()
            titleButton.backgroundColor = UIColor.randomColor()
            titleButton.setTitle("\(title)", for: .normal)
            titleButton.rx.tap.subscribe(onNext: { [weak self]  in
                self?.threadStartWith(titleButton)
            }).disposed(by: disposeBag)
            
            // add Constarints
            view.addSubview(titleButton)
            titleButton.snp_makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(50)
                make.width.equalTo(titleWidth)
                
                if (index == 0){
                    make.left.equalTo(view.snp.left).offset(fixedItemSpacing)
                }else if (index == titles.count - 1){
                    make.right.equalTo(view.snp.right).offset(-fixedItemSpacing)
                }else {
                    make.left.equalTo(preView.snp.right).offset(fixedItemSpacing)
                }
            }
            
            preView = titleButton
        }
    }

    func addTestButton(){
        let testButton = UIButton()
        testButton.backgroundColor = UIColor.randomColor()
        testButton.setTitle("test", for: .normal)
        
        view.addSubview(testButton)
        testButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.bottom.equalTo(view.snp.centerY).offset(-50)
        }
        
        //按钮点击响应
        testButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let thread = self?.thread else {
                return
            }
            
            self?.perform(#selector(self?.testBackAction), on: thread, with: nil, waitUntilDone: false)
        }).disposed(by: disposeBag)
    }
    
    func addStopButton(){
        let stopButton = UIButton()
        stopButton.backgroundColor = UIColor.randomColor()
        stopButton.setTitle("stop", for: .normal)
        
        view.addSubview(stopButton)
        stopButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.bottom.equalTo(view.snp.centerY).offset(100)
        }
        
        stopButton.rx.tap.subscribe(onNext: { [weak self] in
            print(debug: "stop")
            
            CFRunLoopStop(CFRunLoopGetCurrent())
        
            self?.thread?.cancel()
            self?.thread = nil
        }).disposed(by: disposeBag)
    }
    
    @objc func testBackAction(){
        print(debug: "runloop is working, index:\(runLoopWorkingIndex)")
        runLoopWorkingIndex += 1
    }
    
    @objc func threadStartWith(_ button: UIButton){
        self.thread?.cancel()
        
        let buttonTitle = button.currentTitle
        guard let title = buttonTitle else {
            return
        }
        
        let selectorName = "createRunloopBy\(title)"
        let selector:Selector = Selector(selectorName)
        let thread = Thread(target: self, selector: selector, object: nil)
        
        thread.start()
        
        self.thread = thread
        
        print(debug: "start with \(title)")
    }
    
    @objc func createRunloopBySource(){
        autoreleasepool {
            let runloop = CFRunLoopGetCurrent()
            var sourceContext = CFRunLoopSourceContext()
            
            let source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &sourceContext)
        
            CFRunLoopAddSource(runloop, source, CFRunLoopMode.defaultMode)
            
            CFRunLoopRun()
        }
    }
    
    @objc func createRunloopByObserver(){
        autoreleasepool {
            let runloop = CFRunLoopGetCurrent()
            let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0) { (observer, activity) in
                print(debug: "observer")
            }
            CFRunLoopAddObserver(runloop, observer, CFRunLoopMode.defaultMode)
            
            CFRunLoopRun();
        }
    }
    
    @objc func createRunloopByTimer(){
        autoreleasepool {
            let runloop = CFRunLoopGetCurrent()
            let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent(), kCFAbsoluteTimeIntervalSince1904, 0, 0) { (timer) in
                print(debug: "timer dida dida")
            }
            CFRunLoopAddTimer(runloop, timer, CFRunLoopMode.defaultMode)
            
            CFRunLoopRun()
        }
    }
    
    @objc func createRunloopByPort(){
        autoreleasepool {
            RunLoop.current.add(Port(), forMode: .default)
            RunLoop.current.run()
        }
    }
    
    deinit {
        print(debug: "deinit")
    }
}

