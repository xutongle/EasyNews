//
//  MainTableView.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

class MainTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

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
        // 改变这个就行了（总共多少个cell）
        let cellCount = 5
        
        //Tools.setUserDefaults(key: "CellCount", andVluew: cellCount - 2)
        return cellCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        switch indexPath.row {
        case 0:
            return WeatherInfoTableViewCell.getWheatherInfoTableViewCell(tableView)
        case 1:
            return OtherWeatherInfoTableViewCell.getOtherWeatherInfoTableViewCell(tableView)
        default:
            return LastWeatherInfoTableViewCell.getLastWeatherInfoTableViewCell(tableView)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 115
        case 1:
            return 60
        default:
            return 40
        }
    }
}
