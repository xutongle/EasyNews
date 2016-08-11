//
//  OtherInfoTableViewCell.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/11.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

// 其他的天气信息
class OtherInfoTableViewCell: UITableViewCell {

    //pollutionIndex 空气指数
    var washIndexLabel: UILabel!
    //airCondition 空气质量
    var airConditionLabel: UILabel!
    //dressingIndex 穿衣指数
    var dressingIndexLabel: UILabel!
    //exerciseIndex运动指数
    var exerciseIndexLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None

        washIndexLabel = UILabel(frame: CGRectMake(SCREEN_WIDTH / 3 - 80, 10, SCREEN_WIDTH * 2 / 3, 30))
        washIndexLabel.backgroundColor = UIColor.clearColor()
        washIndexLabel.textColor = WHITE_COLOR
        washIndexLabel.font = UIFont.systemFontOfSize(18)
        self.addSubview(washIndexLabel)
        
        exerciseIndexLabel = UILabel(frame: CGRectMake(SCREEN_WIDTH / 3 - 80, 50, SCREEN_WIDTH * 2 / 3, 30))
        exerciseIndexLabel.backgroundColor = UIColor.clearColor()
        exerciseIndexLabel.textColor = WHITE_COLOR
        exerciseIndexLabel.font = UIFont.systemFontOfSize(18)
        self.addSubview(exerciseIndexLabel)
        
        airConditionLabel = UILabel(frame: CGRectMake(SCREEN_WIDTH / 3 - 80, 90, SCREEN_WIDTH * 2 / 3, 30))
        airConditionLabel.backgroundColor = UIColor.clearColor()
        airConditionLabel.textColor = WHITE_COLOR
        airConditionLabel.font = UIFont.systemFontOfSize(18)
        self.addSubview(airConditionLabel)
        
        dressingIndexLabel = UILabel(frame: CGRectMake(SCREEN_WIDTH / 3 - 80, 130, SCREEN_WIDTH * 2 / 3, 30))
        dressingIndexLabel.backgroundColor = UIColor.clearColor()
        dressingIndexLabel.textColor = WHITE_COLOR
        dressingIndexLabel.font = UIFont.systemFontOfSize(18)
        self.addSubview(dressingIndexLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func getOtherInfoTableViewCell(tableview: UITableView) -> OtherInfoTableViewCell {
        let cellID = "OtherInfoTableViewCell"
        
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID) as? OtherInfoTableViewCell
        
        if cell == nil {
            cell = OtherInfoTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }
    
}
