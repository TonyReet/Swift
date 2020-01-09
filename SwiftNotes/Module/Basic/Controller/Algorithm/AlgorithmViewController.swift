//
//  AlgorithmViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/12/13.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class AlgorithmViewController: BaseViewController {
    lazy var dataSource: Observable<[AlgorithmModel]> = {
        var dataSource: [AlgorithmModel] = []

        //get path
        guard let configPath = R.file.algorithmConfigPlist.path() else {
            return Observable.just(dataSource)
        }

        //get data
        guard let configArray = NSArray(contentsOfFile: configPath) as? Array<Any> else {
            return Observable.just(dataSource)
        }

        guard let modelDataSource:[AlgorithmModel] =  configArray.toModel(modelType:AlgorithmModel.self) else {
            return Observable.just(dataSource)
        }
    
        return Observable.just(modelDataSource)
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        initData()
    }
    
    func initUI(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func initData(){
        
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: NSStringFromClass(UITableViewCell.self), cellType: UITableViewCell.self)) { (row, algorithmModel, cell) in
                cell.textLabel?.text = "\(algorithmModel) @ row \(row)"
                cell.selectionStyle = .none
                
                guard let name = algorithmModel.name else {
                    return
                }
                
                cell.textLabel?.text = name
            }.disposed(by: disposeBag)
        
            tableView.rx.modelSelected(AlgorithmModel.self).subscribe(onNext: { [weak self] (algorithmModel) in
                guard let vcName = algorithmModel.vcName else {
                    return
                }
        
                guard let viewController = SystemTool.classFromString(vcName)
                    as? UIViewController.Type else {
                    return
                }
        
                let instanceVC = viewController.init()
                instanceVC.hidesBottomBarWhenPushed = true
                instanceVC.title = algorithmModel.name
        
                self?.navigationController?.pushViewController(instanceVC, animated: true)
            }).disposed(by: disposeBag)
        tableView.reloadData()
    }
}
