//
//  NewsViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "right_light"), style: .done, target: self, action: #selector(rightAction))
        
        self.navigationItem.title = "科技要闻"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
    }
    
    func rightAction() -> Void {
        // 前往天气页面
        self.present(WeatherViewController(), animated: true, completion: nil)
    }

}
