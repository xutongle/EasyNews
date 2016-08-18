//
//  MyExtesion.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/18.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

extension String {
    // 裁取从start开始  然后结尾裁剪end
    func subStringWith(start start: Int, end: Int) -> String {
        let str = self as NSString
        let range = NSRange.init(location: start, length: str.length - start - end)
        return str.substringWithRange(range)
    }
}