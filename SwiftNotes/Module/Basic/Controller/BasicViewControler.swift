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
        
        //get path
        guard let configPath = Bundle.main.path(forResource: "BasicConfig", ofType: "plist") else {
            return dataSource
        }
        
        //get data
        guard let configArray = NSArray(contentsOfFile: configPath) as? Array<Any> else {
            return dataSource
        }
        
        guard let finalDataSource:[BasicHomeModel] =  configArray.toModel(modelType:BasicHomeModel.self) else {
            return dataSource
        }

        return finalDataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(basicTableView)
        basicTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: UITableViewDataSource
extension  BasicViewControler: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basicDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.selectionStyle = .none;
        
        if indexPath.row >= basicDataSource.count {return cell}
        
        let basicHomeModel = basicDataSource[indexPath.row]
        
        cell.textLabel?.text = kLocalizedString(title: basicHomeModel.title)

        guard let imgStr = basicHomeModel.imgStr else {
            return cell
        }
        cell.imageView?.image = UIImage.image(named: imgStr, imageSize: CGSize.init(width: 14, height: 14),imageColor: UIColor.randomColor())
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension  BasicViewControler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= basicDataSource.count {return}
        
        let basicHomeModel = basicDataSource[indexPath.row]
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
        
        navigationController?.pushViewController(instanceVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
