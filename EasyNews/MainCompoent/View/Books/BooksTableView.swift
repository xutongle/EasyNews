//
//  NewsView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

protocol NewsTableViewProtocol: class {
    func ScrollToEnd() -> Void
}

class BooksTableView: UITableView {

    // 顶部滚动的view
//    private var newsTopScrollView: NewsTopScrollView!
//    // 指示器
//    private var pageController: UIPageControl!
    
    private var tempView: TempView!
    
    weak var action_delegate: NewsTableViewProtocol?
    
    // 数据源
    var booksModel: [Books] = [] {
        didSet {
            if booksModel.count != 0 {
                self.tempView.removeFromSuperview()
            }else {
                self.addSubview(self.tempView)
            }
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.white
        self.delegate = self
        self.dataSource = self
        self.rowHeight = 130
        self.tableFooterView = UIView()
        self.lineToLeft()
        
        // 
        self.keyboardDismissMode = .onDrag
        // 没有数据显示的view
        tempView = TempView.getView(mframe: self.frame)
        self.addSubview(self.tempView)
        
        // 把滚动的视图废弃 改为搜索
//        self.newsTopScrollView = NewsTopScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 120 * WScale))
//        self.tableHeaderView = self.newsTopScrollView
        // 页面指示器
//        pageController = UIPageControl()
//        pageController.numberOfPages = 3
//        self.addSubview(pageController)
        
//        self.newsTopScrollView.needChangePageControll = { type in
//            self.pageController.currentPage = type.hashValue
//        }
        
        // 注册的是nib
        self.register(UINib(nibName: BooksTableViewCell.ID, bundle: nil), forCellReuseIdentifier: BooksTableViewCell.ID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        pageController.snp.makeConstraints { (make) in
//            make.bottom.equalTo(self.newsTopScrollView.snp.bottom).offset(-5)
//            make.left.right.equalTo(self.newsTopScrollView)
//            make.height.equalTo(10)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource协议
extension BooksTableView: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BooksTableViewCell.cellWith(tableview: tableView, indexPath: indexPath)
        
        let book = self.booksModel[indexPath.row]
        
        cell.bookImageView.kf.setImage(with: URL(string: book.images.medium), placeholder: nil)
        cell.titleLabel.text = book.title
        cell.avgLabel.text = "评分：" + book.rating.average
        cell.authorLabel.text = "作者：" + Tools.arrayToString(array: book.author, s: ",")
        cell.publishingLabel.text = "出版社：" + book.publisher
        
        return cell
    }
}

// MARK: - Scroll协议
extension BooksTableView {
    
    // 滚动协议
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // ScrollView的内容是否比TableView小，小的话就随便上啦都做加载 - - 其实在这里说明没数据了 只能搜到这么多
        if scrollView.contentSize.height < frame.size.height {
            if scrollView.contentOffset.y > 20 {
                // 没数据
            }
        }else{
            // 需要添加数据
            if (scrollView.contentSize.height - frame.size.height + 20 < scrollView.contentOffset.y) {
                action_delegate?.ScrollToEnd()
            }
        }
    }
}

