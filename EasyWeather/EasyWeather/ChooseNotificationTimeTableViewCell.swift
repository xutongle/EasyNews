//
//  ChooseNotificationTimeTableViewCell.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/16.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

// 选择通知时间
class ChooseNotificationTimeTableViewCell: UITableViewCell {
    
    private var turnOnOrOffNotifation: UISwitch!
    private var titleLabel: UILabel!
    
    // titleLabel的值
    var showText: String! {
        didSet{
            if Tools.getUserDefaults("TurnOnOrOffNotifation") != nil && Tools.getUserDefaults("TurnOnOrOffNotifation") as! Bool {
                titleLabel.text = "天气提醒:" + showText.subStringWith(start: 0, end: 3)
            }else {
                titleLabel.text = showText
            }
        }
    }
    
    // turnOnOrOffNotifation的值
    var turnOnOrOffNotifationValue: Bool! {
        didSet{
            turnOnOrOffNotifation.on = turnOnOrOffNotifationValue
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = DARK_GRAY
        self.selectionStyle = .None
        self.accessoryType = .DisclosureIndicator
        
        titleLabel = My_Label(frame: CGRectMake(15, 0, SCREEN_WIDTH / 5 * 4 - 80, SETTING_CELL_HEIGHT), title: nil, bgColor: DARK_GRAY, textColor: WHITE_COLOR, textFontName: nil, textSize: 14, textPostion: .Center)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        if Tools.getUserDefaults("TurnOnOrOffNotifation") != nil && Tools.getUserDefaults("TurnOnOrOffNotifation") as! Bool {
            showText = Tools.getUserDefaults("Notification_Time") == nil ? "天气提醒:08:00:00" : "天气提醒:" + (Tools.getUserDefaults("Notification_Time") as! String)
            showText = showText.subStringWith(start: 0, end: 3)
        }else {
            showText = "未开通知提醒"
        }

        titleLabel.text = showText

        self.addSubview(titleLabel)
        
        turnOnOrOffNotifation = UISwitch(frame: CGRectMake(SCREEN_WIDTH / 5 * 4 - 51, (SETTING_CELL_HEIGHT - 31) / 2, 51, 31))
        turnOnOrOffNotifation.userInteractionEnabled = false
        self.addSubview(turnOnOrOffNotifation)
        turnOnOrOffNotifation.on = Tools.getUserDefaults("TurnOnOrOffNotifation") != nil ? Tools.getUserDefaults("TurnOnOrOffNotifation") as! Bool : false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化并复用这个cell
    static func getChooseNotificationTimeTableViewCell(tableview: UITableView) -> ChooseNotificationTimeTableViewCell {
        let cellID: String = "ChooseNotificationTimeTableViewCell"
        
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID) as? ChooseNotificationTimeTableViewCell
        
        if cell == nil {
            cell = ChooseNotificationTimeTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }
}
