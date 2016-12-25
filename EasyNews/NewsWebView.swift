//
//  NewsWebView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/17.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NewsWebView: UIWebView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        let path = Bundle.main.path(forResource: "test", ofType: "txt")!
        let str = try! String(contentsOf: URL(string: "file://" + path)!, encoding: String.Encoding.utf8)
        self.loadHTMLString(str, baseURL: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
