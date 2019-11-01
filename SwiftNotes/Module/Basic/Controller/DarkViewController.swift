//
//  DarkViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/10/26.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class DarkViewController: BaseViewController {
    let darkSwitch = UISwitch()
    let darkLabel = UILabel()
    
    lazy var dataSource: [DarkModeModel] = {
        var dataSource: [DarkModeModel] = []

        //get path
        guard let configPath = Bundle.main.path(forResource: "DarkConfig", ofType: "plist") else {
            return dataSource
        }

        //get data
        guard let configArray = NSArray(contentsOfFile: configPath) as? Array<Any> else {
            return dataSource
        }

        guard let modelDataSource:[DarkModeModel] =  configArray.toModel(modelType:DarkModeModel.self) else {
            return dataSource
        }
        
        dataSource = modelDataSource

        return dataSource
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        return tableView
    }()
    
    private lazy var topLeftImageView: UIImageView = {
        let topLeftImageView = UIImageView.init(image: UIImage(named: "darkImg"))
        topLeftImageView.contentMode = .scaleAspectFill
        return topLeftImageView
    }()
    
    private lazy var topMiddleImageView: UIImageView = {
        let topMiddleImageView = UIImageView.init(image: UIImage(named: "darkImg"))
        
        topMiddleImageView.overrideUserInterfaceStyle = .light
        topMiddleImageView.contentMode = .scaleAspectFill
        return topMiddleImageView
    }()
    
    private lazy var topRightView: UIView = {
        let topRightView = UIView()
        topRightView.backgroundColor = UIColor(named: "darkColor")
        
        let label = UILabel()
        label.textAlignment = .center
        
        topRightView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(topRightView)
        }
        
        label.text = "暗黑模式背景"
        
        return topRightView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        initData()
        
        initRightBarItem()
    }
    
    func initUI(){
        let multipleRatio = 6.0
        
        let topView = UIView()
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(topView.snp_width).multipliedBy(1/(multipleRatio))
        }
        
        topView.addSubview(topLeftImageView)
        topLeftImageView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(topView)
        }
        
        topView.addSubview(topMiddleImageView)
        topMiddleImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(topLeftImageView)
            make.left.equalTo(topLeftImageView.snp_right)
            make.width.equalTo(topLeftImageView)
        }
        
        topView.addSubview(topRightView)
        topRightView.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(topView)
            make.left.equalTo(topMiddleImageView.snp_right)
            make.width.equalTo(topMiddleImageView.snp_width).multipliedBy(multipleRatio/2)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(topView.snp_bottom)
        }
    }
    
    func initData(){
        darkLabel.text = "Light"
        
        let isDark = self.traitCollection.userInterfaceStyle == .dark
        
        if isDark == true {
            darkSwitch.isOn = true
            changeLabelDarkMode()
        }
        
        tableView.reloadData()
    }
}

//MARK:- mark Mode
extension DarkViewController {
    func initRightBarItem() {
        let rightBarView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarView)
        rightBarView.isUserInteractionEnabled = true
        
        rightBarView.addSubview(darkSwitch)
        darkSwitch.snp.makeConstraints { (make) in
            make.centerY.right.top.bottom.equalTo(rightBarView)
        }
        darkSwitch.addTarget(self, action: #selector(changeSwitch), for: .touchUpInside)

        rightBarView.addSubview(darkLabel)
        darkLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(darkSwitch)
            make.right.equalTo(darkSwitch.snp_left).offset(-10)
            make.left.equalTo(rightBarView)
        }
    }
    
    @objc func changeSwitch(){
        changeLabelDarkMode()
        
        configDarkMode(darkSwitch.isOn ? .dark : .light)
    }

    func changeLabelDarkMode(){
        darkLabel.text = darkSwitch.isOn ? "Dark" : "Light"
    }
    
    func configDarkMode(_ style:UIUserInterfaceStyle){
        self.overrideUserInterfaceStyle = style
    }
    
    func getColor(_ colorName:String) -> UIColor?{
        let colorString = "\(colorName)Color"

        let colorSEL = NSSelectorFromString(colorString)

        guard let color = UIColor.perform(colorSEL)?.takeUnretainedValue() as? UIColor else{
          return nil
        }

        return color
    }
}

extension DarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.selectionStyle = .none;
        
        if indexPath.row >= dataSource.count {return cell}
        
        let darkModeModel = dataSource[indexPath.row]

        guard let name = darkModeModel.name else {
            return cell
        }

        var textColor:UIColor?
        if let textColorString = darkModeModel.textColor, textColorString.isEmpty == false {
            textColor = getColor(textColorString)
        }

        var backgroundColor:UIColor?
        if let backgroundColorString = darkModeModel.backgourdColor, backgroundColorString.isEmpty == false{
            backgroundColor = getColor(backgroundColorString)
        }

        
        if let backgroundColor = backgroundColor {
            cell.backgroundColor = backgroundColor
        }

        cell.textLabel?.text = name

        if let textColor = textColor {
            cell.textLabel?.textColor = textColor
        }
        
        return cell
    }
}
