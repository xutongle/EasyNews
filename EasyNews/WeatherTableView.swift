//
//  WeatherView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class WeatherTableView: UIView {
    
    var models: [WeatherModel] = []
    
    private var topSpaceView: UIView!
    private var todayView: TodayView!
    private var tomorrowView: UIView!
    private var dayATView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.todayView = TodayView()
        self.tomorrowView = UIView()
        self.dayATView = UIView()
        self.topSpaceView = UIView()
        
        self.addSubview(topSpaceView)
        self.addSubview(todayView)
        self.addSubview(tomorrowView)
        self.addSubview(dayATView)
        
        self.topSpaceView.backgroundColor = #colorLiteral(red: 0.1892951131, green: 0.3956444263, blue: 0.6074239612, alpha: 1)
        self.todayView.backgroundColor = #colorLiteral(red: 0.1892951131, green: 0.3956444263, blue: 0.6074239612, alpha: 1)
        self.tomorrowView.backgroundColor = #colorLiteral(red: 0.1396533847, green: 0.7808837295, blue: 0.5760399103, alpha: 1)
        self.dayATView.backgroundColor = #colorLiteral(red: 1, green: 0.3950144053, blue: 0.385025084, alpha: 1)
        
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
