//
//  GirlCollectionViewCell.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/27.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class GirlCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func cellWith(collectionView: UICollectionView) -> GirlCollectionViewCell {
        return GirlCollectionViewCell()
    }
    
}
