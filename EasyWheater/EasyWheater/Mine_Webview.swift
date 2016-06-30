//
//  mine_webview.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/30.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class Mine_Webview: UIWebView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    init(frame: CGRect, andUrl netString: String) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        let request = NSURLRequest.init(URL: NSURL.init(string: netString)!)
        self.loadRequest(request)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
