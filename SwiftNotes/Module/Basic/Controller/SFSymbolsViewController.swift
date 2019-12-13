//
//  SFSymbolsViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/10/30.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class SFSymbolsViewController: BaseViewController {
    lazy var dataSource: [String] = {
        var dataSource: [String] = SFSymbolAllEnums
        
        return dataSource
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: 30, height: 30)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.register(SFSymbolsCell.self, forCellWithReuseIdentifier: NSStringFromClass(SFSymbolsCell.self))
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.backgroundColor = UIColor{ (trainCollection) -> UIColor in
            if trainCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    

    func initUI(){
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

extension SFSymbolsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:SFSymbolsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SFSymbolsCell", for: indexPath) as! SFSymbolsCell

        if indexPath.row >= dataSource.count {return cell}
    
        let systemName = dataSource[indexPath.row] as String

        let image = UIImage(systemName: systemName)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
        guard let configImage = image else {
            return cell
        }
        
        cell.configImage(configImage)

        return cell
    }
}

