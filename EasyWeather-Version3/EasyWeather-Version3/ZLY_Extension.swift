//
//  ZLY_Extension.swift
//  CareBaby
//
//  Created by mac_zly on 16/9/19.
//  Copyright © 2016年 safethink. All rights reserved.
//

import UIKit

extension Int {
    var toStringValue: String {
        return String(self)
    }
}

extension Double {
    var toStringValue: String {
        return String(self)
    }
}

extension Float {
    var toStringValue: String {
        return String(self)
    }
}

extension NSObject {
    
    // 日志输出
    static func logS<T>(message: T, methodName: String = #function, lineNumber: Int = #line) {
        #if DEBUG
            print("\n******< in [\(methodName)] at line [\(lineNumber)]: \(message) >******\n")
        #endif
    }
    
    static func ligD<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
        #if DEBUG
            print("\n******< filename -> \(fileName) in [\(methodName)] at line [\(lineNumber)]: \(message) >******\n")
        #endif
    }
}

extension String {
    // 裁剪从头start个字符  然后从结尾开始往前裁剪end个字符  
    // na｜meI｜sZly  start=2 end=4的结果 meI
    func subStringWith(start: Int, end: Int) -> String {
        let str = self as NSString
        let range = NSRange.init(location: start, length: str.length - start - end)
        return str.substring(with: range)
    }
    
    // 国际化
    func localed() -> String {
        return NSLocalizedString(self, comment: " ")
    }

}

extension UIColor {
    // 随机颜色
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
}

extension CGSize {
    // 居于inWhere的中间(实例和类方法都可以使用)
    var Size_OneHalf: CGSize { return CGSize(width: self.width / 2, height: self.height / 2) }
    static func Size_OneHalf(_ OrginSize: CGSize) -> CGSize {
        return CGSize(width: OrginSize.width / 2, height: OrginSize.height / 2)
    }
}

extension UILabel {
    // 设置label的样式 其中设置了字体大小 才能设置字体
    func setStyle(_ title: String?, bgColor: UIColor?, color: UIColor?, fontName: String?, textSize: CGFloat?, alignment: NSTextAlignment?) -> Void {
        if title != nil { self.text = title }
        if bgColor != nil { self.backgroundColor = bgColor }
        if color != nil { self.textColor = color }
        if textSize != nil {
            self.font = UIFont.systemFont(ofSize: textSize!)
            
            if fontName != nil { self.font = UIFont(name: fontName!,size: textSize!) }
        }
        if alignment != nil { self.textAlignment = alignment! }
    }
}

extension UIButton {

    // 带点击事件的按钮
    func setStyle(_ title: String?, bgColor: UIColor?, color: UIColor?) -> Void {
        
        if title != nil { self.setTitle(title, for: UIControlState()) }
        if bgColor != nil { self.backgroundColor = bgColor }
        if color != nil { self.setTitleColor(color, for: UIControlState()) }
    }

}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

