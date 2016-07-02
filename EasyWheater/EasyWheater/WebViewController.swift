//
//  WebViewController.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/30.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let navBar = UINavigationBar.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 64))
        
        navBar.tintColor = UIColor.brownColor()
        let navItem = UINavigationItem.init(title: "")
        
        let backBtn = UIBarButtonItem.init(title: "<-返回", style: .Done, target: self, action: #selector(dissmissMe))
        backBtn.tintColor = UIColor.whiteColor()
        
        navItem.leftBarButtonItem = backBtn
        
        navBar.pushNavigationItem(navItem, animated: false)
        self.view.addSubview(navBar)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webview = Mine_Webview.init(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT), andUrl: "http://www.mojichina.com/news/")
        
        self.view.addSubview(webview)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func dissmissMe() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
