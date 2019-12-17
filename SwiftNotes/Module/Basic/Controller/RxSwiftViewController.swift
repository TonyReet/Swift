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
        guard let configPath = R.file.rxSwiftConfigPlist.path() else {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        public func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
//            (cellIdentifier: String, cellType: Cell.Type = Cell.self)
//            -> (_ source: Source)
//            -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
//            -> Disposable
//            where Source.Element == Sequence {
//            return { source in
//                return { configureCell in
//                    let dataSource = RxTableViewReactiveArrayDataSourceSequenceWrapper<Sequence> { tv, i, item in
//                        let indexPath = IndexPath(item: i, section: 0)
//                        let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
//                        configureCell(i, item, cell)
//                        return cell
//                    }
//                    return self.items(dataSource: dataSource)(source)
//                }
//            }
//        }
//        
//        public func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
//            (cellIdentifier: String, cellType: Cell.Type = Cell.self)
//            -> (_ source: Source)
//            -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
//            -> Disposable
//            where Source.Element == Sequence {
//            return { source in
//                return { configureCell in
//                    let dataSource = RxTableViewReactiveArrayDataSourceSequenceWrapper<Sequence> { tv, i, item in
//                        let indexPath = IndexPath(item: i, section: 0)
//                        let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
//                        configureCell(i, item, cell)
//                        return cell
//                    }
//                    return self.items(dataSource: dataSource)(source)
//                }
//            }
//        }
//        
//        public func bind<R1, R2>(to binder: (Self) -> (R1) -> R2, curriedArgument: R1) -> R2 {
//             return binder(self)(curriedArgument)
//        }
//        

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
