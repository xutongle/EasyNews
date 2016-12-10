//
//  TodayView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class TodayViewModel: NSObject {
    var cityName: String! = ""
    var temperature: String! = ""
    
    override init() {
        super.init()
    }
    
    init(cityName: String, temperature: String) {
        super.init()
        self.cityName = cityName
        self.temperature = temperature
    }
}

class TodayView: UIView {
    
    private var citylabel: UILabel!           // 城市名称
    private var updateTimeButton: UIButton!   // 更新时间
    private var temperatureLabel: UILabel!    // 当前温度
    private var weatherStateIV: UIImageView!  // 文字对应的图片
    private var weatherInfoView: WeatherInfoView! // 天气信息
    
    // 标准model
    var model: WeatherModel = WeatherModel() {
        didSet{
            self.updateTimeButton.setTitle(NetTool.toString(any: model.date), for: .normal)
            self.updateTimeButton.setTitle(NetTool.toString(any: model.date), for: .normal)
            self.weatherStateIV.image = UIImage(named: NetTool.toString(any: model.textDay))
            self.weatherInfoView.model = WeatherInfoViewModel(
                text_day: NetTool.toString(any: model.textDay),
                high_text: NetTool.toString(any: model.high),
                low_text: NetTool.toString(any: model.low),
                wind_speed: NetTool.toString(any: model.windSpeed)
            )
        }
    }
    
    // 天气和地区
    var todayViewModel: TodayViewModel = TodayViewModel() {
        didSet{
            self.citylabel.text = todayViewModel.cityName
            self.temperatureLabel.text = todayViewModel.temperature + "°"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        citylabel = UILabel()
        updateTimeButton = UIButton()
        temperatureLabel = UILabel()
        weatherStateIV = UIImageView()
        weatherInfoView = WeatherInfoView()
        
        self.addSubview(citylabel)
        self.addSubview(updateTimeButton)
        self.addSubview(temperatureLabel)
        self.addSubview(weatherStateIV)
        self.addSubview(weatherInfoView)
        
        self.citylabel.setStyle("深圳", bgColor: nil, color: WHITE, fontName: nil, textSize: 23, alignment: .center)
        self.updateTimeButton.setStyle(Date().toString(formatString: "yyyy-MM-dd"), bgColor: nil, textSize: 15, color: WHITE)
        self.temperatureLabel.setStyle("15°", bgColor: nil, color: WHITE, fontName: nil, textSize: 140, alignment: .center)
        
        self.weatherStateIV.image = #imageLiteral(resourceName: "晴")
        self.weatherStateIV.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.citylabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(40 * WScale)
            make.height.lessThanOrEqualTo(self.self.temperatureLabel.snp.height)
        }
        
        self.updateTimeButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-5)
            make.lastBaseline.equalTo(self.citylabel)
        }
        
        self.temperatureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.citylabel.snp.bottom)
            make.centerX.equalTo(self)
        }
        
        self.weatherStateIV.snp.makeConstraints { (make) in
            make.lastBaseline.equalTo(self.temperatureLabel.snp.lastBaseline)
            make.left.equalTo(self.temperatureLabel.snp.right)
            make.right.equalTo(self).offset(10)
        }
        
        self.weatherInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.temperatureLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT / 7)
        }
        
    }
    
    func setInfoBG(color: UIColor) -> Void {
        self.weatherInfoView.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
