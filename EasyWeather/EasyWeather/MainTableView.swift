//
//  MainTableView.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

class MainTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // 存放天气信息
    var weatherInfoDict: NSMutableDictionary!
    // 存放其他天气信息
    var otherWeatherInfoDict: NSMutableDictionary!
    // 存放后续几天的天气信息（简单）
    var lastdayWeatherInfo: NSMutableArray!
    // 存放其他信息
    var otherInfoDict: NSMutableDictionary!
    
    // MARK: - －－－－－－－－－－－－－－－－－ 生命周期 －－－－－－－－－－－－－－－－－
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = .None
        self.bounces = false
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -------------------------tableView协议-------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if weatherInfoDict == nil {
            return 0
        }
        return 6
    }
    
    
    // MARK: - ---------------------------UITableViewDataSource---------------------------
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        switch indexPath.row {
        case 0:
            let cell = WeatherInfoTableViewCell.getWheatherInfoTableViewCell(tableView)
            cell.weatherValueBtn.setTitle(weatherInfoDict["temperature_now"] as? String, forState: .Normal)
            cell.maxminTemperatureLabel.text = weatherInfoDict["temperature_future"] as? String
            
            let state = weatherInfoDict["weather"] as? String
            cell.weatherStateLabel.text = state
            cell.weatherIconImageView.image = UIImage.init(named: state!)
            return cell
        case 1:
            let cell: OtherWeatherInfoTableViewCell = OtherWeatherInfoTableViewCell.getOtherWeatherInfoTableViewCell(tableView)
            cell.leftLabel.text = otherWeatherInfoDict["humidity"] as? String
            cell.centerLabel.text = otherWeatherInfoDict["wind"] as? String
            cell.rightLabel.text = otherWeatherInfoDict["coldIndex"] as? String
            return cell
        case 2:
            let cell: LastWeatherInfoTableViewCell = LastWeatherInfoTableViewCell.getLastWeatherInfoTableViewCell(tableView)
            let dict =  lastdayWeatherInfo[indexPath.row - 2] as! NSDictionary
            cell.dayLabel.text = dict["week"] as? String
            cell.weatherStateAndWeatherLabel.text = (dict["dayTime"] as! String) + "  " + (dict["temperature"] as! String)
            return cell
        case 3:
            let cell: LastWeatherInfoTableViewCell = LastWeatherInfoTableViewCell.getLastWeatherInfoTableViewCell(tableView)
            let dict =  lastdayWeatherInfo[indexPath.row - 2] as! NSDictionary
            cell.dayLabel.text = dict["week"] as? String
            cell.weatherStateAndWeatherLabel.text = (dict["dayTime"] as! String) + "  " + (dict["temperature"] as! String)
            return cell
        case 4:
            let cell: LastWeatherInfoTableViewCell = LastWeatherInfoTableViewCell.getLastWeatherInfoTableViewCell(tableView)
            let dict =  lastdayWeatherInfo[indexPath.row - 2] as! NSDictionary
            cell.weatherStateAndWeatherLabel.text = (dict["dayTime"] as! String) + "  " + (dict["temperature"] as! String)
            cell.dayLabel.text = dict["week"] as? String
            return cell
        default:
            let cell: OtherInfoTableViewCell = OtherInfoTableViewCell.getOtherInfoTableViewCell(tableView)
            
            cell.washIndexLabel.text = "洗车适宜:" + (otherInfoDict["washIndex"] as! String)
            cell.airConditionLabel.text = "空气质量:" + (otherInfoDict["airCondition"] as! String)
            cell.dressingIndexLabel.text = "穿衣指数:" + (otherInfoDict["dressingIndex"] as! String)
            cell.exerciseIndexLabel.text = "运动指数:" + (otherInfoDict["exerciseIndex"] as! String)
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 115
        case 1:
            return 60
        case 2:
            return 40
        case 3:
            return 40
        case 4:
            return 40
        default:
            return 160
        }
    }
}



