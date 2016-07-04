//
//  SettingTableView.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/25.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class SettingTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor(red:135/255.0, green:206/255.0, blue:235/255.0, alpha: 1)
        self.bounces = false
        self.tableHeaderView = UIView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("OtherSettingCell") as! OtherSettingCellTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
