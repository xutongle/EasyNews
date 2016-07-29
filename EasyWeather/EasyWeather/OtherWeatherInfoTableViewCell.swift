//
//  OtherWeatherInfoTableViewCell.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

class OtherWeatherInfoTableViewCell: UITableViewCell {
    
    var leftLabel: UILabel!
    var centerLabel: UILabel!
    var rightLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        
        leftLabel = UILabel.init(frame: CGRectMake(0, 0, SCREEN_WIDTH / 3, 60))
        leftLabel.textColor = UIColor.whiteColor()
        leftLabel.textAlignment = .Center
        leftLabel.text = "A"
        self.addSubview(leftLabel)
        
        centerLabel = UILabel.init(frame: CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3, 60))
        centerLabel.textColor = UIColor.whiteColor()
        centerLabel.textAlignment = .Center
        centerLabel.text = "B"
        self.addSubview(centerLabel)
        
        rightLabel = UILabel.init(frame: CGRectMake(SCREEN_WIDTH / 3 * 2, 0, SCREEN_WIDTH / 3, 60))
        rightLabel.textColor = UIColor.whiteColor()
        rightLabel.textAlignment = .Center
        rightLabel.text = "C"
        self.addSubview(rightLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        //画两条线
        let pathPen = UIBezierPath.init()
        
        //第一条
        pathPen.moveToPoint(CGPointMake(SCREEN_WIDTH / 3, 20))
        pathPen.addLineToPoint(CGPointMake(SCREEN_WIDTH / 3, 40))
        UIColor.whiteColor().setStroke()
        pathPen.lineWidth = 1
        pathPen.stroke()
        
        //第二条
        pathPen.moveToPoint(CGPointMake(SCREEN_WIDTH / 3 * 2, 20))
        pathPen.addLineToPoint(CGPointMake(SCREEN_WIDTH / 3 * 2, 40))
        pathPen.stroke()
    }
    
    // 初始化并复用这个cell
    static func getOtherWeatherInfoTableViewCell(tableview: UITableView) -> OtherWeatherInfoTableViewCell {
        let cellID = "OtherWeatherInfoTableViewCell"
        
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID) as? OtherWeatherInfoTableViewCell
        
        if cell == nil {
            cell = OtherWeatherInfoTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }
}
