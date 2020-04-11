//
//  SFSymbolsViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/10/30.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class SFSymbolsViewController: BaseViewController {
    lazy var dataSource: Observable<[String]>  = {
        var dataSource: [String] = SFSymbolAllEnums
        
        return Observable.just(dataSource)
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: 30, height: 30)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.register(SFSymbolsCell.self, forCellWithReuseIdentifier: NSStringFromClass(SFSymbolsCell.self))
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = UIColor{ (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return .black
                } else {
                    return .white
                }
            }
        }
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        initData()
    }
    

    func initUI(){
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func initData(){
        dataSource.bind(to: collectionView.rx.items(cellIdentifier: NSStringFromClass(SFSymbolsCell.self), cellType: SFSymbolsCell.self)) {(row,systemName,cell) in
                  
            var image: UIImage?
            if #available(iOS 13.0, *) {
                image = UIImage(systemName: systemName)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            }

            guard let configImage = image else {
                return
            }
            
            cell.configImage(configImage)
        }.disposed(by: disposeBag)
    }
}
