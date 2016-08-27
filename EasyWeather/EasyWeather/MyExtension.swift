//
//  MyExtesion.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/18.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

//
extension String {
    // 裁剪从头start个字符  然后从结尾开始往前裁剪end个字符
    func subStringWith(start start: Int, end: Int) -> String {
        let str = self as NSString
        let range = NSRange.init(location: start, length: str.length - start - end)
        return str.substringWithRange(range)
    }
}

//
extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
}

extension CGSize {
    // 居于inWhere的中间(实例和类方法都可以使用)
    var Size_OneHalf: CGSize { return CGSize(width: self.width / 2, height: self.height / 2) }
    static func Size_OneHalf(OrginSize: CGSize) -> CGSize {
        return CGSize(width: OrginSize.width / 2, height: OrginSize.height / 2)
    }
}

extension UILabel {
    // 设置label的样式 其中设置了字体大小 才能设置字体
    func setStyle(title: String?, bgColor: UIColor?, color: UIColor?, fontName: String?, textSize: CGFloat?, alignment: NSTextAlignment?) -> Void {
        if title != nil { self.text = title }
        if bgColor != nil { self.backgroundColor = bgColor }
        if color != nil { self.textColor = color }
        if textSize != nil {
            self.font = UIFont.systemFontOfSize(textSize!)
            
            if fontName != nil { self.font = UIFont(name: fontName!,size: textSize!) }
        }
        if alignment != nil { self.textAlignment = alignment! }
    }
}

private var _touchUpInsideBlick: ((button: UIButton)->Void)!

extension UIButton {
    // 带点击事件的按钮
    func setStyle(title: String?, bgColor: UIColor?, color: UIColor?, touchUpInsideBlock:((button: UIButton)->Void)?) -> Void {
        
        if title != nil { self.setTitle(title, forState: .Normal) }
        if bgColor != nil { self.backgroundColor = bgColor }
        if color != nil { self.setTitleColor(color, forState: .Normal) }
        //
        if (touchUpInsideBlock != nil) {
            _touchUpInsideBlick = touchUpInsideBlock
            self.addTarget(self, action: #selector(TouchUpInsideAction), forControlEvents: .TouchUpInside)
        }
    }
    
    @objc
    private func TouchUpInsideAction(button: UIButton) -> Void {
        _touchUpInsideBlick(button: button)
    }
}