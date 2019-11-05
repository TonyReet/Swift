//
//  SFSymbolsCell.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/10/30.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class SFSymbolsCell: UICollectionViewCell {
    let symbolsImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        contentView.addSubview(symbolsImageView)
        symbolsImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    public func configImage(_ image:UIImage){
        symbolsImageView.image = image
    }
}
