//
//  PopViewController.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/14.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(frame: self.view.frame)
        bg.contentMode = .ScaleAspectFill
        self.view.addSubview(bg)
        
        bg.image = UIImage(named: "weather_temp")
        // 从沙盒中取到图片
        SaveImageToDocment.saveImageToDocment.getImage({ (image) in
            if image != nil {
                bg.image = image
            }
        })
        
        // 添加dissmiss的手势
        let gestrue = UISwipeGestureRecognizer.init(target: self, action: #selector(dissmissMe))
        gestrue.direction = .Down
        self.view.addGestureRecognizer(gestrue)
    }
    
    func dissmissMe() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
