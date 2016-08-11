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
    
    // 单利自己
    static let dbOperate = DBOperate()
    // 数据库连接对象
    var db: Connection!
    
    // 判断文件存不存在的路径
    var fielExitsStr:String!
    // 文件路径
    var filePath:String!
    
    // 字段
    var city:Expression<String>!
    var province:Expression<String>!
    
    
}
