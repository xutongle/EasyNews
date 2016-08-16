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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = DARK_GRAY
        self.selectionStyle = .None
        self.accessoryType = .DisclosureIndicator
        
        let titleLabel = UILabel(frame: CGRectMake(15, 0, SCREEN_WIDTH / 5 * 4 - 80, SETTING_CELL_HEIGHT))
        titleLabel.backgroundColor = DARK_GRAY
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "天气提醒(请往设置开启或者关闭):"
        titleLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(titleLabel)
        
        turnOnOrOffNotifation = UISwitch(frame: CGRectMake(SCREEN_WIDTH / 5 * 4 - 51, (SETTING_CELL_HEIGHT - 31) / 2, 51, 31))
        turnOnOrOffNotifation.addTarget(self, action: #selector(checkTurnOnOrOffNotifation), forControlEvents: .ValueChanged)
        self.addSubview(turnOnOrOffNotifation)
        turnOnOrOffNotifation.on = (Tools.getUserDefaults("TurnOnOrOffNotifation") as? Bool) == nil ? false : Tools.getUserDefaults("TurnOnOrOffNotifation") as! Bool
        SingleManager.singleManager.add(Key: "TurnOnOrOffNotifation", andValue: turnOnOrOffNotifation.on)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    func checkTurnOnOrOffNotifation(turnOnOrOffNotifation: UISwitch) -> Void {
        SingleManager.singleManager.add(Key: "TurnOnOrOffNotifation", andValue: turnOnOrOffNotifation.on)
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
