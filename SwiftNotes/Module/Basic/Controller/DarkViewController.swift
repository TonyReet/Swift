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
    
    lazy var dataSource: Observable<[DarkModeModel]> = {
        var dataSource: [DarkModeModel] = []

        //get path
        guard let configPath = R.file.darkConfigPlist.path() else {
            return Observable.just(dataSource)
        }

        //get data
        guard let configArray = NSArray(contentsOfFile: configPath) as? Array<Any> else {
            return Observable.just(dataSource)
        }

        guard let modelDataSource:[DarkModeModel] =  configArray.toModel(modelType:DarkModeModel.self) else {
            return Observable.just(dataSource)
        }
    
        return Observable.just(modelDataSource)
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
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
        
        if #available(iOS 13.0, *) {
            topMiddleImageView.overrideUserInterfaceStyle = .light
        }
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
        
        label.text = kLocalizedString("DarkModeBackground")
        
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
        
        var isDark = false
        if #available(iOS 12.0, *) {
            isDark = self.traitCollection.userInterfaceStyle == .dark
        }
        
        if isDark == true {
            darkSwitch.isOn = true
            changeLabelDarkMode()
        }
        
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: NSStringFromClass(UITableViewCell.self), cellType: UITableViewCell.self)) { [weak self] (row, darkModeModel, cell) in

                cell.selectionStyle = .none
                
                guard let name = darkModeModel.name else {
                    return
                }

                var textColor:UIColor?
                if let textColorString = darkModeModel.textColor, textColorString.isEmpty == false {
                    textColor = self?.getColor(textColorString)
                }

                var backgroundColor:UIColor?
                if let backgroundColorString = darkModeModel.backgourdColor, backgroundColorString.isEmpty == false{
                    backgroundColor = self?.getColor(backgroundColorString)
                }

                
                if let backgroundColor = backgroundColor {
                    cell.backgroundColor = backgroundColor
                }

                cell.textLabel?.text = name

                if let textColor = textColor {
                    cell.textLabel?.textColor = textColor
                }
            }.disposed(by: disposeBag)
        
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
        
        darkSwitch.rx.isOn.subscribe(onNext: { [weak self](isOn) in
            self?.changeLabelDarkMode()

            if #available(iOS 12.0, *) {
                self?.configDarkMode(isOn ? .dark : .light)
            }
        }).disposed(by: disposeBag)

        rightBarView.addSubview(darkLabel)
        darkLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(darkSwitch)
            make.right.equalTo(darkSwitch.snp_left).offset(-10)
            make.left.equalTo(rightBarView)
        }
    }
    
    func changeLabelDarkMode(){
        darkLabel.text = darkSwitch.isOn ? "Dark" : "Light"
    }
    
    @available(iOS 12.0, *)
    func configDarkMode(_ style:UIUserInterfaceStyle){
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = style
        }
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
