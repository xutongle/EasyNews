//
//  GirlsCollectionView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/27.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class GirlsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    init(frame: CGRect) {
        let mlayout = UICollectionViewFlowLayout()
        let width: CGFloat = SCREEN_WIDTH / 3.0 - 20
        mlayout.headerReferenceSize = CGSize(width: width, height: width / 2 * 3)
        
        super.init(frame: frame, collectionViewLayout: mlayout)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        return UICollectionViewCell()
    }
    
}
