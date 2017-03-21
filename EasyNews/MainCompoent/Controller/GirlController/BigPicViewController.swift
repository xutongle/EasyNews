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
    weak var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let f = self.view.frame
        let imageScrollView = ImageScrollView(frame: f, imageUrl: [url])
        self.view.addSubview(imageScrollView)        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

}
