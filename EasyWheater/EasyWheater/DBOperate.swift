//
//  DBOperate.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/25.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit
import SQLite

class DBOperate: NSObject {
    
    // 数据库连接对象
    var db: Connection!
    
    // 判断文件存不存在的路径
    var fielExitsStr:String!
    // 文件路径
    var filePath:String!
    
    // 字段
    var city:Expression<String>!
    var province:Expression<String>!
    
    // 表对象
    var city_list_table:Table!
    
    // 单利自己
    static let dbOperate = DBOperate()
    
    private override init() {
        super.init()
        
        createTable()
    }
    
    func createTable() -> Void {
        let fileName = "history.sqlite3"
        
        //沙盒目录
        let urlForDocument = Tools.fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask)
        
        //获得沙盒url
        let documentStr = NSString.init(format: "%@", urlForDocument[0])
        //用于判断文件存不存在
        fielExitsStr = documentStr.substringFromIndex(7) + fileName
        //文件路径
        filePath = (documentStr as String) + fileName
        
        // 当文件不存在时 创建数据库和表
        do {
            // 连接数据库 (不存在会自动创建)
            db = try Connection(filePath)
            // 字段对象
            city = Expression<String>("HISTRY_CITY")
            province = Expression<String>("HISTORY_PROVINCE")
            // 表对象
            city_list_table = Table("CITY_LIST")
            
            // 没有创建过表并且文件存在时 创建表
            if Tools.getUserDefaults("isCreateTable") == nil && NSFileManager.defaultManager().fileExistsAtPath(fielExitsStr) {
                
                queryData({ (backCitys) in
                    
                })
                // 创建表 (就一个表,两个字段)
                try db.run(city_list_table.create(block: { tableBuilder in
                    tableBuilder.column(city, primaryKey: true)
                    tableBuilder.column(province)
                }))
                Tools.setUserDefaults(key: "isCreateTable", andVluew: true)
            }else {
                print("创建过了表")
            }
        }catch {
            print("数据库操作出错\(error)")
        }
        print(documentStr)
    }
    
    // 查询数据
    func queryData(queryOver: (backCitys: NSDictionary) -> Void) -> NSMutableArray{
        let dataArray:NSMutableArray! = NSMutableArray()
        do {
            // 如果连文件都不存在就直接false
            if Tools.fileManager.fileExistsAtPath(fielExitsStr) {
                for citys in try db.prepare(city_list_table) {
                    let dict:Dictionary = ["city":citys[city],"province":citys[province]]
                    dataArray.addObject(dict)
                    queryOver(backCitys: dict)
                }
                return dataArray
            }else {
                print("Query:FileNotExist!!!")
                createTable()
            }
        } catch {
            print("queryDataError!!!\(error)")
        }
        return NSMutableArray()
    }
    
    // 插入数据
    func insertData(cityName: String, provinceName: String) -> Bool {
        // 如果连文件都不存在就直接false
        if !Tools.fileManager.fileExistsAtPath(fielExitsStr) {
            print("Insert:FileNotExist!!!")
            createTable()
            return false
        }
        //
        do {
            try db.run(city_list_table.insert(city <- cityName,province <- provinceName))
            
            return true
        } catch {
            print("insertDataError!!!", error)
            return false
        }
    }
    
    // 删除数据
    func deleteData(cityName: String) -> Bool {
        // 如果连文件都不存在就直接false
        if !Tools.fileManager.fileExistsAtPath(fielExitsStr) {
            print("Delete:FileNotExist!!!")
            createTable()
            return false
        }
        //
        do {
            let delete_dialog = city_list_table.filter(city == cityName)
            try db.run(delete_dialog.delete())
            
            return true
        } catch {
            print("deleteDataError!!!")
            return false
        }
    }
    
    // 查询数据是否存在
    func queryIsExitsData(cityName: String) -> Bool {
        if !Tools.fileManager.fileExistsAtPath(fielExitsStr) {
            print("queryIsExitsDataError!!!")
            createTable()
            return false
        }
        
        do {
            for citys in try db.prepare(city_list_table) {
                // 判断是否存在
                if citys.get(city) == cityName {
                    print("Find It")
                    return true
                }else {
                    print("dataNotExits!!!")
                }
            }
        } catch {
            print("queryExitsError!!!")
        }
        
        return false
    }
}
