//
//  SearchTitleView.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/26.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

var backCityBlock: ((cityName: String) -> Void)!

class CityListTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView:UITableView! = nil
    private var citysDict:NSDictionary!
    private var citysKey:Array<String>!
    
    static let cityListTableView = CityListTableView.init(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64))
    
    // MARK: - ---------------------------生命周期-------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        readFileToCityDict()
        
        // 初始化tableview
        tableView = UITableView.init(frame: CGRectMake(0, 0, frame.size.width, frame.size.height), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.bounces = false
        
        // 头视图看起来和谐点
        let view = UIView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 15))
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        tableView.tableHeaderView = view
        
        tableView.tableFooterView = UIView()
        
        self.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ------------------------自己的方法----------------------------
    
    func readFileToCityDict() -> Void {
        // 城市
        citysDict = Tools.readPlist()
        if (citysDict != nil) {
            // ABCD键
            citysKey = citysDict.allKeys as! Array<String>
            citysKey = citysKey.sort(<)
        }else {
            citysKey = Array<String>()
        }
        
    }
    
    // MARK: - -----------------------UITableViewDataSource----------------------------------
    
    // 有多少组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return citysKey.count
    }
    
    // 每组有几行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let key = citysKey[section]
        let array = citysDict[key]
        return array!.count
    }
    
    // 配置cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = LocationTableViewCell.initTableViewCell(tableView)
        
        if citysDict != nil {
            let key = citysKey[indexPath.section]
            let array = citysDict[key] as! NSArray
            let dict = array[indexPath.row]
            cell.textLabel?.text = dict["name"] as? String
        }
        
        return cell
    }
    
    // 头标题
    //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "        " + citysKey[section] + "开头"
    //    }
    
    // 头标题高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    // 右边显示
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return citysKey
    }
    
    // 自定义头视图
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 20))
        let label = UILabel.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 20))
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.text = citysKey[section]
        view.addSubview(label)
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let key = citysKey[indexPath.section]
        let array = citysDict[key] as! NSArray
        let dict = array[indexPath.row]
        let cityName = dict["name"] as? String
        
        // 去往 MainViewController
        backCityBlock(cityName: cityName!)
        
        //
        AddViewController.addViewController.dismissMe()
    }
    
}
