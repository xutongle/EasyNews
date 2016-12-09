//
//  TodayView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class TodayView: UIView {
    
    private var citylabel: UILabel!           // 城市名称
    private var updateTimeButton: UIButton!   // 更新时间
    private var temperatureLabel: UILabel!    // 当前温度
    private var weatherStateIV: UIImageView!  // 文字对应的图片
    private var text_dayLabel: UILabel!       // 白天天气现象文字
    private var highLabel: UILabel!           // 当天最高温度
    private var lowLabel: UILabel!            // 当天最低温度
    private var wind_speedLabel: UILabel!     // 风力等级
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        citylabel = UILabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
