//
//  ZLY_Extension.swift
//  CareBaby
//
//  Created by mac_zly on 16/9/19.
//  Copyright © 2016年 safethink. All rights reserved.
//

import UIKit

extension Data{
    
    /* data to 16 string */
    func hexEncodedString() -> String {
        return map { String(format: "%02hhX ", $0) }.joined()
    }
    
    /* data to 10 string */
    func decimalEncodedString() -> String {
        return map { String(format: "%d ", $0) }.joined()
    }
    
    func decimalStringUTF16() -> [UInt16] {
        let asciiString = String(data: self, encoding: String.Encoding.ascii)
        if asciiString != nil {
            let uint16Array: [UInt16] = Array(asciiString!.utf16)
            return uint16Array
        }else {
            return [0]
        }
    }
    
    func decimalStringUTF8() -> [UInt8] {
        let utf8String = String(data: self, encoding: String.Encoding.utf8)
        if utf8String != nil {
            let uintf8Array: [UInt8] = Array(utf8String!.utf8)
            return uintf8Array
        }else {
            return [0]
        }
    }
    
    func toBytes() -> UnsafeRawPointer {
        return (self as NSData).bytes
    }
}

enum DateFormat {
    case sss
    case ss
    case nomal
    case simple1
    case simple2
}

extension Date {
    
    ///  获得格式化好了的时间
    ///
    /// - parameter format:     格式 枚举
    /// - parameter dayOffset:  位移天数
    /// - parameter hourOffset: 位移小时
    ///
    /// - returns: 返回格式化的时间 以字符串形式 EEE显示周几 MMMM显示十月这样的
    func getFormatTime(format: DateFormat, dayOffset: Int?, hourOffset: Int?) -> String {
        let dateFormat = DateFormatter()
        switch format {
        case .sss:
            dateFormat.dateFormat = "YYYY-MM-dd HH:mm:ss:SSS"
            break
        case .ss:
            dateFormat.dateFormat = "YYYY-MM-dd HH:mm:ss"
            break
        case .nomal:
            dateFormat.dateFormat = "YYYY-MM-dd"
            break
        case .simple1:
            dateFormat.dateFormat = "MM-dd"
            break
        case .simple2:
            dateFormat.dateFormat = "YYYY-MM"
            break
        }
        
        var newDate: Date = self
        
        if dayOffset != nil && (hourOffset == nil || hourOffset == 0)  {
            newDate = self.addingTimeInterval(TimeInterval( CGFloat(dayOffset!).multiplied(by: 24.0).multiplied(by: 60.0).multiplied(by: 60.0) ))
        }
        
        if (dayOffset == nil || dayOffset == 0) && hourOffset != nil {
            newDate = self.addingTimeInterval(TimeInterval( CGFloat(hourOffset!).multiplied(by: 60.0).multiplied(by: 60.0) ))
        }

        let dateStr = dateFormat.string(from: newDate)
        return dateStr
    }
    
    static func getCurrentDetailString() -> String {
        return Date().getFormatTime(format: .sss, dayOffset: 0, hourOffset: 0)
    }
    
    // date to string
    func toString(formatString: String) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = formatString
        return timeFormatter.string(from: self)
    }
}

extension UITableView {
    func lineToLeft() -> Void {
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }
}

extension UITableViewCell {
    func lineToLeft() -> Void {
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }
}

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

extension CGFloat {
    var toStringValue: String {
        return String(describing: self)
    }
}

extension String {
    // 裁剪从头start个字符  然后从结尾开始往前裁剪end个字符  
    // na｜meI｜sZly  start=2 end=4的结果 meI
    func subString(start: Int, end: Int) -> String {
        let str = self as NSString
        let range = NSRange.init(location: start, length: str.length - start - end)
        return str.substring(with: range)
    }
    
    // 国际化
    func localed() -> String {
        return NSLocalizedString(self, comment: " ")
    }
    
    func toUrl() -> URL? {
        return URL(string: self)
    }
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    // string to date
    func toDate(formatString: String) -> Date? {
        let dateForamt = DateFormatter()
        dateForamt.dateFormat = formatString
        return dateForamt.date(from: self)
    }

}

extension UIColor {
    
    /* 随机颜色 */
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
    
    /* color to RGB */
    func colorToRGB() -> [String: String] {
        
        let RGBValue: NSString = NSString.init(format: "%@", self)
        
        let arr = RGBValue.components(separatedBy: " ")
        
        let dict = ["r":arr[1],"g":arr[2],"b":arr[3]]
        
        return dict
    }
}

extension UILabel {
    // 设置label的样式
    func setStyle(_ title: String?, bgColor: UIColor?, color: UIColor?, fontName: String?, textSize: CGFloat?, alignment: NSTextAlignment?) -> Void {
        if title != nil { self.text = title }
        if bgColor != nil { self.backgroundColor = bgColor }
        if color != nil { self.textColor = color }
        if textSize != nil { self.font = UIFont.systemFont(ofSize: textSize!) }
        if fontName != nil { self.font = UIFont(name: fontName!,size: textSize == nil ? 16 : textSize!) }
        if alignment != nil { self.textAlignment = alignment! }
    }
    
}

extension UIButton {

    func setStyle(_ title: String?, bgColor: UIColor?, textSize: CGFloat?, color: UIColor?) -> Void {
        
        if title != nil { self.setTitle(title, for: UIControlState()) }
        if bgColor != nil { self.backgroundColor = bgColor }
        if textSize != nil { self.titleLabel?.font = UIFont.systemFont(ofSize: textSize!) }
        if color != nil { self.setTitleColor(color, for: UIControlState()) }
    }
    
    func toCenter() -> Void {
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.imageView?.contentMode = .scaleAspectFit
    }

}

extension UIViewController {
    func alertSimpleView(message: String, OKBlock: @escaping ((_ action: UIAlertAction) -> Void)) -> Void {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default) { (action) in
            OKBlock(action)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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

