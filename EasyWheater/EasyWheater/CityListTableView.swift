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
    
    // MARK: - ---------------------------生命周期-------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化tableview
        tableView = UITableView.init(frame: CGRectMake(0, 0, frame.size.width, frame.size.height), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        readFileToCityDict()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ------------------------自己的方法----------------------------
    
    func readFileToCityDict() -> Void {
        let filePath = NSBundle.mainBundle().pathForResource("citydict", ofType: "plist")
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(filePath!) {
            // 城市
            citysDict = NSDictionary.init(contentsOfFile: filePath!)
            // ABCD键
            citysKey = citysDict.allKeys as! Array<String>
            citysKey = citysKey.sort(<)
        }
        
    }
    
    // MARK: - -----------------------UITableViewDataSource----------------------------------
    
    // 每组有几行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let key = citysKey[section]
        let array = citysDict[key]
        return array!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = LocationTableViewCell.initTableViewCell(tableView)
        
        let key = citysKey[indexPath.section]
        let array = citysDict[key]
        let dict = array![indexPath.row]
        cell.textLabel?.text = dict["name"] as? String
        
        return cell
    }

    // 有多少组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return citysDict.count
    }
    
    // 头标题
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return citysKey[section]
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return citysKey
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let key = citysKey[indexPath.section]
        let array = citysDict[key]
        let dict = array![indexPath.row]
        let cityName = dict["name"] as? String
        
        // 去往 MainViewController
        backCityBlock(cityName: cityName!)
        
        //
        AddViewController.addViewController.dismissMe()
    }
    
}
