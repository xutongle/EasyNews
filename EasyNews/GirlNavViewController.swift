//
//  GirlNavViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/13.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class GirlNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = MY_TSUYUKUSA
        self.navigationBar.tintColor = WHITE
        // 白色
        self.navigationBar.barStyle = .blackOpaque
        
        self.tabBarItem.title = "图片"
        self.tabBarItem.image = #imageLiteral(resourceName: "right")
        
    }

}
