//
//  SearchView.swift
//  EasyWheater
//
//  Created by zly.private on 16/7/14.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

var searchChooseCityBlock: ((cityName: String) -> Void)!

class SearchView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray: NSMutableArray? = NSMutableArray()
    var tableview: UITableView!
    
    static let searchView = SearchView.init(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableview = UITableView.init(frame: CGRectMake(0, 0, frame.size.width, frame.size.height), style: .Plain)
        self.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview?.separatorInset = UIEdgeInsetsZero
        tableview?.layoutMargins = UIEdgeInsetsZero
        
        tableview.bounces = false
        tableview.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        tableview.tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if dataArray == nil {
            return 0
        }else {
            return dataArray!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = SearchTableViewCell.initTableView(WithTableView: tableView)
        
        if dataArray != nil {
            cell.textLabel?.text = dataArray![indexPath.row] as? String
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let chooseCity = dataArray![indexPath.row] as! String
        
        // 去往AddViewController (按下搜索时的cell)
        searchChooseCityBlock(cityName: chooseCity)
    }
}
