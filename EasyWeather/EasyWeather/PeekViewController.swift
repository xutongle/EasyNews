//
//  PeekViewController.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/13.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

class PeekViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        
        let bg = UIImageView(frame: self.view.frame)
        bg.contentMode = .ScaleAspectFill
        self.view.addSubview(bg)
        bg.image = UIImage(named: "weather_temp")

        // 从沙盒中取到图片
        SaveImageToDocment.saveImageToDocment.getImage({ (image) in
            if image != nil {
                bg.image = nil
                bg.image = image
            }
        })
        
    }
    
    //MARK: ******************** 来自UIViewController *********************
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        let firstAction = UIPreviewAction(title: "暂时没什么用的按钮", style: .Default) { (previewAction, viewController) in
            //self.view.show("这是提示1", block: {})
        }
//        let secondAction = UIPreviewAction(title: "这是提示2", style: .Default) { (previewAction, viewController) in
//            self.view.show("这是提示2", block: {})
//        }
//        
//        let thirdAction = UIPreviewAction(title: "这是提示3", style: .Destructive) { (previewAction, viewController) in
//            self.view.show("这是提示3", block: {})
//        }
        
        // 塞到UIPreviewActionGroup中
        //let group1 = UIPreviewActionGroup(title: "第一组", style: .Default, actions: [firstAction, secondAction])
        //let group2 = UIPreviewActionGroup(title: "第二组", style: .Default, actions: [thirdAction])
        return [firstAction]
    }
    
}
