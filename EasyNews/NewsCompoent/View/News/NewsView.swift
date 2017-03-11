//
//  NewsView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NewsView: UITableView {

    private var newsTopScrollView: NewsTopScrollView!
    
    private var pageController: UIPageControl!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.white
        
        self.newsTopScrollView = NewsTopScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 120 * WScale))
        self.tableHeaderView = self.newsTopScrollView
        
        self.newsTopScrollView.needChangePageControll = { type in
            self.pageController.currentPage = type.hashValue
        }
        
        pageController = UIPageControl()
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
