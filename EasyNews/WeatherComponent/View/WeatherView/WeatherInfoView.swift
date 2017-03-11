//
//  WeatherInfoView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/10.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class WeatherInfoViewModel: NSObject {
    var text_day: String! = ""
    var high_text: String! = ""
    var low_text: String! = ""
    var wind_speed: String! = ""
    
    override init() {
        super.init()
    }
    
    init(text_day: String, high_text: String, low_text: String, wind_speed: String!) {
        super.init()
        self.text_day = text_day
        self.high_text = high_text
        self.low_text = low_text
        self.wind_speed = wind_speed
    }
    
}

// 天气信息
class WeatherInfoView: UIView {
    
    private var text_dayLabel: UILabel!       // 白天天气现象文字
    private var highLabel: UILabel!           // 当天最高温度
    private var lowLabel: UILabel!            // 当天最低温度
    private var wind_speedLabel: UILabel!     // 风力等级
    
    // 天气情况 最高地温度 风速
    var model: WeatherInfoViewModel = WeatherInfoViewModel() {
        didSet{
            self.text_dayLabel.text = model.text_day
            self.highLabel.text = "Max: " + model.high_text
            self.lowLabel.text = "Min: " + model.low_text
            self.wind_speedLabel.text = "风速" + model.wind_speed
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        text_dayLabel = UILabel()
        highLabel = UILabel()
        lowLabel = UILabel()
        wind_speedLabel = UILabel()
        
        self.addSubview(text_dayLabel)
        self.addSubview(highLabel)
        self.addSubview(lowLabel)
        self.addSubview(wind_speedLabel)
        
        self.text_dayLabel.setStyle("", bgColor: nil, color: WHITE, fontName: nil, textSize: 17, alignment: .center)
        self.highLabel.setStyle("", bgColor: nil, color: WHITE, fontName: nil, textSize: 15, alignment: .center)
        self.lowLabel.setStyle("", bgColor: nil, color: WHITE, fontName: nil, textSize: 15, alignment: .center)
        self.wind_speedLabel.setStyle("", bgColor: nil, color: WHITE, fontName: nil, textSize: 17, alignment: .center)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.text_dayLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
        
        self.highLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self.text_dayLabel.snp.right)
            make.width.equalTo(self.text_dayLabel.snp.width)
        }
        
        self.lowLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.highLabel.snp.bottom)
            make.left.equalTo(self.highLabel.snp.left)
            make.right.equalTo(self.highLabel.snp.right)
            make.bottom.equalTo(self)
            make.height.equalTo(self.highLabel.snp.height)
        }
        
        self.wind_speedLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.highLabel.snp.right)
            make.top.bottom.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(self.highLabel.snp.width)
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 1
        let offset = path.lineWidth / 2
        UIColor.white.setStroke()
        
        path.move(to: CGPoint(x: rect.width / 3 - offset, y: 10))
        path.addLine(to: CGPoint(x: rect.width / 3 - offset, y: rect.height - 10))
        
        path.move(to: CGPoint(x: rect.width / 3 * 2 - offset, y: 10))
        path.addLine(to: CGPoint(x: rect.width / 3 * 2 - offset, y: rect.height - 10))
        
        path.stroke()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
