//
//  Tools.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/15.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit
import CoreLocation

class Tools: NSObject {
    
    private override init() {}
    
    // 单利
    static var locationManager:CLLocationManager = CLLocationManager()
    
    // 单利的文件管理
    static let fileManager:NSFileManager = NSFileManager.defaultManager()
    
    //获得用户变量
    static func getUserDefaults(key: String) -> AnyObject? {
        
        return NSUserDefaults.standardUserDefaults().objectForKey(key)
        
    }
    
    //设置用户变量
    static func setUserDefaults(key key: String, andVluew value:AnyObject) -> Void {
        
        if NSUserDefaults.standardUserDefaults().objectForKey(key) != nil {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
        
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //删除用户变量
    static func delUserDefaults(key key : String) -> Void {
        
        if NSUserDefaults.standardUserDefaults().objectForKey(key) != nil {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /**
     * 汉字转拼音
     */
    static func hanZiZhuanPinYin(hanzi: String, yinbiao: Bool) -> String? {
        
        var str = NSMutableString.init(string: hanzi) as CFMutableString
        
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        print(str)
        
        // 如果不要音标
        if !yinbiao {
            CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, false)
            print(str)
        }
        
        return str as String
    }
}
