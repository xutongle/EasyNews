//
//  MainViewController.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, UIViewControllerPreviewingDelegate {
    
    //mob天气的相关
    let url = "http://apicloud.mob.com/v1/weather/query"
    let APP_KEY = "12c3624ad5993"
    
    var slidingView: SlidingView!
    
    // 主视图tableview
    var mainTableView: MainTableView!
    
    //
    let clLocationManager: CLLocationManager = CLLocationManager()
    
    // 需要刷新
    var needRefresh = false
    
    // 
    var refreshTimeLabel: UILabel!
    
    // 重写方法让那个状态栏变白
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Tools.getUserDefaults("first") == nil {
            Tools.setUserDefaults(key: "first", andVluew: false)
            Tools.setUserDefaults(key: "BlurValue", andVluew: 0.5)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initailLocation()
        
        let background = BackgroundImageView.backgroundImageView
        background.weather = "多云"
        // 从沙盒中取到图片
        SaveImageToDocment.saveImageToDocment.getImage({ (image) in
            if image != nil {
                BackgroundImageView.backgroundImageView.image = image
            }
        })
        
        //背景
        self.view.addSubview(background)
        // 头视图
        self.view.addSubview(TopView.topView)
        // 主视图
        mainTableView = MainTableView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64), style: .Plain)
        self.view.addSubview(mainTableView)
        // 刷新的时间
        refreshTimeLabel = UILabel.init(frame: CGRectMake(0, SCREEN_HEIGHT - 20, SCREEN_WIDTH, 20))
        refreshTimeLabel.textAlignment = .Center
        refreshTimeLabel.textColor = UIColor.orangeColor()
        refreshTimeLabel.userInteractionEnabled = true
        self.view.addSubview(refreshTimeLabel)
        
        if Tools.getUserDefaults("updateWeatherTime") != nil {
            refreshTimeLabel.text = Tools.getUserDefaults("updateWeatherTime") as? String
        }else {
            refreshTimeLabel.text = "无"
        }
        // 获得侧划对象
        slidingView = self.view.addSlidingView_zly()
        
        self.check3dTouch()
        
        // TopView
        btnAction = {whichButton in
            switch whichButton {
            case .isDrawUpButton:
                // 打开侧滑
                self.slidingView.toggleSldingView(true)
                break
            case .isLocationButton:
                break
            case .isAddLocationButton:
                self.presentViewController(AddViewController.addViewController, animated: true, completion: nil)
                break
            }
        }
        
        // 设置按钮回调
        setttingBlock = {
            self.closeSlidingView()
            self.presentViewController(SettingViewController(), animated: true, completion: nil)
        }
        
        // 城市选择
        backCityBlock = {cityName in
            self.chooseOverShowWeather(cityName)
        }
        
        // 来自AddViewController
        backSearchViewBlock = {cityName in
            self.chooseOverShowWeather(cityName as String)
        }
        
        // 侧划点按cell
        clickCellBlock = {city, province in
            Tools.setUserDefaults(key: "province", andVluew: province)
            Tools.setUserDefaults(key: "city", andVluew: city)
            
            self.getWeather(city, Over: { (cityName, province) in  })
        }
        
        // 划出侧划页面的手势
        let swapLeftGestrue = UISwipeGestureRecognizer(target: self, action: #selector(openSlidingView))
        swapLeftGestrue.direction = .Right
        self.view.addGestureRecognizer(swapLeftGestrue)
        
        // 刷新的通知 (重新定位， 重新获取天气)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reGetWeather_Locatin), name: "ReGetLocationAndReGetWeather", object: nil)
    }
    
    // MARK: - －－－－－－－－－－－－－－－－－－－－ 自己的方法 －－－－－－－－－－－－－－－－－－
    
    // 初始化CLLocationManager
    func initailLocation() -> Void {
        if CLLocationManager.locationServicesEnabled() {
            clLocationManager.delegate = self
            clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            //更新距离
            clLocationManager.distanceFilter = kCLDistanceFilterNone
            //when in use
            if clLocationManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization))
                && UIDevice.currentDevice().systemVersion >= "8.0" {
                clLocationManager.requestWhenInUseAuthorization()
            }
            //
            clLocationManager.startUpdatingLocation()
        }
    }
    
    // 开启定位
    func reGetWeather_Locatin() -> Void {
        clLocationManager.startUpdatingLocation()
    }
    
    // 选择天气后
    func chooseOverShowWeather(cityName: String) -> Void {
        self.view.show("已选\(cityName)", style: ToastStyle(), postion: .InCente, block: {})
        
        getWeather(cityName) { cityName, province in
            if province != nil {
                Tools.setUserDefaults(key: "province", andVluew: province!)
                Tools.setUserDefaults(key: "city", andVluew: cityName)
                TopView.topView.location = Tools.getUserDefaults("city") as! String
            }
        }
    }
    
    // 获取天气
    func getWeather(city: String?, Over: (cityName: String, province: String?) -> Void) -> Void {
        
        let chooseCity = (city == nil ?  Tools.getUserDefaults("city")! : city!)
        let tempProvince = (Tools.getUserDefaults("province") == nil ? "" : Tools.getUserDefaults("province")!)
        let parameters = ["key":APP_KEY,
                          "city": chooseCity,
                          "province": tempProvince]
        refreshTimeLabel.text = "加载中..."
        Alamofire.request(.POST, url, parameters: parameters).responseJSON { (response) in
            let result = response.result
            if result.isSuccess {
                let json = JSON(response.result.value!)
                // 如果获得天气成功
                if json["retCode"].intValue == 200 {
                    
                    // 存放存入数据库的信息 拍好序了
                    var tempArray: [String]! = []
                    let allInfo = json["result"].arrayValue[0].dictionaryValue
                    let futureInfo = allInfo["future"]
                    
                    Tools.setUserDefaults(key: "province", andVluew: allInfo["province"]!.stringValue)
                    Tools.setUserDefaults(key: "city", andVluew: allInfo["city"]!.stringValue)
                    TopView.topView.location = Tools.getUserDefaults("city") as! String
                    
                    tempArray.append(allInfo["city"]!.stringValue)
                    tempArray.append(allInfo["province"]!.stringValue)
                    // 天气信息
                    self.mainTableView.weatherInfoDict = NSMutableDictionary()
                    // 裁剪string的方法
                    let temperature_future = self.subString(futureInfo![0]["temperature"].stringValue)
                    
                    self.mainTableView.weatherInfoDict =
                        ["temperature_now": allInfo["temperature"]!.stringValue, "weather": allInfo["weather"]!.stringValue,
                            "temperature_future": temperature_future]
                    
                    Tools.setUserDefaults(key: "temperature_now", andVluew: allInfo["temperature"]!.stringValue)
                    Tools.setUserDefaults(key: "weather", andVluew: allInfo["weather"]!.stringValue)
                    
                    // 缓存用
                    tempArray.append(allInfo["temperature"]!.stringValue)
                    tempArray.append(allInfo["weather"]!.stringValue)
                    tempArray.append(temperature_future)
                    // 其他天气信息
                    self.mainTableView.otherWeatherInfoDict = NSMutableDictionary()
                    self.mainTableView.otherWeatherInfoDict =
                        ["wind": allInfo["wind"]!.stringValue, "humidity": allInfo["humidity"]!.stringValue,
                            "coldIndex": allInfo["coldIndex"]!.stringValue]
                    tempArray.append(allInfo["wind"]!.stringValue)
                    tempArray.append(allInfo["humidity"]!.stringValue)
                    tempArray.append(allInfo["coldIndex"]!.stringValue)
                    // 剩下几天的天气信息
                    self.mainTableView.lastdayWeatherInfo = NSMutableArray()
                    for (index: index, subJson: value) in futureInfo!{
                        if NSInteger(index) >= 1 && NSInteger(index) <= 3 {
                            self.mainTableView.lastdayWeatherInfo[NSInteger(index)! - 1] =
                                ["week": value["week"].stringValue, "dayTime": value["dayTime"].stringValue,
                                    "temperature": value["temperature"].stringValue]
                            //
                            tempArray.append(value["week"].stringValue)
                            tempArray.append(value["dayTime"].stringValue)
                            tempArray.append(value["temperature"].stringValue)
                        }
                    }
                    // 其他信息
                    self.mainTableView.otherInfoDict = NSMutableDictionary()
                    self.mainTableView.otherInfoDict =
                        ["washIndex": allInfo["washIndex"]!.stringValue,
                            "airCondition": allInfo["airCondition"]!.stringValue,
                            "dressingIndex": allInfo["dressingIndex"]!.stringValue,
                            "exerciseIndex": allInfo["exerciseIndex"]!.stringValue]
                    tempArray.append(allInfo["washIndex"]!.stringValue)
                    tempArray.append(allInfo["airCondition"]!.stringValue)
                    tempArray.append(allInfo["dressingIndex"]!.stringValue)
                    tempArray.append(allInfo["exerciseIndex"]!.stringValue)
                    //
                    let result = DBOperaCityList.dbOperaCityList.insertWeatherTable(tempArray)
                    if (result != nil && result == true) {
                        self.view.show("获得天气成功", block: { })
                    }
                    
                    // 更新时间
                    Tools.setUserDefaults(key: "updateWeatherTime", andVluew: self.getCurrentTime())
                    self.refreshTimeLabel.text = Tools.getUserDefaults("updateWeatherTime") as? String
                    //
                    self.view.getSlidingView_zly().lightCell()
                    // 是否需要重新刷新侧划
                    self.needRefresh = true
                    //print(allInfo)
                    Over(cityName: allInfo["city"]!.stringValue, province: allInfo["province"]!.stringValue)
                    self.mainTableView.reloadData()
                }else {
                    self.view.show("获取天气失败", block: { })
                    print("使用缓存1")
                    // 使用缓存
                    self.getCacheWithSqlAndSet(chooseCity as! String, provinceName: tempProvince as! String)
                }
            }else {
                print("使用缓存2")
                // 使用缓存
                self.getCacheWithSqlAndSet(chooseCity as! String, provinceName: tempProvince as! String)
            }
        }
    }
    
    func getCacheWithSqlAndSet(cityName: String, provinceName: String) -> Void {
        // 异步线程 内的同步执行。。。。。
        dispatch_async(dispatch_queue_create("queryOne", DISPATCH_QUEUE_SERIAL)) {
            let result =  DBOperaCityList.dbOperaCityList.queryWithCityName(cityName, provinceName: provinceName, backInfo: { (info) in
                print("\(cityName)\(provinceName)\n\(info)")
                if info != nil && info!.count == 21 {
                    //
                    self.mainTableView.weatherInfoDict = ["temperature_now": info![2], "weather": info![3], "temperature_future": info![4]]
                    //
                    self.mainTableView.otherWeatherInfoDict = ["wind": info![5], "humidity": info![6], "coldIndex": info![7]]
                    //
                    let dict1 = ["week": info![8], "dayTime":info![9], "temperature":info![10]]
                    let dict2 = ["week": info![11], "dayTime":info![12], "temperature":info![13]]
                    let dict3 = ["week": info![14], "dayTime":info![15], "temperature":info![16]]
                    self.mainTableView.lastdayWeatherInfo = [dict1,dict2,dict3]
                    //
                    self.mainTableView.otherInfoDict = ["washIndex": info![17], "airCondition": info![18], "dressingIndex": info![19], "exerciseIndex": info![20]]
                    //
                    dispatch_async(dispatch_get_main_queue(), {
                        // 头视图
                        TopView.topView.location = cityName
                        
                        self.view.show("请检查网络,使用上次天气信息", block: { })
                        self.mainTableView.reloadData()
                    })
                }else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.view.show("请检查网络", block: { })
                    })
                }
            })
            
            if result == nil || result == false {
                self.view.show("请检查网络,并重试", block: { })
            }
            
        }
    }
    
    // 获得当前格式化的时间
    func getCurrentTime() -> String {
        let date = NSDate()
        let sec = date.timeIntervalSinceNow
        let currentTime = NSDate(timeIntervalSinceNow: sec)
        let dateFormat = NSDateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let time = dateFormat.stringFromDate(currentTime)
        return time
    }
    
    // 混搭字符串
    func subString(temperature :String) -> String {
        var temperature_future = temperature
        
        // 字符串够长再裁剪
        if (temperature_future as NSString).length > 4 {
            let rang = temperature_future.componentsSeparatedByString("/")
            var max_temperature = rang[0]
            max_temperature = (max_temperature as NSString).substringToIndex((max_temperature as NSString).length - 1)
            var min_temperature = rang[1]
            min_temperature = (min_temperature as NSString).substringFromIndex(1)
            temperature_future = max_temperature + "\n" + min_temperature
            //print(max_temperature, "-" ,min_temperature)
        }
        return temperature_future
    }
    
    // 刷新侧划数据
    func refreshDataWithSliding() -> Void {
        self.needRefresh = false
        dispatch_async(dispatch_queue_create("selectQuque", DISPATCH_QUEUE_CONCURRENT)) {
            DBOperaCityList.dbOperaCityList.queryCityAndProvince { (cityInfo) in
                self.view.getSlidingView_zly().dataForTableView = cityInfo
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.getSlidingView_zly().reloadData()
                    self.view.getSlidingView_zly().lightCell()
                })
            }
        }
    }
    
    func openSlidingView() -> Void {
        
        if self.view.getSlidingView_zly().dataForTableView.count == 0 {
            print("刷新1")
            refreshDataWithSliding()
        }else if needRefresh {
            print("刷新2")
            refreshDataWithSliding()
        }
        
        slidingView.toggleSldingView(true)
    }
    
    func closeSlidingView() -> Void {
        slidingView.toggleSldingView(false)
    }
    
    //反地理编码
    func getLocationName(location: CLLocation, complete:(province: NSString,city :NSString) -> Void) -> Void {
        //苹果自带反地理编码
        CLGeocoder().reverseGeocodeLocation(location) { (placemakes: [CLPlacemark]?, error: NSError?) -> Void in
            let placemake = placemakes?.first
            
            //成功获得地址
            if placemake != nil{
                complete(province: placemake!.administrativeArea!, city: placemake!.locality!)
                //print(placemake?.locality,placemake?.administrativeArea)
            }else{
                self.view.show("无法获得定位信息，请稍后重试", block: {})
            }
        }
    }
    
    func check3dTouch() -> Void {
        // 检测3D Touch是否可用，如果可用就注册
        if (self.traitCollection.forceTouchCapability == .Available) {
            self.registerForPreviewingWithDelegate(self, sourceView: refreshTimeLabel)
        }
    }
    
    // MARK: - ----------------------------- 定位的协议 -----------------------------
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //
        let currLocation:CLLocation = locations.last!
        
        //当位置稳定时
        if locations.first == locations.last {
            clLocationManager.stopUpdatingLocation()
            
            //逆地理位置的回调
            getLocationName(currLocation, complete: { (province, city) in
                
                var trueProvince:String!
                var trueCity:String!
                // 判断最后一个字是不是"市"字 碰到了没有市的 比如江苏 苏州
                let shi = city.substringWithRange(NSRange.init(location: city.length - 1, length: 1))
                print("--------->>>>", shi)
                // 如果有市 根据接口需要的话 需要裁掉市
                if shi == "市" {
                    trueProvince = province.substringToIndex(province.length - 1)
                    trueCity = city.substringToIndex(city.length - 1)
                }else {
                    trueProvince = province as String
                    trueCity = city as String
                }
                
                Tools.setUserDefaults(key: "province", andVluew: trueProvince)
                Tools.setUserDefaults(key: "city", andVluew: trueCity)
                
                // 获取天气
                self.getWeather(trueCity, Over: {cityName, province in
                    
                })
            })
        }
    }
    
    //定位错误信息
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        
        print("[OTTLocationManager locationManager:didFinishDeferredUpdatesWithError] \(error)\(error?.description)")
    }
    
    //如果未开启定位服务或者获取不到定位，会走此代理方法
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //
        manager.stopUpdatingLocation()
        print("[OTTLocationManager locationManager:didFailWithError] 无法获取到定位")
        if Tools.getUserDefaults("city") != nil {
            
            getWeather(Tools.getUserDefaults("city") as? String, Over: {cityName, province in
                
            })
        }
        self.view.show("无法获取定位, 使用上次位置") { }
    }
    
    //MARK: ******************** 3D Touch *********************
    
    // 当3dtouch状态改变
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        check3dTouch()
    }
    
    //MARK: ******************** UIViewControllerPreviewingDelegate *********************
    
    // Peek手势相关处理
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?{
        // 防止重复加入
        if ((self.presentedViewController?.isKindOfClass(PeekViewController.classForKeyedUnarchiver())) != nil) {
            return nil
        }
        print("加入一次")
        return PeekViewController()
    }
    
    //Pop手势相关处理
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController){
        
    }
    
    //MARK: ******************** UIViewControllerPreviewingDelegate *********************

    //
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first

        // 摁的越重值越大
        if touch != nil && touch!.view == refreshTimeLabel {
            refreshTimeLabel.textColor = UIColor(red: (touch!.force) / 5 / 255.0, green: 1 / 255.0, blue: 1 / 255.0, alpha: 1)
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        refreshTimeLabel.textColor = UIColor.orangeColor()
    }
    
}
