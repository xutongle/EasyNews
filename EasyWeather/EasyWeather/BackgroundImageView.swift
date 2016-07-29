//
//  BackgroundImageView.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/13.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class BackgroundImageView: UIImageView {
    
    static let backgroundImageView = BackgroundImageView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
    
    var visualView:UIVisualEffectView!
    
    var weather: String! {
        didSet{
            changeBackground()
        }
    }
    
    // 透明度值的监听
    var blurValue:Float! = Tools.getUserDefaults("isBlur") != nil ? Tools.getUserDefaults("isBlur") as! Float : 0.5{
        didSet{
            visualView.alpha = 1
            visualView.alpha = CGFloat(blurValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .ScaleAspectFill
        
        //毛玻璃效果
        let blurEffect = UIBlurEffect.init(style: .Dark)
        //毛玻璃view
        visualView = UIVisualEffectView.init(effect: blurEffect)
        //设置毛玻璃view的视图
        visualView.frame = frame
        
        visualView.alpha = 1
        visualView.alpha = CGFloat(blurValue)
        
        //添加到背景上
        self.addSubview(visualView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeBackground() -> Void {
        switch weather {
        case "多云":
            self.image = UIImage.init(named: "weather_temp")

            break
        default:
            break
        }
    }
    
}
