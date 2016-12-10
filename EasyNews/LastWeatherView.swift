//
//  LastWeatherView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/10.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class LastWeatherView: UIView {
    
    private var weatherStateIV: UIImageView!  // 文字对应的图片
    private var timeButton: UIButton!         // 时间
    private var weatherInfoView: WeatherInfoView! // 天气信息
    
    // 标准model
    var model: WeatherModel = WeatherModel() {
        didSet{
            self.weatherStateIV.image = UIImage(named: NetTool.toString(any: model.textDay))
            self.timeButton.setTitle(NetTool.toString(any: model.date), for: .normal)
            self.weatherInfoView.model = WeatherInfoViewModel(
                text_day: NetTool.toString(any: model.textDay),
                high_text: NetTool.toString(any: model.high),
                low_text: NetTool.toString(any: model.low),
                wind_speed: NetTool.toString(any: model.windSpeed)
            )
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        weatherStateIV = UIImageView()
        timeButton = UIButton()
        weatherInfoView = WeatherInfoView()
        
        self.addSubview(weatherInfoView)
        self.addSubview(timeButton)
        self.addSubview(weatherStateIV)

        self.weatherStateIV.image = #imageLiteral(resourceName: "晴")
        self.weatherStateIV.contentMode = .scaleAspectFit
        timeButton.setStyle(Date().toString(formatString: "yyyy-MM-dd"), bgColor: nil, textSize: 21, color: WHITE)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.weatherStateIV.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(frame.height / 2)
        }
        
        self.timeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.weatherStateIV.snp.right).offset(-10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self.weatherStateIV.snp.top)
        }
        
        self.weatherInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeButton.snp.left)
            make.top.equalTo(self.timeButton.snp.bottom).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT / 8)
        }
        
    }
    
    func setInfoBG(color: UIColor) -> Void {
        self.weatherInfoView.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
