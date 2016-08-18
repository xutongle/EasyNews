//
//  Tools.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit
import CoreLocation

class Tools: NSObject {
    
    private override init() {}
    
    // 单利
    static var locationManager:CLLocationManager = CLLocationManager()
    
    //获得用户变量
    static func getUserDefaults(key: String) -> AnyObject? {
        
        return NSUserDefaults.standardUserDefaults().objectForKey(key)
    }
    
    //设置用户变量
    static func setUserDefaults(key key: String, andValue value:AnyObject) -> Void {
        
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
        
        let str = NSMutableString.init(string: hanzi) as CFMutableString
        
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        //print(str)
        
        // 如果不要音标
        if !yinbiao {
            CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, false)
            //print(str)
        }
        
        return str as String
    }
    
    /**
     * 截取地区前一个字符 深圳 -> sz
     */
    static func subCityWithHead(city: String) -> String? {
        // 按空格分离字符串
        let subStrArr = city.componentsSeparatedByString(" ")
        
        var resultStr: String? = ""
        var tempStr: String? = ""
        for str in subStrArr {
            tempStr = (str as NSString).substringToIndex(1)
            resultStr = resultStr! + tempStr!
        }
        
        return resultStr
    }
    
    /**
     * 读取plist文件
     */
    static func readPlist() -> NSDictionary? {
        var citysDict:NSDictionary! = nil
        
        let filePath = NSBundle.mainBundle().pathForResource("citydict", ofType: "plist")
        let fileManager = NSFileManager.defaultManager()
        if (filePath != nil && fileManager.fileExistsAtPath(filePath!)) {
            // 城市
            citysDict = NSDictionary.init(contentsOfFile: filePath!)
        }
        return citysDict
    }
    
    /**************************************************
     *                      拿来读取设置的 暂时不用
    ************************************************
    // 读取设置
    static func readSettingPlist(key: String?) -> AnyObject? {
        var settingDict: NSDictionary! = nil
        
        let filePath = NSBundle.mainBundle().pathForResource("setting", ofType: "plist")
        let fileManager = NSFileManager.defaultManager()
        if filePath != nil && fileManager.fileExistsAtPath(filePath!) {
            settingDict = NSDictionary.init(contentsOfFile: filePath!)
        }
        if key != nil {
            return settingDict[key!]
        }else{
            return key
        }
    }
    
    static func writeSettingPlist(key key: String?, writeValue value: AnyObject?) -> Bool {
        if key == nil || value == nil {
            return false
        }
        
        let settingDict = NSDictionary(object: value!, forKey: key!)
        let filePath = NSBundle.mainBundle().pathForResource("setting", ofType: "plist")
        let fileManager = NSFileManager.defaultManager()
        if filePath != nil && fileManager.fileExistsAtPath(filePath!) {
            settingDict.writeToFile(filePath!, atomically: false)
        }
        return true
    }
     ************************************************
    *************************************************/
}
