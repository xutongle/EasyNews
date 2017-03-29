//
//  BigPicViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2017/2/8.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class BigPicViewController: UIViewController {
    
    // model
    var url: String!
    
    var imageScrollView: ImageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        imageScrollView = ImageScrollView(frame: self.view.frame, imageUrl: [url])
        view.addSubview(imageScrollView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // - -
    deinit {
//        imageScrollView.removeFromSuperview()
//        self.view.removeFromSuperview()
//        imageScrollView = nil
//        self.view = nil
    }
    
}
