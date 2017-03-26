//
//  Tools.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit
import CoreLocation

// 各种Bar高度的结构体
struct BarHeight {
    var statusHeight: CGFloat!
    var navgationHeight: CGFloat!
    var sumHeight: CGFloat!
    
    init(sh: CGFloat, nh: CGFloat) {
        self.statusHeight = sh
        self.navgationHeight = nh
        sumHeight = sh + nh
    }
}

class Tools: NSObject {
    
    static let locationManage = CLLocationManager()
    
    private override init() {}
    
    // 指定日历的算法
    static let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    // 获得用户变量
    static func getUserDefaults(key: String) -> Any? {
        
        return UserDefaults.standard.object(forKey: key)
    }
    
    // 设置用户变量
    static func setUserDefaults(key: String, andValue value:Any) -> Void {
        
        if UserDefaults.standard.object(forKey: key) != nil {
            UserDefaults.standard.removeObject(forKey: key)
        }
        
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    // 删除用户变量
    static func delUserDefaults(key : String) -> Void {
        
        if UserDefaults.standard.object(forKey: key) != nil {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    // 检查用户变量 只适合Bool值检测 注意
    static func checkBoolUserDefaults(check: Any?) -> Bool {
        let checkd = check as? Bool
        if checkd == nil {
            return false
        }
        return checkd!
    }
    
    /**
     * 汉字转拼音
     */
    static func hanZiZhuanPinYin(hanzi: String, yinbiao: Bool) -> String {
        
        let str = NSMutableString.init(string: hanzi) as CFMutableString
        
        CFStringTransform(str, nil, kCFStringTransformToLatin, false)
        
        // 如果不要音标
        if !yinbiao {
            CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, false)
        }
        
        return str as String
    }
    
    // 日志输出
    static func logS<T>(message: T, methodName: String = #function, lineNumber: Int = #line) -> Void {
        #if DEBUG
            print("\n******< in [\(methodName)] at line [\(lineNumber)]: \(message) >******\n")
        #endif
    }
    // 详细输出
    static func logD<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) -> Void {
        #if DEBUG
            print("\n******< filename -> \(fileName) in [\(methodName)] at line [\(lineNumber)]: \(message) >******\n")
        #endif
    }
    
    /* 把View保存成图片 */
    static func toImageWith(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /* 自适应文字布局返回的frame */
    static func getLabelSize(font: UIFont,text: String,maxSize: CGSize)->CGRect {
        var newFrame: CGRect!
        newFrame = text.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
        return newFrame
    }
    
    /* 寻找沙盒路径 */
    static func getDocumentDirectory(name: String) -> String {
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        path = path + "/" + name
        return path
    }
    /* 获得cache路径 */
    static func getCacheDirectory(name: String) -> String {
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        path = path + "/" + name
        return path
    }
    
    /* 控 件 圆 角 */
    static func setRadio(vw: AnyObject, frame: CGRect, radioSize: CGSize, corner: UIRectCorner)-> AnyObject{
        let path: UIBezierPath = UIBezierPath(roundedRect: frame, byRoundingCorners: corner, cornerRadii: radioSize)
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = vw.bounds
        maskLayer.path = path.cgPath
        vw.layer.mask = maskLayer
        return vw
    }
    
    /********************** 时间 **********************/
    
    /* 获得 获取指定日期的年，月，日，星期，时,分,秒信息 */
    static func getWeek(dateTime:String, comSet: Set<Calendar.Component>, date: Date) -> DateComponents{
        // let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        // set里你给定了什么 .mouth 他就有 当前给定时间的月份 在component 里
        let component = calendar.dateComponents(comSet, from: date)
        return component
    }
    
    /* 获得当月天数 */
    static func getNumberOfDaysWith() -> Int {

        let range = calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: Date())
        
        if range != nil {
            
            return range!.count
        }
        return 0
    }
    
    /* 获得年 */
//    static func getYear() -> Int? {
//        let date = Date()
//        let yearStr = date.toString(formatString: "yyyy")
//        return yearStr.toInt()
//    }
    
    /* 返回每月天数 */
    static func howManyDayWith(year: Int, month: Int) -> Int {
        if ((month == 1) || (month == 3) || (month == 5) || (month == 7)
            || (month == 8) || (month == 10) || (month == 12)){
            return 31
        }
        if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
            return 30
        }
        
        if ((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3)) {
            return 28
        }
        
        if year % 400 == 0 {
            return 29
        }
        
        if year % 100 == 0 {
            return 28
        }
        
        return 29
    }
    
    /* 计算时间差 */
    static func calcDistanceDay(firstDateStr: String?, secondDateStr: String?) -> Int {
        if firstDateStr == nil || secondDateStr == nil { return 0 }
        
        let dm: DateFormatter = DateFormatter()
        dm.dateFormat = "yyyy-MM-dd"
        
        let D_DAY = 86400
        
        let firstDate = dm.date(from: firstDateStr!)
        let secondDate = dm.date(from: secondDateStr!)
        
        let interval: TimeInterval = secondDate!.timeIntervalSince(firstDate!)
        let days = Int(interval) / D_DAY
        return days
    }
    
    /* 获取当前使用语言 */
    static func getCurrentLanage() -> String? {
        let languages = Locale.preferredLanguages
        let currnet = languages.first
        return currnet
    }
    
    /* 提示 */
    static func showTipAlert(title: String, message: String, alertTitle: String, vc: UIViewController) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: alertTitle, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    // 读取plist
    static func readPlist(complete: @escaping (_ dict: NSDictionary) -> Void) -> Void {
        
        let filePath = Bundle.main.path(forResource: "city", ofType: "plist")
        guard filePath != nil else {
            return
        }
        
        DispatchQueue.global().async { 
            if let dict = NSDictionary(contentsOfFile: filePath!) {
                complete(dict)
            }
        }
    }
    
    // 正则表达式
    static public func useRangx(pattern: String, rangeString: String) -> [String] {
        var values: [String] = []
        do {
            // 规则
            let regular = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            for result in regular.matches(in: rangeString, options: .reportProgress, range: NSMakeRange(0, rangeString.characters.count)) {
                values.append((rangeString as NSString).substring(with: result.range))
            }
        }catch { }
        return values
    }
    
    // array to str
    static func arrayToString(array: [String], s: String) -> String {
        var first = true
        var ss: String = ""
        for str in array {
            if first {
                ss += str
                first = false
            }else {
                ss += s + str
            }
        }
        return ss
    }
    
    // 状态栏高度 导航栏高度 （注意：导航栏为nil 高度为小于0）
    static func getBarHeight(nav: UINavigationController?) -> BarHeight {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        var navHeight: CGFloat = 0
        if nav != nil {
            navHeight = nav!.navigationBar.bounds.size.height
        }
        return BarHeight(sh: statusBarHeight, nh: navHeight)
    }
}
