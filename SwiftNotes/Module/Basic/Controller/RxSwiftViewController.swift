//
//  RxSwiftViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/10/31.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit
import RxSwift

class RxSwiftViewController: BaseViewController {
    // tableView对象
    lazy var rxSwiftTableView: UITableView   = {
        let rxSwiftTableView = UITableView()
        rxSwiftTableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        
        view.addSubview(rxSwiftTableView)
        rxSwiftTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        return rxSwiftTableView
    }()
    
    lazy var dataSource:Observable<[BasicHomeModel]> = {
        var dataSource: [BasicHomeModel] = []
        
        //get path
        guard let configPath = Bundle.main.path(forResource: "RxSwiftConfig", ofType: "plist") else {
            return Observable.of(dataSource)
        }
        
        //get data
        guard let configArray = NSArray(contentsOfFile: configPath) as? Array<Any> else {
            return Observable.of(dataSource)
        }
        
        guard let finalDataSource:[BasicHomeModel] =  configArray.toModel(modelType:BasicHomeModel.self) else {
            return Observable.of(dataSource)
        }

        return Observable.of(finalDataSource)
    }()
    
    // 负责对象销毁
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //使用数据初始化cell
        dataSource
            .bind(to:rxSwiftTableView.rx.items(cellIdentifier: NSStringFromClass(UITableViewCell.self), cellType: UITableViewCell.self)){
                (_, model, cell) in
            
                cell.selectionStyle = .none;
                cell.textLabel?.text = kLocalizedString(model.title)

                if let imgStr = model.imgStr {
                    cell.imageView?.image = UIImage.image(named: imgStr, imageSize: CGSize.init(width: 10, height: 10),imageColor: UIColor.randomColor())
                }
            }
            .disposed(by: disposeBag)

        //cell的点击事件
        rxSwiftTableView.rx
            .modelSelected(BasicHomeModel.self)
            .subscribe(
                onNext:{[weak self]model in

                    guard let vcName = model.vcName else {
                        return
                    }
                    
                    guard let viewController = SystemTool.classFromString(vcName)
                        as? UIViewController.Type else {
                        return
                    }
                    
                    let instanceVC = viewController.init()
                    instanceVC.hidesBottomBarWhenPushed = true
                    instanceVC.title = model.title
                    
                    self?.navigationController?.pushViewController(instanceVC, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
}
