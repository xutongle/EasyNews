//
//  MainTableView.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/16.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

//tableview
private let tableview = MainTableView.init(frame: CGRectMake(0, heandViewHeight + 20, SCREEN_WIDTH, mainTabbleViewHeight), style: .Plain)

// MARK: -------------------------extension-------------------------------

extension UIViewController {
    func getTableView() -> Void {
        tableview.backgroundColor = UIColor.clearColor()
        
        //下划线取消
        tableview.separatorStyle = .None
        
        self.view.addSubview(tableview)
    }
    
    func getMe() -> MainTableView {
        return tableview
    }
}

// MARK: -------------------------主类-------------------------------

class MainTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    //cellID
    let WEATHER_CELL_ID = "WheaterCell"
    let ANOTHER_INFO_CELL_ID = "AnotherInfoCell"
    let LATER_WEATHER_CELL = "LaterCell"

    // MARK: -------------------------生命周期-------------------------------
    
    private override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .None
        
        //签协议
        self.delegate = self
        self.dataSource = self
        
        //不要滚动
        self.bounces = false
        
        //代码写所以要注册CELL
        registerCell();
    }
    
    // MARK: -------------------------自己的方法-------------------------------
    
    func registerCell() -> Void {
        self.registerNib(UINib.init(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WEATHER_CELL_ID)
        self.registerNib(UINib.init(nibName: "AnotherInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ANOTHER_INFO_CELL_ID)
        self.registerNib(UINib.init(nibName: "LaterWeatherCell", bundle: nil), forCellReuseIdentifier: LATER_WEATHER_CELL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -------------------------tableView协议-------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        // 改变这个就行了
        let cellCount = 5
        
        Tools.setUserDefaults(key: "CellCount", andVluew: cellCount - 2)
        return cellCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(WEATHER_CELL_ID) as! WeatherTableViewCell
            SingleManager.singleManager.add(Key: "WeatherCell", andValue: cell)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(ANOTHER_INFO_CELL_ID) as! AnotherInfoTableViewCell
            //把cell添加进全局变量
            SingleManager.singleManager.add(Key: "AnotherCell", andValue: cell)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(LATER_WEATHER_CELL) as! LaterWeatherCell
            
            //根据indexpath.row组合
            let strLaterCell = String.init(format: "LaterCell%d", indexPath.row - 1)
            SingleManager.singleManager.add(Key: strLaterCell, andValue: cell)
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 105
        case 1:
            return 60
        default:
            return 40
        }
    }
}
