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
            return UITableViewCell()
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return SETTING_CELL_HEIGHT
    }
    
}
