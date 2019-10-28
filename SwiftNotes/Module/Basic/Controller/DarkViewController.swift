//
//  DarkViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/10/26.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class DarkViewController: BaseViewController {

//    private lazy var tableSections: [TableSection] = [
//           TableSection(name: "Adaptable Colors", rows: adaptableColors),
//           TableSection(name: "Adaptable Grays", rows: adaptableGrays),
//           TableSection(name: "Label Colors", rows: labelColors),
//           TableSection(name: "Text Colors", rows: textColors),
//           TableSection(name: "Link Color", rows: linkColor),
//           TableSection(name: "Separators", rows: separators),
//           TableSection(name: "Fill Colors", rows: fillColors),
//           TableSection(name: "Background Colors", rows: backgroundColors),
//           TableSection(name: "Grouped Background Colors", rows: groupedBackgroundColors),
//           TableSection(name: "Non-Adaptable Colors", rows: nonadaptableColors)
//       ]
//
//       private lazy var adaptableColors: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".systemRed", backgroundColor: .systemRed))
//           cells.append(buildCell(name: ".systemGreen", backgroundColor: .systemGreen))
//           cells.append(buildCell(name: ".systemBlue", backgroundColor: .systemBlue))
//           cells.append(buildCell(name: ".systemIndigo", backgroundColor: .systemIndigo))
//           cells.append(buildCell(name: ".systemOrange", backgroundColor: .systemOrange))
//           cells.append(buildCell(name: ".systemPink", backgroundColor: .systemPink))
//           cells.append(buildCell(name: ".systemPurple", backgroundColor: .systemPurple))
//           cells.append(buildCell(name: ".systemTeal", backgroundColor: .systemTeal))
//           cells.append(buildCell(name: ".systemYellow", backgroundColor: .systemYellow))
//
//           return cells
//       }()
//
//       private lazy var adaptableGrays: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".systemGray", backgroundColor: .systemGray))
//           cells.append(buildCell(name: ".systemGray2", backgroundColor: .systemGray2))
//           cells.append(buildCell(name: ".systemGray3", backgroundColor: .systemGray3))
//           cells.append(buildCell(name: ".systemGray4", backgroundColor: .systemGray4))
//           cells.append(buildCell(name: ".systemGray5", backgroundColor: .systemGray5))
//           cells.append(buildCell(name: ".systemGray6", backgroundColor: .systemGray6))
//
//           return cells
//       }()
//
//       private lazy var labelColors: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".label", textColor: .label))
//           cells.append(buildCell(name: ".secondaryLabel", textColor: .secondaryLabel))
//           cells.append(buildCell(name: ".tertiaryLabel", textColor: .tertiaryLabel))
//           cells.append(buildCell(name: ".quaternaryLabel", textColor: .quaternaryLabel))
//
//           return cells
//       }()
//
//       private lazy var linkColor: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".link", textColor: .link))
//
//           return cells
//       }()
//
//       private lazy var textColors: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".placeholderText", textColor: .placeholderText))
//
//           return cells
//       }()
//
//       private lazy var separators: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".separator", backgroundColor: .separator))
//           cells.append(buildCell(name: ".opaqueSeparator", backgroundColor: .opaqueSeparator))
//
//           return cells
//       }()
//
//       private lazy var fillColors: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".systemFill", backgroundColor: .systemFill))
//           cells.append(buildCell(name: ".secondarySystemFill", backgroundColor: .secondarySystemFill))
//           cells.append(buildCell(name: ".tertiarySystemFill", backgroundColor: .tertiarySystemFill))
//           cells.append(buildCell(name: ".quaternarySystemFill", backgroundColor: .quaternarySystemFill))
//
//           return cells
//       }()
//
//       private lazy var backgroundColors: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".systemBackground", backgroundColor: .systemBackground))
//           cells.append(buildCell(name: ".secondarySystemBackground", backgroundColor: .secondarySystemBackground))
//           cells.append(buildCell(name: ".tertiarySystemBackground", backgroundColor: .tertiarySystemBackground))
//
//           return cells
//       }()
//
//       private lazy var groupedBackgroundColors: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".systemGroupedBackground", backgroundColor: .systemGroupedBackground))
//           cells.append(buildCell(name: ".secondarySystemGroupedBackground", backgroundColor: .secondarySystemGroupedBackground))
//           cells.append(buildCell(name: ".tertiarySystemGroupedBackground", backgroundColor: .tertiarySystemGroupedBackground))
//
//           return cells
//       }()
//
//       private lazy var nonadaptableColors: [UITableViewCell] = {
//           var cells = [UITableViewCell]()
//
//           cells.append(buildCell(name: ".lightText", backgroundColor: .black, textColor: .lightText))
//           cells.append(buildCell(name: ".darkText", backgroundColor: .white, textColor: .darkText))
//
//           return cells
//       }()
//
//
    let darkSwitch = UISwitch()

    let darkLabel =  UILabel()

//    lazy var dataSource: [BasicHomeModel] = {
//        var dataSource: [BasicHomeModel] = []
//
//        //get path
//        guard let configPath = Bundle.main.path(forResource: "BasicConfig", ofType: "plist") else {
//            return dataSource
//        }
//
//        //get data
//        guard let configArray = NSArray(contentsOfFile: configPath) as? Array<Any> else {
//            return dataSource
//        }
//
//        guard let finalDataSource:[BasicHomeModel] =  configArray.toModel(modelType:BasicHomeModel.self) else {
//            return dataSource
//        }
//
//        return finalDataSource
//    }()
//
//    private lazy var tableView: UITableView = {
//        let table = UITableView()
//        table.dataSource = self
//        table.delegate = self
//        return table
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        initData()
        
        registerNotification()
    }
    
    func initUI(){
        view.addSubview(darkSwitch)
        darkSwitch.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        darkSwitch.addTarget(self, action: #selector(changeSwitch), for: .touchUpInside)

        view.addSubview(darkLabel)
        darkLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(darkSwitch)
            make.right.equalTo(darkSwitch.snp_left).offset(-10)
        }
    }
    
    func initData(){
        darkLabel.text = "Light"
        
        let isDark = self.traitCollection.userInterfaceStyle == .dark
        
        if isDark == true {
            darkSwitch.isOn = true
            changeDarkMode()
        }
    }

    
    func registerNotification(){
        // app启动或者app从后台进入前台都会调用这个方法
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: Notification.Name.NSExtensionHostDidBecomeActive, object: nil)
    }
    
    @objc func changeSwitch(){
        changeDarkMode()
        
        configDarkMode(darkSwitch.isOn ? .dark : .light)
    }
    
    @objc func becomeActive(){
        let isDark = self.traitCollection.userInterfaceStyle == .dark
        darkSwitch.isOn = isDark;
        
        changeDarkMode()
        
        configDarkMode(isDark ? .dark : .light)
    }
    
    func changeDarkMode(){
        darkLabel.text = darkSwitch.isOn ? "Dark" : "Light"
    }
    
    func configDarkMode(_ style:UIUserInterfaceStyle){
        let keyWindow = UIApplication.shared.windows.first
        keyWindow?.rootViewController?.overrideUserInterfaceStyle = style
    }
}

//extension DarkViewController:UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        tableSections[section].name
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        tableSections.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableSections[section].rows.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        tableSections[indexPath.section].rows[indexPath.row]
//    }
//}
//
//fileprivate struct TableSection {
//    let name: String
//    let rows: [UITableViewCell]
//}
//
//fileprivate func buildCell(name: String, backgroundColor: UIColor? = nil, textColor: UIColor? = nil) -> UITableViewCell {
//    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//
//    if let backgroundColor = backgroundColor {
//        cell.backgroundColor = backgroundColor
//    }
//
//    cell.textLabel?.text = name
//
//    if let textColor = textColor {
//        cell.textLabel?.textColor = textColor
//    }
//
//    return cell
//}
