//
//  DBOperateFile.swift
//  EasyWheater
//
//  Created by zly.private on 16/7/4.
//  Copyright © 2016年 private. All rights reserved.
//

//import UIKit
//import SQLite
//
//class DBOperateFile: NSObject {
//
//    // 数据库连接对象
//    var db: Connection!
//    
//    // 判断文件存不存在的路径
//    var fielExitsStr:String!
//    // 文件路径
//    var filePath:String!
//    
//    // 字段
//    var bgImage:Expression<NSData>!
//    
//    // 表对象
//    var pic_list_table:Table!
//    
//    // 单利自己
//    static let dBOperateFile = DBOperateFile()
//    
//    private override init() {
//        super.init()
//        
//        createTable()
//    }
//    
//    func createTable() -> Void {
//        let fileName = "photo.sqlite3"
//        
//        //沙盒目录
//        let urlForDocument = Tools.fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask)
//        
//        //获得沙盒url
//        let documentUrl = urlForDocument[0]
//        let documentStr = NSString.init(format: "%@", documentUrl)
//        //用于判断文件存不存在
//        fielExitsStr = documentStr.substringFromIndex(7) + fileName
//        //文件路径
//        filePath = (documentStr as String) + fileName
//        
//        // 当文件不存在时 创建数据库和表
//        do {
//            // 连接数据库
//            db = try Connection(filePath)
//            // 字段对象
//            bgImage = Expression<NSData>("PIC")
//
//            // 表对象
//            pic_list_table = Table("PIC_BG")
//            
//            /**
//             * 当文件不存在说明还没有存入 要创建数据库和表
//             **/
//            if !Tools.fileManager.fileExistsAtPath(fielExitsStr) {
//                print("创建文件", fielExitsStr)
//                // 创建表 (就一个表,一个字段)
//                try db.run(pic_list_table.create(block: { tableBuilder in
//                    tableBuilder.column(bgImage, primaryKey: true)
//                }))
//            }
//        }catch {
//            print("数据库操作出错\(error)")
//        }
//        print(fielExitsStr)
//    }
//    
//    // 查询数据
//    func queryData(queryOver: (backCitys: NSDictionary) -> Void) -> NSData? {
//        let data:NSData!
//        do {
//            // 如果连文件都不存在就直接false
//            if Tools.fileManager.fileExistsAtPath(fielExitsStr) {
//                for source in try db.prepare(pic_list_table) {
//                    data = source.get(bgImage)
//                }
//                return data
//            }else {
//                print("Query:FileNotExist!!!")
//                createTable()
//            }
//        } catch {
//            print("queryDataError!!!\(error)")
//        }
//        return nil
//    }
//    
//    // 插入数据
//    func insertData(data: NSData) -> Bool {
//        // 如果连文件都不存在就直接false
//        if !Tools.fileManager.fileExistsAtPath(fielExitsStr) {
//            print("Insert:FileNotExist!!!")
//            createTable()
//            return false
//        }
//        //
//        do {
//            try db.run(pic_list_table.insert(bgImage <- data))
//            
//            return true
//        } catch {
//            print("insertDataError!!!")
//            return false
//        }
//    }
//    
//    // 删除数据
//    func deleteData(cityName: String) -> Bool {
//        // 如果连文件都不存在就直接false
//        if !Tools.fileManager.fileExistsAtPath(fielExitsStr) {
//            print("Delete:FileNotExist!!!")
//            createTable()
//            return false
//        }
//        //
//        do {
//            let delete_dialog = pic_list_table.filter(city == cityName)
//            try db.run(delete_dialog.delete())
//            
//            return true
//        } catch {
//            print("deleteDataError!!!")
//            return false
//        }
//    }
//    
//    // 查询数据是否存在
//    func queryIsExitsData(cityName: String) -> Bool {
//        if !Tools.fileManager.fileExistsAtPath(fielExitsStr) {
//            print("queryIsExitsDataError!!!")
//            createTable()
//            return false
//        }
//        
//        do {
//            for citys in try db.prepare(pic_list_table) {
//                // 判断是否存在 - -
//                if citys.get(city) == cityName {
//                    print("Find It")
//                    return true
//                }else {
//                    print("dataNotExits!!!")
//                }
//            }
//        } catch {
//            print("queryExitsError!!!")
//        }
//        
//        return false
//    }
//}
