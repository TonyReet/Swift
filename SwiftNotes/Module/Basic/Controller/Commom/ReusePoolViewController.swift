//
//  ReusePoolViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/10.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

class ReusePoolViewController: BaseViewController {
     lazy var tableView: IndexedTableView = {
       let tableView = IndexedTableView(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 60), style: .plain)
        tableView.delegate = (self as UITableViewDelegate)
        tableView.dataSource = (self as UITableViewDataSource)
        tableView.indexedDataSource = (self as IndexedTableViewDataSouce)
        return tableView
    }()
        
    lazy var button:UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        btn.backgroundColor = UIColor.red
        btn.setTitle("reloadTable", for: .normal)
        btn.addTarget(self, action: #selector(reloadTable), for: .touchUpInside)
        return btn
    }()
        
    private var dataSource:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        self.view.addSubview(button)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        for i in 0..<100 {
            dataSource.append("\(i)")
        }
    }
    
    @objc private func reloadTable() {
        print("reloadTable")
        tableView.reloadData()
    }
}

extension ReusePoolViewController: UITableViewDelegate,UITableViewDataSource, IndexedTableViewDataSouce {
    static var change = true
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func indexTitlesForIndexTableView(_ tableView: IndexedTableView) -> [String] {
        
        if ReusePoolViewController.change {
            ReusePoolViewController.change = false
            return ["A","B","C","D","E","F"]
        }else {
            ReusePoolViewController.change = true
            return ["A","B","C","D","E","F","G","H","I","G","K"]
        }
    }
}

