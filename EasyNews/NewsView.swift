//
//  NewsView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NewsView: UIView {

    private var newsTopScrollView: NewsTopScrollView!
    
    private var pageController: UIPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.newsTopScrollView = NewsTopScrollView()
        
        self.addSubview(self.newsTopScrollView)
        
        pageController = UIPageControl()
        pageController.currentPage = 1
        pageController.numberOfPages = 3
        self.addSubview(pageController)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pageController.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.newsTopScrollView.snp.bottom).offset(-5)
            make.left.right.equalTo(self.newsTopScrollView)
            make.height.equalTo(10)
        }
        
        self.newsTopScrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(120 * WScale)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
