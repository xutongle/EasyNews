//
//  NewsViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    private var newsView: NewsView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "right_light"), style: .done, target: self, action: #selector(rightAction))
        
        self.automaticallyAdjustsScrollViewInsets = false
                
        self.navigationItem.title = "科技要闻"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.newsView = NewsView()
        self.view.addSubview(self.newsView)
        
        self.newsView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-39)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    func rightAction() -> Void {
        // 前往天气页面
         self.present(WeatherViewController(), animated: true, completion: nil)
    }
    
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
                
                let path_utf8Str = (Tools.getCacheDirectory(name: "temp") as NSString).utf8String
                let path_point = UnsafeMutablePointer<Int8>(mutating: path_utf8Str)
                guard CreateFile(path_point) == 1 else {
                    return
                }
                
                while getState() > 2{
                    Reciver()
                }
                // 关闭客户端
                CloseServer(S_SHUT_RD);
            }
        }
    }

}