//
//  WeatherView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    private var topSpaceView: UIView!
    private var todayView: TodayView!
    private var tomorrowView: LastWeatherView!
    private var dayATView: LastWeatherView!
    
    var models: [WeatherModel] = [] {
        didSet{
            guard models.count >= 3 else { return }
            // 数据分发
            self.todayView.model = models[0]
            self.tomorrowView.model = models[1]
            self.dayATView.model = models[2]
        }
    }
    
    var todayViewModel: TodayViewModel = TodayViewModel() {
        didSet{
            self.todayView.todayViewModel = todayViewModel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.topSpaceView = UIView()
        self.todayView = TodayView()
        self.tomorrowView = LastWeatherView()
        self.dayATView = LastWeatherView()
        
        self.addSubview(topSpaceView)
        self.addSubview(todayView)
        self.addSubview(tomorrowView)
        self.addSubview(dayATView)
        
        self.topSpaceView.backgroundColor = #colorLiteral(red: 0.181648761, green: 0.3840782344, blue: 0.5875621438, alpha: 1)
        self.todayView.backgroundColor = #colorLiteral(red: 0.181648761, green: 0.3840782344, blue: 0.5875621438, alpha: 1)
        self.todayView.setInfoBG(color: #colorLiteral(red: 0.3978720903, green: 0.3872858286, blue: 0.811239779, alpha: 1))
        self.tomorrowView.backgroundColor = #colorLiteral(red: 0, green: 0.6040758491, blue: 0.3943479657, alpha: 1)
        self.tomorrowView.setInfoBG(color: #colorLiteral(red: 0, green: 0.6040758491, blue: 0.3943479657, alpha: 1))
        self.dayATView.backgroundColor = #colorLiteral(red: 1, green: 0.3950144053, blue: 0.385025084, alpha: 1)
        self.dayATView.setInfoBG(color: #colorLiteral(red: 1, green: 0.3950144053, blue: 0.385025084, alpha: 1))
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.topSpaceView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.right.equalTo(self)
            make.height.equalTo(20)
        }
        
        self.todayView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topSpaceView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT / 5 * 3 - 20)
        }
        
        self.tomorrowView.snp.makeConstraints { (make) in
            make.top.equalTo(self.todayView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT / 5)
        }
        
        self.dayATView.snp.makeConstraints { (make) in
            make.top.equalTo(self.tomorrowView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT / 5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
