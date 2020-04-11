
//
//  iOS13ViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2020/1/10.
//  Copyright © 2020 TonyReet. All rights reserved.
//

import UIKit

class iOS13ViewController: BaseViewController {
    lazy var basicTableView: UITableView   = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        
        return tableView
    }()
    
    lazy var dataSource:  RxSwift.Observable<[BasicHomeModel]> = {
        var dataSource: [BasicHomeModel] = []
        
        //get path
        guard let configPath = R.file.iOS13ConfigPlist.path() else {
            return Observable.just(dataSource)
        }
        
        //get data
        guard let configArray = NSArray(contentsOfFile: configPath) as? Array<Any> else {
            return Observable.just(dataSource)
        }
        
        guard let finalDataSource:[BasicHomeModel] =  configArray.toModel(modelType:BasicHomeModel.self) else {
            return Observable.just(dataSource)
        }

        return Observable.just(finalDataSource)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(basicTableView)
        basicTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        dataSource.bind(to: basicTableView.rx.items(cellIdentifier: NSStringFromClass(UITableViewCell.self), cellType: UITableViewCell.self)) { (row,basicHomeModel,cell) in
    
            cell.selectionStyle = .none;
    
            cell.textLabel?.text = kLocalizedString(basicHomeModel.title)
    
            if let imgStr = basicHomeModel.imgStr {
                cell.imageView?.image = UIImage.image(named: imgStr, fontSize: 10, imageColor: UIColor.randomColor())
            }
        }.disposed(by: disposeBag)
    
        basicTableView.rx.modelSelected(BasicHomeModel.self).subscribe(onNext: { [weak self] (basicHomeModel) in
            
            if #available(iOS 13.0, *){
                
            }else{
                return
            }
            
            guard let vcName = basicHomeModel.vcName else {
                return
            }
    
            guard let viewController = SystemTool.classFromString(vcName)
                as? UIViewController.Type else {
                return
            }
    
            let instanceVC = viewController.init()
            instanceVC.hidesBottomBarWhenPushed = true
            instanceVC.title = basicHomeModel.title
    
            self?.navigationController?.pushViewController(instanceVC, animated: true)
        }).disposed(by: disposeBag)
    }
}
