//
//  NewsView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NewsTableView: UITableView {

    // 顶部滚动的view
    private var newsTopScrollView: NewsTopScrollView!
    // 指示器
    private var pageController: UIPageControl!
    
    // 数据源
    var newsModel: [NewsModel] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.white
        self.delegate = self
        self.dataSource = self
        
        self.newsTopScrollView = NewsTopScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 120 * WScale))
        self.tableHeaderView = self.newsTopScrollView
        
        self.newsTopScrollView.needChangePageControll = { type in
            self.pageController.currentPage = type.hashValue
        }
        
        pageController = UIPageControl()
        pageController.numberOfPages = 3
        self.addSubview(pageController)
        
        self.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.ID)
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

extension NewsTableView: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return NewsTableViewCell.cellWith(tableview: tableView, indexPath: indexPath)
    }
}
