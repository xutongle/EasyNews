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
    
    func rightAction() -> Void {
        // 前往天气页面
        self.present(WeatherViewController(), animated: true, completion: nil)
    }

}
