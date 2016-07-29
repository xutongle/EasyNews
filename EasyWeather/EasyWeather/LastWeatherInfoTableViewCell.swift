//
//  LastWeatherInfoTableViewCell.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

class LastWeatherInfoTableViewCell: UITableViewCell {

    var dayLabel: UILabel!
    var weatherStateAndWeatherLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        dayLabel = UILabel.init(frame: CGRectMake(0, 0, SCREEN_WIDTH / 3, 40))
        dayLabel.textAlignment = .Center
        dayLabel.textColor = UIColor.whiteColor()
        dayLabel.text = "星期二"
        self.addSubview(dayLabel)
        
        weatherStateAndWeatherLabel = UILabel.init(frame: CGRectMake(SCREEN_WIDTH / 3 * 2, 0, SCREEN_WIDTH / 3, 40))
        weatherStateAndWeatherLabel.textAlignment = .Center
        weatherStateAndWeatherLabel.textColor = UIColor.whiteColor()
        weatherStateAndWeatherLabel.text = "晴 30-40"
        self.addSubview(weatherStateAndWeatherLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化并复用这个cell
    static func getLastWeatherInfoTableViewCell(tableview: UITableView) -> LastWeatherInfoTableViewCell {
        let cellID = "LastWeatherInfoTableViewCell"
        
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID) as? LastWeatherInfoTableViewCell
        
        if cell == nil {
            cell = LastWeatherInfoTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }
}
