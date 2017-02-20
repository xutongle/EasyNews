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
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageScrollView = ImageScrollView(frame: self.view.frame, imageUrl: [url])
        self.view.addSubview(imageScrollView)        
    }

}
