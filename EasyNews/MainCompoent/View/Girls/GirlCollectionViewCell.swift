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
    
    fileprivate var imageView: UIImageView!
    
    public static let ID = "GirlCollectionViewCell"
    
    fileprivate var indicatorView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        self.contentView.addSubview(imageView)
        
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.addSubview(indicatorView)
    }
    
    //  准备复用
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // 真正的frame
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    // 设置图片
    func setImageURL(url: String) -> Void {
        indicatorView.startAnimating()
        
        guard let murl = URL(string: url) else {
            indicatorView.stopAnimating()
            return
        }
        
        // 加载图片
        imageView.kf.setImage(with: murl, placeholder: nil, options: nil, progressBlock: nil) { (image, error, type, url) in
            self.indicatorView.stopAnimating()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 获得GirlCollectionViewCell
    static func cellWith(collectionView: UICollectionView, indexPath: IndexPath) -> GirlCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath)
        
        return cell as! GirlCollectionViewCell
    }
    
}
