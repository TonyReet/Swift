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
        
        addRightBarButtonItem()
    }
    
    func addRightBarButtonItem(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close Dark Mode", style: .done, target: self, action: #selector(changeDarkMode(_:)))

        navigationItem.rightBarButtonItem?.tintColor = UIColor.label
    }
    
    @objc func changeDarkMode(_ buttonItem: UIBarButtonItem){
        if buttonItem.title == "Close Dark Mode" {
            
            buttonItem.title = "Open Dark Mode"
            
            configDarkMode(UIUserInterfaceStyle.light)
        }else{
            buttonItem.title = "Close Dark Mode"
            
            configDarkMode(UIUserInterfaceStyle.dark)
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
        cell.textLabel?.text = basicHomeModel.title
        
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

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: DarkMode
extension BasicViewControler {
    @available(iOS 12.0, *)
    func configDarkMode(_ style:UIUserInterfaceStyle){
        if #available(iOS 13.0, *) {
            UIApplication.shared.keyWindow?.rootViewController?.overrideUserInterfaceStyle = style
        }
    }
}
