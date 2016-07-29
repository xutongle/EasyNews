//
//  MainViewController.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var slidingView: SlidingView!
    
    // 重写方法让那个状态栏变白
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let background = BackgroundImageView.backgroundImageView
        background.weather = "多云"
        self.view.addSubview(background)
        
        let topView = TopView(frame: CGRectMake(0, 20, SCREEN_WIDTH, 44))
        self.view.addSubview(topView)
        
        let mainTableView = MainTableView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64), style: .Plain)
        self.view.addSubview(mainTableView)
        
        slidingView = self.view.addSlidingView_zly()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // TopView
        btnAction = {whichButton in
            switch whichButton {
            case .isDrawUpButton:
                // 打开侧滑
                self.slidingView.toggleSldingView(true)
                break
            case .isLocationButton:
                break
            case .isAddLocationButton:
                break
            }
        }
        
        // 设置按钮回掉
        setttingBlock = {
            
        }
    }

}
