//
//  DBOperaCityList.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/11.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit
import SQLite

class DBOperaCityList: NSObject {
    
    // 数据库连接对象
    private var db: Connection!
    
    // 数据库路径
    private var databasePath: String!
    //
    static let dbOperaCityList = DBOperaCityList()
    var isCreate = false
    
    // 字段
    var city: Expression<String>!
    var province: Expression<String>!
    var temperature_now: Expression<String>!
    var weather: Expression<String>!
    var temperature_future: Expression<String>!
    var wind: Expression<String>!
    var humidity: Expression<String>!
    var coldIndex: Expression<String>!
    var week1: Expression<String>!
    var week2: Expression<String>!
    var week3: Expression<String>!
    var dayTime1: Expression<String>!
    var dayTime2: Expression<String>!
    var dayTime3: Expression<String>!
    var temperature1: Expression<String>!
    var temperature2: Expression<String>!
    var temperature3: Expression<String>!
    var washIndex: Expression<String>!
    var airCondition: Expression<String>!
    var dressingIndex: Expression<String>!
    var exerciseIndex: Expression<String>!
    
    // 表对象
    var weather_list_table: Table!
    
    override init() {
        super.init()
        if (Tools.getUserDefaults("isCreateTable") != nil) {
            isCreate = Tools.getUserDefaults("isCreateTable") as! Bool
        }
        
        self.createDB()
    }
    
    // ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊  创建数据库和表部分  ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    
    private func createDB() -> Void {
        
        let fileManager = NSFileManager.defaultManager()
        // 沙盒路径
        let urlForDocument = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let strForDocument = urlForDocument[0].absoluteString as NSString
        // 裁剪
        databasePath = (strForDocument.substringFromIndex(7) as String) + "WeatherCache.sqlite3"
        
        city = Expression<String>("city")
        province = Expression<String>("province")
        temperature_now = Expression<String>("temperature_now")
        weather = Expression<String>("weather")
        temperature_future = Expression<String>("temperature_future")
        wind = Expression<String>("wind")
        humidity = Expression<String>("humidity")
        coldIndex = Expression<String>("coldIndex")
        week1 = Expression<String>("week1")
        week2 = Expression<String>("week2")
        week3 = Expression<String>("week3")
        dayTime1 = Expression<String>("dayTime1")
        dayTime2 = Expression<String>("dayTime2")
        dayTime3 = Expression<String>("dayTime3")
        temperature1 = Expression<String>("temperature1")
        temperature2 = Expression<String>("temperature2")
        temperature3 = Expression<String>("temperature3")
        washIndex = Expression<String>("washIndex")
        airCondition = Expression<String>("airCondition")
        dressingIndex = Expression<String>("dressingIndex")
        exerciseIndex = Expression<String>("exerciseIndex")
        
        // 表对象
        weather_list_table = Table("weather_list")
        
        print(databasePath)
        
        do {
            // 连接数据库 (不存在会自动创建)
            db = try Connection(databasePath)
            
            if fileManager.fileExistsAtPath(databasePath) {
                print("文件存在可以创建")
                if Tools.getUserDefaults("isCreateTable") != nil {
                    print("上次创建过表,不一定成功")
                    if (Tools.getUserDefaults("isCreateTable") as! Bool) != true {
                        
                        print("开始创建2")
                        createIt()
                    } else{
                        print("上次创建过表,一定成功")
                    }
                }else {
                    print("开始创建1")
                    createIt()
                }
            }else {
                print("文件不存在，无法创建表")
            }
        }catch {
            print("打开数据库异常:\(error)")
        }
    }
    
    private func createIt() -> Void {
        if Tools.getUserDefaults("isCreateTable") != nil {
            if Tools.getUserDefaults("isCreateTable") as! Bool { return }
        }
        do {
            // 创建表
            try db.run(weather_list_table.create(block: { (tableBuilder) in
                tableBuilder.column(city, primaryKey: true)
                tableBuilder.column(province)
                tableBuilder.column(temperature_now)
                tableBuilder.column(weather)
                tableBuilder.column(temperature_future)
                tableBuilder.column(wind)
                tableBuilder.column(humidity)
                tableBuilder.column(coldIndex)
                tableBuilder.column(week1)
                tableBuilder.column(week2)
                tableBuilder.column(week3)
                tableBuilder.column(dayTime1)
                tableBuilder.column(dayTime2)
                tableBuilder.column(dayTime3)
                tableBuilder.column(temperature1)
                tableBuilder.column(temperature2)
                tableBuilder.column(temperature3)
                tableBuilder.column(washIndex)
                tableBuilder.column(airCondition)
                tableBuilder.column(dressingIndex)
                tableBuilder.column(exerciseIndex)
            }))
            Tools.setUserDefaults(key: "isCreateTable", andVluew: true)
            print("创建完成")
        }catch {
            Tools.setUserDefaults(key: "isCreateTable", andVluew: false)
            print("创建表异常\(error)")
        }
    }
    
    // ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊  增删改查部分  ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    
    // 查询
    func queryWithAllWeatherTable() -> [[String: String]]? {
        let fileManager = NSFileManager.defaultManager()
        do{
            if !fileManager.fileExistsAtPath(databasePath) || !isCreate {
                return nil
            }else {
                var array: [[String: String]] = [[String: String]]()
                for weathers in try db.prepare(weather_list_table) {
                    var dict: [String: String] = [String: String] ()
                    dict["city"] = weathers[city]
                    dict["province"] = weathers[province]
                    dict["temperature_now"] = weathers[temperature_now]
                    dict["weather"] = weathers[weather]
                    dict["temperature_future"] = weathers[temperature_future]
                    dict["wind"] = weathers[wind]
                    dict["humidity"] = weathers[humidity]
                    dict["coldIndex"] = weathers[coldIndex]
                    dict["week1"] = weathers[week1]
                    dict["week2"] = weathers[week2]
                    dict["week3"] = weathers[week3]
                    dict["dayTime1"] = weathers[dayTime1]
                    dict["dayTime2"] = weathers[dayTime2]
                    dict["dayTime3"] = weathers[dayTime3]
                    dict["temperature1"] = weathers[temperature1]
                    dict["temperature2"] = weathers[temperature2]
                    dict["temperature3"] = weathers[temperature3]
                    dict["washIndex"] = weathers[washIndex]
                    dict["airCondition"] = weathers[airCondition]
                    dict["dressingIndex"] = weathers[dressingIndex]
                    dict["exerciseIndex"] = weathers[exerciseIndex]
                    array.append(dict)
                }
                return array
            }
        }catch {
            print("Query Error:\(error)")
            return nil
        }
    }
    
    // 只查询地理位置
    func queryCityAndProvince(queryOne: (cityInfo: [[String:String]]) -> Void) -> Bool? {
        let fileManager = NSFileManager.defaultManager()
        do {
            if !fileManager.fileExistsAtPath(databasePath) || !isCreate {
                return nil
            }else {
                var array_allInfo: [[String:String]] = []
                for citys in try db.prepare(weather_list_table.select(city, province)) {
                    var dict_cityinfo: [String:String] = [:]
                    dict_cityinfo["city"] = citys[city]
                    dict_cityinfo["province"] = citys[province]
                    array_allInfo.append(dict_cityinfo)
                }
                queryOne(cityInfo: array_allInfo)
                return true
            }
        }catch {
            print("查询城市信息失败:\(error)")
            return false
        }
    }
    
    // 插入
    func insertWeatherTable(info: [String]) -> Bool? {
        let fileManager = NSFileManager.defaultManager()
        do{
            if !fileManager.fileExistsAtPath(databasePath) || !isCreate {
                return nil
            }else {
                try db.run(
                    weather_list_table.insert(
                        or: .Replace,
                        province <- info[1],
                        temperature_now <- info[2],
                        weather <- info[3],
                        temperature_future <- info[4],
                        wind <- info[5],
                        humidity <- info[6],
                        coldIndex <- info[7],
                        week1 <- info[8],
                        week2 <- info[9],
                        week3 <- info[10],
                        dayTime1 <- info[11],
                        dayTime2 <- info[12],
                        dayTime3 <- info[13],
                        temperature1 <- info[14],
                        temperature2 <- info[15],
                        temperature3 <- info[16],
                        washIndex <- info[17],
                        airCondition <- info[18],
                        dressingIndex <- info[19],
                        exerciseIndex <- info[20],
                        city <- info[0]
                    )
                )
                return true
            }
        }catch{
            print("插入失败:\(error)")
            return false
        }
    }
    
    // 删除
    func delectByCityName(cityName: String) -> Bool? {
        let fileManager = NSFileManager.defaultManager()
        do{
            if !fileManager.fileExistsAtPath(databasePath) || !isCreate {
                return nil
            }else {
                let city = weather_list_table.filter(self.city == cityName)
                if try db.run(city.delete()) > 0 {
                    return true
                }
            }
        } catch {
            print("delete failed: \(error)")
        }
        return false
    }
}
