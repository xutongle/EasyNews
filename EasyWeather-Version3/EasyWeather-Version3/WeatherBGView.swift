//
//  WeatherBGView.swift
//  EasyWeather-Version3
//
//  Created by mac_zly on 2016/10/16.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class WeatherBGView: UIView {
    
    static let weatherBGView = WeatherBGView(frame: UIScreen.main.bounds)
    
    //
    fileprivate var bgImageView: UIImageView!
    
    var bgImage: UIImage? {
        didSet{
            self.bgImageView.image = bgImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 背景大图
        self.bgImageView = UIImageView()
        self.bgImageView.image = bgImage
        self.bgImageView.clipsToBounds = true
        bgImageView.contentMode = .scaleAspectFill
        self.addSubview(bgImageView)
        
        
        let effect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: effect)
        visualEffectView.frame = UIScreen.main.bounds
        visualEffectView.alpha = 0.8
        self.bgImageView.addSubview(visualEffectView)
        
        self.addSubview(WeatherHeadView.weatherHeadView)
        self.addSubview(WeatherMainCenterTableView.weatherMainCenterTableView)
        self.addSubview(WeatherView.weatherView)
        
        WeatherView.weatherView.dataSourceArray = [
            ["date":"1994-12-19","week":"星期5","sun_rise_down":"10:00/11:00","temperature":"21/40"], ["date":"1994-12-19","week":"星期5","sun_rise_down":"10:00/11:00","temperature":"21/40"], ["date":"1994-12-19","week":"星期5","sun_rise_down":"10:00/11:00","temperature":"21/40"]]

        
    }
    
    override func layoutSubviews() {
        self.bgImageView.snp.makeConstraints { [weak self] (make) in
            make.left.right.top.bottom.equalTo(self!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
