//
//  BookDetailViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/24.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, BookDetailTableViewProtocol {

    fileprivate var bookDetailTableView: BookDetailTableView!
    
    fileprivate var model: Books!
    
    // 转场
    fileprivate let transationGestrue = TransationGestrue()
    fileprivate var booksTransationDelegate: BooksTransationDelegate!
    
    convenience init(model: Books) {
        self.init()
        
        self.model = model
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.title = "详情"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let barHeight = Tools.getBarHeight(nav: self.navigationController)
        
        bookDetailTableView = BookDetailTableView(frame: CGRect(x: 0, y: barHeight.navgationHeight,
                                                                width: self.view.frame.width,
                                                                height: self.view.frame.height - barHeight.navgationHeight) ,
                                                  model: self.model)
        bookDetailTableView.book_detail_delegate = self
        self.view.addSubview(self.bookDetailTableView)
    }
    
    // BookDetailTableViewProtocol 协议
    func GoDetail(value: String) {
        let someDetailVC = SomeDetailViewController()
        
        self.booksTransationDelegate = BooksTransationDelegate(transationGestrue: transationGestrue)
        someDetailVC.transitioningDelegate = self.booksTransationDelegate
        transationGestrue.wire(to: someDetailVC)
        
        self.present(someDetailVC, animated: true, completion: nil)
        
        someDetailVC.textView.text = value
    }
    
}
