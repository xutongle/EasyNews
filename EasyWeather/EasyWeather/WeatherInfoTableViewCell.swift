//
//  WeatherInfoTableViewCell.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

// 主要天气信息
class WeatherInfoTableViewCell: UITableViewCell {

    // 天气图标
    var weatherIconImageView: UIImageView!
    // 当前天气温度
    var weatherValueBtn: UIButton!
    // 当天最高/最低温度
    var maxminTemperatureLabel: UILabel!
    // 当前最低温度
    //private var minTemperatureLabel: UILabel!
    // 当前天气状态 和天气图标对应，比如 多云 等
    var weatherStateLabel: UILabel!
    // 体感温度（暂时未写）
    var feelTemperatureLabel: UILabel!
    
    //
    override private init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        
        // 当前天气温度 高和宽
        let weatherValueBtnHeigh: CGFloat = 80
        let weatherValueBtnWidth = SCREEN_WIDTH / 3
        // 天气图标大小
        let weatherIconImageViewWidth = SCREEN_WIDTH / 8
        // 当天最高/最低温度宽度
        let maxminTemperatureLabelWidth: CGFloat = 80
        // 当前天气状态 宽度
        let weatherStateLabelWidth = SCREEN_WIDTH
        // 体感温度 宽度
        let feelTemperatureLabelWidth = SCREEN_WIDTH
        
        // 当前天气温度
        weatherValueBtn = UIButton.init(frame: CGRectMake((SCREEN_WIDTH - weatherValueBtnWidth) / 2, 0, weatherValueBtnWidth, weatherValueBtnHeigh))
        weatherValueBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        weatherValueBtn.setTitle("23°", forState: .Normal)
        weatherValueBtn.titleLabel?.font = UIFont(name: "InputMono-Light", size: 45)
        weatherValueBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        self.addSubview(weatherValueBtn)
        
        // 天气图标
        weatherIconImageView = UIImageView.init(frame: CGRectMake((SCREEN_WIDTH - weatherValueBtnWidth) / 2 - weatherIconImageViewWidth, 30, weatherIconImageViewWidth, 35))
        weatherIconImageView.clipsToBounds = true
        weatherIconImageView.contentMode = .ScaleAspectFit
        self.addSubview(weatherIconImageView)
        
        // 当天最高/最低温度
        let rect = CGRectMake((SCREEN_WIDTH - weatherValueBtnWidth) / 2 + weatherValueBtnWidth - 5, 0, maxminTemperatureLabelWidth, weatherValueBtnHeigh)
        maxminTemperatureLabel = My_Label(frame: rect, title: nil, bgColor: nil, textColor: WHITE_COLOR, textFontName: nil, textSize: 14, textPostion: .Center)
        maxminTemperatureLabel.numberOfLines = 0
        self.addSubview(maxminTemperatureLabel)
        
        // 当前天气状态 和天气图标对应，比如 多云 等
        weatherStateLabel = My_Label(frame: CGRectMake(0, weatherValueBtnHeigh, weatherStateLabelWidth, 15), title: nil, bgColor: nil, textColor: WHITE_COLOR, textFontName: nil, textSize: 15, textPostion: .Center)
        self.addSubview(weatherStateLabel)
        
        // 体感温度（暂时未写）
        feelTemperatureLabel = My_Label(frame: CGRectMake(0, weatherValueBtnHeigh + 20, feelTemperatureLabelWidth, 15), title: "体感温度 40°C", bgColor: nil, textColor: UIColor.whiteColor().colorWithAlphaComponent(0.5), textFontName: nil, textSize: 14, textPostion: .Center)
        self.addSubview(feelTemperatureLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化并复用这个cell
    static func getWheatherInfoTableViewCell(tableview: UITableView) -> WeatherInfoTableViewCell {
        let cellID = "WeatherInfoTableViewCell"
        
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID) as? WeatherInfoTableViewCell
        
        if cell == nil {
            cell = WeatherInfoTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }

}
