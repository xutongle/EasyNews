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
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webview = Mine_Webview.init(frame: self.view.frame, andUrl: "http://www.bing.com")
        
        self.view.addSubview(webview)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
