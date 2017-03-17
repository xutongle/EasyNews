//
//  NewsViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    private var newsView: NewsTableView!
    
    // 转场
    fileprivate let transationGestrue = TransationGestrue()
    fileprivate var transationDelegate: NewsTransationDelegate!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "right_light"), style: .done, target: self, action: #selector(rightAction))
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.title = "豆瓣书籍"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.newsView = NewsTableView()
        self.view.addSubview(self.newsView)
        
        initLayout()
        //UDPServer()
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
    
    func initLayout() -> Void {
        
        self.newsView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-39)
        }
    }
    
    func rightAction() -> Void {
        let weatherVC = WeatherViewController()
        
        transationDelegate = NewsTransationDelegate(transationGestrue: transationGestrue)
        weatherVC.transitioningDelegate = transationDelegate
        
        // 主要是做了手势和协议
        transationGestrue.wire(to: weatherVC)
        
        // 前往天气页面
         self.present(weatherVC, animated: true, completion: nil)
    }
    
}

extension NewsViewController {

    // UDP SERVER
    func UDPServer() -> Void {
        DispatchQueue.global().async {
            let utf8Str = ("127.0.0.1" as NSString).utf8String
            let point = UnsafeMutablePointer<Int8>(mutating: utf8Str)
            guard Listener(point, 8080) == 1 else {
                return
            }
            
            while true {
                guard Accept() == 1 else{
                    return
                }
                
                while getState() > 2{
                    if let value = Reciver() {
                        print(" swift_data", String(cString: value, encoding: String.Encoding.utf8) ?? "null")
                    }
                }
                
                // 关闭客户端
                CloseServer(S_SHUT_RD);
            }
        }
    }
}
