//
//  NetTool.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NetTool: NSObject {
    
    private static let key = "lwcd4mx6yapqcu2c"
    static let baseUrl = "https://api.thinkpage.cn/v3"
    static let weathereUrl = baseUrl + "/weather/daily.json"
    static let currentUrl = baseUrl + "/weather/now.json"
    static let suggestion = baseUrl + "/life/suggestion.json"
    
    private static func getLanage() -> String {
        if let lanage = Tools.getCurrentLanage() {
            if lanage.hasPrefix("zh") {
                return "zh-Hans"  // 确认是中文
          
            }
        }else {
            return "zh-Hans"  //获得语言失败
        }
        return "en"   // 不是中文
    }
    
    static func getWeathereUrlParam(city: String) -> [String : String] {
        return ["key" : key, "language" : "zh-Hans", "unit" : "c", "start" : "0", "day" : "2", "location" : city]
    }
    
    static func getCurrentUrlParam(city: String) -> [String : String] {
        return ["key" : key, "language" : "zh-Hans", "unit" : "c", "location" : city]
    }
    
    static func getSuggestion(city: String) -> [String : String] {
        return ["key" : key, "language" : "zh-Hans", "location" : city]
    }
    
    static func toString(any: Any?) -> String {
        if any == nil {
            return "null"
        }
        if any is String {
            return any as! String
        }
        if any is Int {
            return String(any as! Int)
        }
        return "unknow"
    }
    
}
