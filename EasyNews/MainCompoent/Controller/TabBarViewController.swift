//
//  TabBarViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

var TAB_HEIGHT: CGFloat!

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TABBAR 高度
        TAB_HEIGHT = self.tabBar.bounds.size.height
        
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = MY_TSUYUKUSA
    }
}
