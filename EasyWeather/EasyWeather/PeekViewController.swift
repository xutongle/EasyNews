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
        
        let label = UILabel(frame: CGRectMake(0, SCREEN_HEIGHT / 2 - 20,SCREEN_WIDTH, 40))
        label.textAlignment = .Center
        label.textColor = WHITE_COLOR
        label.text = "3D Touch Test"
        self.view.addSubview(label)
        
    }

    //MARK: ******************** 来自UIViewController *********************
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        let firstAction = UIPreviewAction(title: "这是提示1", style: .Default) { (previewAction, viewController) in
            print("firstAction")
        }
        let secondAction = UIPreviewAction(title: "这是提示2", style: .Default) { (previewAction, viewController) in
            print("secondAction")
        }
        
        let thirdAction = UIPreviewAction(title: "这是提示3", style: .Destructive) { (previewAction, viewController) in
            print("thirdAction")
        }
        
        // 塞到UIPreviewActionGroup中
        let group1 = UIPreviewActionGroup(title: "Default", style: .Default, actions: [firstAction, secondAction])
        let group2 = UIPreviewActionGroup(title: "Destructive", style: .Default, actions: [thirdAction])
        return [group1, group2]
    }
    
}
