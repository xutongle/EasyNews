//
//  SettingTableViewController.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/11.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

// 设置页面
class SettingTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    static let settinsgTableView = SettingTableView(frame: CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT), style: .Plain)
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = SETTING_BACKGROUND_COLOR
        
        self.separatorStyle = .None
        self.bounces = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SETTING_CELL_NUM
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return FrostedTableViewCell.getFrostedTableViewCell(tableView)
        case 1:
            return ChangeBackgroundTableViewCell.getChangeBackgroundTableViewCell(tableView)
        default:
            let cell = ChooseNotificationTimeTableViewCell.getChooseNotificationTimeTableViewCell(tableView)
            SingleManager.singleManager.add(Key: "ChooseNotificationTimeTableViewCell", andValue: cell)
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            // 开了通知才弹窗
            if Tools.getUserDefaults("TurnOnOrOffNotifation") != nil && Tools.getUserDefaults("TurnOnOrOffNotifation") as! Bool {
                let alerView = AlertViewWithDatePicker(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20))
                alerView.alpha = 0
                self.addSubview(alerView)
                UIView.animateWithDuration(0.25, animations: {
                    alerView.alpha = 1
                })
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return SETTING_CELL_HEIGHT
    }
    
}

// block
var chooseDateBlock: ((chooseDate: NSDate) -> Void)!

// 弹出日期选择的View
class AlertViewWithDatePicker: UIView {
    
    private var tipLabel: UILabel!
    var datePicker: UIDatePicker!
    var okButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = DARK_GRAY
        SettingViewController.settingViewController.okButton.alpha = 0
        
        datePicker = UIDatePicker(frame: CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT / 2))
        datePicker.datePickerMode = .Time
        
        datePicker.date = NSDate()
        self.addSubview(datePicker)
        
        tipLabel = UILabel(frame: CGRectMake(0, 20, SCREEN_WIDTH, 30))
        tipLabel.text = "您可前往设置开关通知或者在这修改提醒时间"
        tipLabel.textAlignment = .Center
        tipLabel.adjustsFontSizeToFitWidth = true
        tipLabel.textColor = UIColor.groupTableViewBackgroundColor()
        self.addSubview(tipLabel)
        
        // 覆盖掉设置的按钮
        okButton = UIButton(frame: CGRectMake(frame.width - 60, frame.height - 60, 50, 50))
        okButton.setImage(UIImage(named: "okBtn"), forState: .Normal)
        okButton.addTarget(self, action: #selector(confimAction), forControlEvents: .TouchUpInside)
        self.addSubview(okButton)
        
        let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(removeSelf))
        self.addGestureRecognizer(tapGestrue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confimAction() -> Void {
        
        let cell = SingleManager.singleManager.getValue(Key: "ChooseNotificationTimeTableViewCell") as! ChooseNotificationTimeTableViewCell
        let format = NSDateFormatter()
        format.setLocalizedDateFormatFromTemplate("HH:mm:ss")
        let dataString = format.stringFromDate(datePicker.date)
        cell.showText = dataString
        
        Tools.setUserDefaults(key: "Notification_Time", andValue: dataString)
        NSNotificationCenter.defaultCenter().postNotificationName("CHANGE_NOTIFICATION", object: nil)
        removeSelf()
    }
    
    func removeSelf() -> Void {
        SettingViewController.settingViewController.okButton.alpha = 1
        self.removeFromSuperview()
    }
}
