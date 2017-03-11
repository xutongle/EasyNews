//
//  WeatherModel.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import Foundation

class WeatherModel: NSObject {
    
    var codeDay : String! = ""
    var codeNight : String! = ""
    var date : String! = ""
    var high : String! = ""
    var low : String! = ""
    var precip : String! = ""
    var textDay : String! = ""
    var textNight : String! = ""
    var windDirection : String! = ""
    var windDirectionDegree : String! = ""
    var windScale : String! = ""
    var windSpeed : String! = ""
    
    override init() {
        super.init()
    }
    
    init(fromDictionary dictionary: NSDictionary){
        super.init()
        codeDay = dictionary["code_day"] as? String
        codeNight = dictionary["code_night"] as? String
        date = dictionary["date"] as? String
        high = dictionary["high"] as? String
        low = dictionary["low"] as? String
        precip = dictionary["precip"] as? String
        textDay = dictionary["text_day"] as? String
        textNight = dictionary["text_night"] as? String
        windDirection = dictionary["wind_direction"] as? String
        windDirectionDegree = dictionary["wind_direction_degree"] as? String
        windScale = dictionary["wind_scale"] as? String
        windSpeed = dictionary["wind_speed"] as? String
    }
}
