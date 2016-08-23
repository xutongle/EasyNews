//
//  MyExtesion.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/18.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

extension String {
    // 裁剪从头start个字符  然后从结尾开始往前裁剪end个字符
    func subStringWith(start start: Int, end: Int) -> String {
        let str = self as NSString
        let range = NSRange.init(location: start, length: str.length - start - end)
        return str.substringWithRange(range)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
}