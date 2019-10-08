//
//  BasicViewControler.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/9/2.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class BasicViewControler: BaseViewController {
    lazy var basicTableView: UITableView   = {
        let tableView = UITableView()
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        
        return tableView
    }()
    
    lazy var basicDataSource: [BasicHomeModel] = {
        var dataSource: [BasicHomeModel] = []
        
        //获取路径
        guard let configPath = Bundle.main.path(forResource: "BasicConfig", ofType: "plist") else {
            return dataSource
        }
        
        //获取数据
        guard let configArray = NSArray(contentsOfFile: configPath) as? Array<Any> else {
            return dataSource
        }
        
        dataSource =  configArray.toModel(modelType:BasicHomeModel.self)
    

        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(debug: "测试数据:\(basicDataSource)")
        
    }
}

// MARK: UITableViewDataSource
extension  BasicViewControler: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.basicDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = self.basicDataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath) as! UITableViewCell

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: UITableViewDelegate
extension  BasicViewControler: UITableViewDelegate {
    /// 点击行事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

