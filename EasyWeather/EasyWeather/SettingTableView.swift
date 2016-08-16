//
//  SettingTableViewController.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/11.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

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
            return ChooseNotificationTimeTableViewCell.getChooseNotificationTimeTableViewCell(tableView)
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            let alerView = AlertViewWithDatePicker(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
            alerView.alpha = 0
            self.addSubview(alerView)
            UIView.animateWithDuration(0.25, animations: { 
                alerView.alpha = 1
            })
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return SETTING_CELL_HEIGHT
    }
    
}

var chooseDateBlock: ((chooseDate: NSDate) -> Void)!

// 弹出日期选择
class AlertViewWithDatePicker: UIView {
    var datePicker: UIDatePicker!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        
        datePicker = UIDatePicker(frame: CGRectMake(0, SCREEN_HEIGHT / 4 - 100, SCREEN_WIDTH, SCREEN_HEIGHT / 2))
        datePicker.datePickerMode = .Time
        datePicker.date = NSDate()
        self.addSubview(datePicker)

        let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(confimAction))
        self.addGestureRecognizer(tapGestrue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func confimAction() -> Void {
        self.removeFromSuperview()
        //chooseDateBlock(chooseDate: datePicker.date)
    }
    
}
