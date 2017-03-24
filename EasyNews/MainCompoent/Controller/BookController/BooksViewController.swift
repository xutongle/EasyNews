//
//  NewsViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit
import Alamofire

class BooksViewController: UIViewController {

    // view
    fileprivate var booksTableView: BooksTableView!
    fileprivate var searchToolBar: SearchToolBar!
    
    // 转场
    fileprivate let transationGestrue = TransationGestrue()
    fileprivate var booksTransationDelegate: BooksTransationDelegate!
    
    // 搜索的词条
    fileprivate var q: String = ""
    fileprivate var oldQ: String = ""
    fileprivate var isOver: Bool = false
    // 是否真在请求数据
    fileprivate var isRequest: Bool = false
    // 当前位移
    fileprivate var offset: Int = 0
    // 请求加载的label
    fileprivate lazy var loadingLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        label.setStyle("正在加载...", bgColor: UIColor.black, color: UIColor.white, fontName: nil, textSize: 16, alignment: .center)
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "right_light"), style: .done, target: self, action: #selector(rightAction))
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.title = "豆瓣书籍"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.booksTableView = BooksTableView(frame: self.view.frame, style: .plain)
        self.booksTableView.action_delegate = self
        self.view.addSubview(self.booksTableView)
        
        self.searchToolBar = SearchToolBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        self.searchToolBar.delegate = self
        self.view.addSubview(self.searchToolBar)
        
        // 布局
        initLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !(Tools.getUserDefaults(key: LocalConstant.UserIsLogin) as? Bool ?? false) {
            /// 前往登录
            /// self.present(, animated: true, completion: nil)
            /// 出现警告： Presenting view controllers on detached view controllers is discouraged
            /// 使用下面这个解决问题
            self.parent?.present(UserActionViewController(), animated: true, completion: nil)
            
            /// Unbalanced calls to begin/end appearance transitions for <EasyNews.TabBarViewController: 0x7fe5c8e06ca0>.
            /// 然后还有这个警告 意思是你试图几乎同时的推两个Controller到栈中去 把这个代码放到viewDidAppear 中就不会和当前的ViewController冲突了
        }
    }
    
    // 初始化布局
    private func initLayout() -> Void {
        
        let barHeight = Tools.getBarHeight(nav: self.navigationController)
        
        self.searchToolBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(barHeight.sumHeight)
            make.left.right.equalTo(self.view)
            make.height.equalTo(35)
        }
        
        self.booksTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(barHeight.sumHeight + self.searchToolBar.frame.size.height)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-TAB_HEIGHT)
        }
    }
    
    // 前往天气页面
    func rightAction() -> Void {
        let weatherVC = WeatherViewController()
        
        booksTransationDelegate = BooksTransationDelegate(transationGestrue: transationGestrue)
        weatherVC.transitioningDelegate = booksTransationDelegate
        
        // 主要是做了手势和协议
        transationGestrue.wire(to: weatherVC)
        
        self.present(weatherVC, animated: true, completion: nil)
    }
    
}

// 按了搜索按钮 执行网络请求
extension BooksViewController: SearchToolBarProtocol {
    
    func searchAction(q: String) -> Void {
        if self.q != q {
            // 记录之前的q
            self.oldQ = self.q
            self.q = q
            self.offset = 0
            self.isOver = false
            
            // 没有在请求
            if !isRequest {
                self.booksTableView.booksModel = []
                self.isRequest = true
                self.requestBooks(q: q, offset: self.offset)
            }
        }
    }
    
    // 网络请求
    func requestBooks(q: String, offset: Int) -> Void {
        NetTool.requestBooks(q: q, offset: offset, success: { (value) in
            
            self.isRequest = false
            guard let result = value as? [String: Any] else {
                return
            }
            
            guard let count = result["count"] as? Int else {
                return
            }
            
            // 没有书籍
            if count <= 0 {
                self.isOver = true
                self.showLoadingLabel(text: "没有更多数据")
                return
            }
            
            guard let books = result["books"] as? [NSDictionary] else {
                return
            }
            
            if let total = result["total"] as? Int64 {
                self.booksTableView.total = total
            }
            //
            for book in books {
                self.booksTableView.booksModel.append(Books(fromDictionary: book))
            }
            self.removeLoadingLabel()
        }) { (message) in
            self.showLoadingLabel(text: message)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(1), execute: {
                self.isRequest = false
                self.removeLoadingLabel()
            })
        }
    }
}

// MARK: - NewsTableViewProtocol 上拉了 需要加载更多数据
extension BooksViewController: NewsTableViewProtocol {
    // 需要更多的数据
    func ScrollToEnd() -> Void {
        if !isRequest {
            // 请求完毕了
            if isOver {
                isRequest = false
                return
            }
            // 展示
            self.showLoadingLabel(text: "正在加载...")
            isRequest = true
            self.offset += 20
            requestBooks(q: self.q, offset: self.offset)
        }
    }
    
    //  显示加载的label
    func showLoadingLabel(text: String) -> Void {
        self.loadingLabel.text = text
        self.booksTableView.tableFooterView = self.loadingLabel
    }
    
    // 隐藏加载的label
    func removeLoadingLabel() -> Void {
        self.booksTableView.tableFooterView = UIView()
        self.loadingLabel.removeFromSuperview()
    }
    
    // 按了cell
    func DidSelectCell(book: Books) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(BookDetailViewController(model: book), animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}

//extension BooksViewController {
//
//    // UDP SERVER
//    func UDPServer() -> Void {
//        DispatchQueue.global().async {
//            let utf8Str = ("127.0.0.1" as NSString).utf8String
//            let point = UnsafeMutablePointer<Int8>(mutating: utf8Str)
//            guard Listener(point, 8080) == 1 else {
//                return
//            }
//            
//            while true {
//                guard Accept() == 1 else{
//                    return
//                }
//                
//                while getState() > 2{
//                    if let value = Reciver() {
//                        print(" swift_data", String(cString: value, encoding: String.Encoding.utf8) ?? "null")
//                    }
//                }
//                
//                // 关闭客户端
//                CloseServer(S_SHUT_RD);
//            }
//        }
//    }
//}
