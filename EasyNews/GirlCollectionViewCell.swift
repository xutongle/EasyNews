//
//  GirlCollectionViewCell.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/27.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit
import Kingfisher

class GirlCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    
    func setImageURL(url: String) -> Void {
        guard let murl = URL(string: url) else {
            
            return
        }
        
        // 加载图片
        imageView.kf.setImage(with: murl, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            if error == nil {
                
            }else {
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func cellWith(collectionView: UICollectionView, indexPath: IndexPath, width: CGFloat, height: CGFloat) -> GirlCollectionViewCell {
        let ID = "GirlCollectionViewCell"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as? GirlCollectionViewCell
        if cell == nil {
            cell = GirlCollectionViewCell.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        }
        return cell!
    }
    
}
