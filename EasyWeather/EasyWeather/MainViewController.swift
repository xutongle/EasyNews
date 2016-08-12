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

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    //mob天气的相关
    let url = "http://apicloud.mob.com/v1/weather/query"
    let APP_KEY = "12c3624ad5993"
    
    var slidingView: SlidingView!
    
    //
    var mainTableView: MainTableView!
    
    //
    let clLocationManager: CLLocationManager = CLLocationManager()
    
    // 需要刷新
    var needRefresh = false
    
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
        
        self.view.addSubview(background)
        
        self.view.addSubview(TopView.topView)
        
        mainTableView = MainTableView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64), style: .Plain)
        self.view.addSubview(mainTableView)
        
        slidingView = self.view.addSlidingView_zly()
        
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
            self.getWeather(city, Over: { (cityName, province) in  })
        }
        
        let swapLeftGestrue = UISwipeGestureRecognizer(target: self, action: #selector(openSlidingView))
        swapLeftGestrue.direction = .Right
        self.view.addGestureRecognizer(swapLeftGestrue)
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
        
        let parameters = ["key":APP_KEY,
                          "city":city == nil ?  Tools.getUserDefaults("city")! : city!,
                          "province":Tools.getUserDefaults("province") == nil ? "" : Tools.getUserDefaults("province")!]
        
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
                    var temperature_future = futureInfo![0]["temperature"].stringValue
                    // 字符串够长再裁剪
                    if (temperature_future as NSString).length > 4 {
                        let range = temperature_future.rangeOfString("/")
                        let max_temperature = temperature_future.substringToIndex(range!.startIndex.advancedBy(-1))
                        let min_temperature = temperature_future.substringFromIndex(range!.startIndex.advancedBy(2))
                        temperature_future = max_temperature + "\n" + min_temperature
                        print(max_temperature, "-" ,min_temperature)
                    }
                    self.mainTableView.weatherInfoDict =
                        ["temperature_now": allInfo["temperature"]!.stringValue,
                            "weather": allInfo["weather"]!.stringValue,
                            "temperature_future": temperature_future]
                    // 缓存用
                    tempArray.append(allInfo["temperature"]!.stringValue)
                    tempArray.append(allInfo["weather"]!.stringValue)
                    tempArray.append(temperature_future)
                    // 其他天气信息
                    self.mainTableView.otherWeatherInfoDict = NSMutableDictionary()
                    self.mainTableView.otherWeatherInfoDict =
                        ["wind": allInfo["wind"]!.stringValue,
                            "humidity": allInfo["humidity"]!.stringValue,
                            "coldIndex": allInfo["coldIndex"]!.stringValue]
                    tempArray.append(allInfo["wind"]!.stringValue)
                    tempArray.append(allInfo["humidity"]!.stringValue)
                    tempArray.append(allInfo["coldIndex"]!.stringValue)
                    // 剩下几天的天气信息
                    self.mainTableView.lastdayWeatherInfo = NSMutableArray()
                    for (index: index, subJson: value) in futureInfo!{
                        if NSInteger(index) > 0 {
                            self.mainTableView.lastdayWeatherInfo[NSInteger(index)! - 1] =
                                ["week": value["week"].stringValue,
                                    "dayTime": value["dayTime"].stringValue,
                                    "temperature": value["temperature"].stringValue]
                            if (NSInteger(index)! - 1 < 3) {
                                tempArray.append(value["week"].stringValue)
                                tempArray.append(value["dayTime"].stringValue)
                                tempArray.append(value["temperature"].stringValue)
                            }
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
                    print(allInfo)
                    Over(cityName: allInfo["city"]!.stringValue, province: allInfo["province"]!.stringValue)
                    self.mainTableView.reloadData()
                }else {
                    self.view.show("获取天气失败", block: { })
                }
            }
        }
    }
    
    func refreshDataWithSliding() -> Void {
        dispatch_async(dispatch_queue_create("selectQuque", DISPATCH_QUEUE_CONCURRENT)) {
            DBOperaCityList.dbOperaCityList.queryCityAndProvince { (cityInfo) in
                self.view.getSlidingView_zly().dataForTableView = cityInfo
                self.view.getSlidingView_zly().reloadData()
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
    
    // MARK: - -----------------------------定位的协议-----------------------------
    
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
}
