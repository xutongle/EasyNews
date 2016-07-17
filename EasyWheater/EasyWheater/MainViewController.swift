//
//  MainViewController.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/9.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

/**
 * 22.5428234337,114.0595370000  深圳 纬度在前
 * 39.9046363143,116.4071136987 北京
 * 31.2983194973,120.5831906603 苏州
 **/

//
class MainViewController: UIViewController, CLLocationManagerDelegate, InfoBtnProtocol, LeftViewProtocol {
    
    // MARK: - -----------------------------属性-----------------------------
    
    //mob天气的相关
    let url = "http://apicloud.mob.com/v1/weather/query"
    let APP_KEY = "12c3624ad5993"
    
    //高德的相关
    let GEO_URL = "http://restapi.amap.com/v3/geocode/regeo"
    let GEOCODE_KEY = "ef7909b03e6aff21f1faf26157925012"
    
    //获得单利的定位管理
    let locationManager:CLLocationManager = Tools.locationManager
    
    //天气相关
    var weatherDict = NSDictionary()
    var allWeather:NSArray?
    
    // MARK: - -----------------------------生命周期-----------------------------
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        self.view.addSubview(HeadView.headView)
        //设置视图 来自extesion
        self.getTableView()
        self.addBottomView()
        
        //签署协议
        info_delegate = self
        left_delegate = self
    }
    
    //监听屏幕旋转
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
    }
    
    // 重写方法让那个状态栏变白
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //初始化 CLLocationManager
        initailLocation()
        
        // 背景视图
        BackgroundImageView.backgroundImageView.weather = "多云"
        
        // 从沙盒中取到图片
        SaveImageToDocment.saveImageToDocment.getImage({ (image) in
            if image != nil {
                BackgroundImageView.backgroundImageView.image = image
            }
        })
        // 添加背景视图
        self.view.addSubview(BackgroundImageView.backgroundImageView)
        
        // 左划手势
        let swipeLeftGestrue = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeLeftAction))
        swipeLeftGestrue.direction = .Right
        self.view.addGestureRecognizer(swipeLeftGestrue)
        
        // heand按钮事件
        btnAction = {whichButton in
            switch whichButton {
            case .isDrawUpButton:
                // 加载侧滑
                self.view.addLeftSlidingView()
                
                self.view.sliding(.OPEN)
                break
            case .isLocationButton:
                let webViewVC = WebViewController()
                self.presentViewController(webViewVC, animated: true, completion: nil)
                break
            case .isAddLocationButton:
                self.presentViewController(AddViewController.addViewController, animated: true, completion: nil)
                break
            }
        }
        
        // 来自CityListTableView
        backCityBlock = {cityName in
            self.chooseOverShowWeather(cityName)
        }
        
        // 来自AddViewController
        backSearchViewBlock = {cityName in
            self.chooseOverShowWeather(cityName as String)
        }
        
        // 监听通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reGetWeather_Locatin), name: "startLocation_GetWeather_Notification", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - -----------------------------自己的方法-----------------------------
    
    // 开启定位
    func reGetWeather_Locatin() -> Void {
        locationManager.startUpdatingLocation()
    }
    
    func chooseOverShowWeather(cityName: String) -> Void {
//      Tools.setUserDefaults(key: "province", andVluew: "")
//      Tools.setUserDefaults(key: "city", andVluew: cityName)
        
        // 获取天气 并保存到数据库
        self.getWheater(cityName, getWeatherOver: { (city, province) in
            // 侧滑的cell
            let leftFirstCell = SingleManager.singleManager.getValue(Key: "LeftSldingView_1") as? LeftTableViewCell
            
            if city != nil && province != nil {
                
                Tools.setUserDefaults(key: "province", andVluew: province!)
                Tools.setUserDefaults(key: "city", andVluew: city!)
                print(city, province)
                
                if leftFirstCell != nil {
                    leftFirstCell!.locationText = Tools.getUserDefaults("city") as! String
                    leftFirstCell!.weatherText = Tools.getUserDefaults("temperature") as! String
                }
                
                DBOperate.dbOperate.insertData(city!, provinceName: province!)
            }
        })
    }
    
    // 左划手势
    func swipeLeftAction(sender: UISwipeGestureRecognizer) -> Void {
        // 加载侧滑
        self.view.addLeftSlidingView()
        self.view.sliding(.OPEN)
    }
    
    // 初始化CLLocationManager
    func initailLocation() -> Void {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //更新距离
            locationManager.distanceFilter = kCLDistanceFilterNone
            //when in use
            locationManager.requestWhenInUseAuthorization()
            //
            locationManager.startUpdatingLocation()
        }
    }
    
    //反地理编码
    func getLocationName(location: CLLocation, complete:(province: NSString,city :NSString) -> Void) -> Void {
        
        /*
         //经度纬度
         let jing = CGFloat(location.coordinate.longitude)
         let wei = CGFloat(location.coordinate.latitude)
         
         //高德编码
         let locationStr = String.init(format: "%@?key=%@&location=%f,%f", GEO_URL, GEOCODE_KEY,  jing, wei)
         
         Alamofire.request(NSURLRequest.init(URL: NSURL.init(string: locationStr)!)).responseJSON { (response) in
         print(response.result.value)
         }
         */
        
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
    
    //获得天气
    func getWheater(city: String?, getWeatherOver: (city: String?, province: String?) -> Void) -> Void {
        
        let parameters = ["key":APP_KEY,"city":city == nil ?  Tools.getUserDefaults("city")! : city!,"province":Tools.getUserDefaults("province")!]
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                
                //
                let dict: NSDictionary = response.result.value as! NSDictionary
                
                if (dict["msg"] as! String == "success") {
                    
                    // 头视图 (成功获得了数据才行)
                    HeadView.headView.location = city == nil ? Tools.getUserDefaults("city") as! String : city!
                    
                    let array = dict["result"] as! NSArray
                    //将当前的天气信息存入
                    self.weatherDict = array.firstObject as! NSDictionary
                    //将全部天气存入数组
                    self.allWeather = self.weatherDict["future"] as? NSArray;
                    
                    //当天此刻的天气
                    let tempDict = self.allWeather![0] as! NSDictionary
                    
                    // --------观察者  当值改变时 视图也会改变--------------
                    
                    //
                    let weatherCell = SingleManager.singleManager.getValue(Key: "WeatherCell") as! WeatherTableViewCell
                    
                    //当前天气状态
                    Tools.setUserDefaults(key: "dayTime", andVluew: self.weatherDict["weather"]!)
                    weatherCell.stateText = Tools.getUserDefaults("dayTime") as! String
                    
                    //当前温度
                    Tools.setUserDefaults(key: "temperature", andVluew: self.weatherDict["temperature"]!)
                    weatherCell.weatherText = Tools.getUserDefaults("temperature") as! String
                    
                    //AnotherInfoCell
                    let anotherInfoCell = SingleManager.singleManager.getValue(Key: "AnotherCell") as! AnotherInfoTableViewCell
                    //当前湿度
                    Tools.setUserDefaults(key: "humidity", andVluew: self.weatherDict["humidity"]!)
                    anotherInfoCell.humidity = Tools.getUserDefaults("humidity") as! String
                    //最高最低温度
                    Tools.setUserDefaults(key: "fullTemperature", andVluew: tempDict["temperature"]!)
                    anotherInfoCell.fullTemperature = Tools.getUserDefaults("fullTemperature") as! String
                    //风速
                    Tools.setUserDefaults(key: "wind", andVluew: self.weatherDict["wind"]!)
                    anotherInfoCell.wind = Tools.getUserDefaults("wind") as! String
                    
                    //获得总共有几个横着显示天气的cell
                    let cellCount = Tools.getUserDefaults("CellCount") as! Int
                    //遍历把每一个cell拿到
                    for index in 1 ... cellCount {
                        
                        //laterCell
                        let strLaterCell = String.init(format: "LaterCell%d", index)
                        let laterCell = SingleManager.singleManager.getValue(Key: strLaterCell) as! LaterWeatherCell
                        let tomorrowDict = self.allWeather![index] as! NSDictionary
                        
                        //星期几
                        var str = String.init(format: "week%d", index)
                        Tools.setUserDefaults(key: str, andVluew: tomorrowDict["week"]!)
                        laterCell.week = Tools.getUserDefaults(str) as! String
                        
                        //状态（雷阵雨等）
                        str = String.init(format: "dayTime%d", index)
                        Tools.setUserDefaults(key: str, andVluew: tomorrowDict["dayTime"]!)
                        laterCell.dayTime1 = Tools.getUserDefaults(str) as! String
                        
                        //最低最高温
                        str = String.init(format: "temperature%d", index)
                        Tools.setUserDefaults(key: str, andVluew: tomorrowDict["temperature"]!)
                        laterCell.temperature1 = Tools.getUserDefaults(str) as! String
                    }
                    
                    //杂项
                    let bottomView = SingleManager.singleManager.getValue(Key: "bottomView") as! BottomView
                    //穿衣指数
                    let dressing = self.weatherDict["dressingIndex"] as! String
                    let dressingStr = "穿衣指数：" + dressing
                    Tools.setUserDefaults(key: "dressingIndex", andVluew: dressingStr)
                    bottomView.dressingIndex = Tools.getUserDefaults("dressingIndex") as! String
                    //锻炼
                    let exercise = self.weatherDict["exerciseIndex"] as! String
                    let exerciseStr = "锻炼适宜：" + exercise
                    Tools.setUserDefaults(key: "exerciseIndex", andVluew: exerciseStr)
                    bottomView.exerciseIndex = Tools.getUserDefaults("exerciseIndex") as! String
                    //空气质量
                    let air = self.weatherDict["airCondition"] as! String
                    let airStr = "空气质量：" + air
                    Tools.setUserDefaults(key: "airCondition", andVluew: airStr)
                    bottomView.airCondition = Tools.getUserDefaults("airCondition") as! String
                    //更新时间
                    let update = self.weatherDict["date"] as! String
                    let time = self.weatherDict["time"] as! String
                    let updateTime = update + "  " + time
                    Tools.setUserDefaults(key: "updateTime", andVluew: updateTime)
                    bottomView.updateTime = Tools.getUserDefaults("updateTime") as! String
                    //待更
                    
                    print(self.weatherDict)
                    // block
                    getWeatherOver(city: self.weatherDict["city"]! as? String, province: self.weatherDict["province"]! as? String)
                }else{
                    self.view.show("天气获取失败，请稍后重试", block: {})
                    
                    print(response.result.value)
                }
            }else{
                self.view.show("请检查网络，稍后重试", block: {})
            }
        }
    }
    
    // MARK: - -----------------------------定位的协议-----------------------------
    
    //定位开始
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //
        let currLocation:CLLocation = locations.last!
        
        //当位置稳定时
        if locations.first == locations.last {
            manager.stopUpdatingLocation()
            
            //逆地理位置的回调
            getLocationName(currLocation) { (province ,city) in
                
                var trueProvince:String!
                var trueCity:String!
                // 判断最后一个字是不是"市"字 碰到了没有市的 比如江苏 苏州
                let shi = city.substringWithRange(NSRange.init(location: city.length - 1, length: 1))
                print("--------->>>>",shi)
                // 如果有市 根据接口需要的话 需要裁掉市
                if shi == "市" {
                    trueProvince = province.substringToIndex(province.length - 1)
                    trueCity = city.substringToIndex(city.length - 1)
                }else {
                    trueProvince = province as String
                    trueCity = city as String
                }
                
                // 如果之前没有存入过,就存入数据库
                if !DBOperate.dbOperate.queryIsExitsData(trueCity) {
                    if !DBOperate.dbOperate.insertData(trueCity, provinceName: trueProvince){
                        self.view.show("数据库操作失败了", block: {
                            
                        })
                    }else {
                        print("数据库存储成功")
                    }
                }else {
                    print("存储过了")
                }
                
                Tools.setUserDefaults(key: "province", andVluew: trueProvince)
                Tools.setUserDefaults(key: "city", andVluew: trueCity)
                
                self.getWheater(nil, getWeatherOver: { (city, province) in
                    
                })
            }
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
        if Tools.getUserDefaults("city") != nil && allWeather == nil {
            
            getWheater(nil, getWeatherOver: { (city, province) in
                
            })
        }
        self.view.show("无法获取定位") { }
    }
    
    // MARK: - ----------------------自己的协议InfoBtnProtocol------------------
    
    // 右下角按钮事件协议
    func infoBtnAction(button: UIButton) {
        
        //去除按钮高亮
        button.adjustsImageWhenHighlighted = false
        UIView.animateWithDuration(0.25) {
            //位置不同动画不同
            button.frame = self.view.frame
            button.removeFromSuperview()
            self.view.addSubview(button)
            button.setImage(UIImage.init(named: "infobg"), forState: .Normal)
        }
    }
    
    // settingProtocol 设置按钮事件
    func settingBtnAction() -> Void {
        self.view.sliding(.CLOSE)
        
        self.presentViewController(SettingViewController(), animated: true, completion: nil)
    }
    
    // cell 的点按事件
    func chooseHitsoryCity(citys: NSDictionary) -> Void {
        Tools.setUserDefaults(key: "city", andVluew: citys["city"]!)
        Tools.setUserDefaults(key: "province", andVluew: citys["province"]!)
        
        // 侧滑的cell对象
        let leftFirstCell = SingleManager.singleManager.getValue(Key: "LeftSldingView_1") as! LeftTableViewCell
        
        getWheater(nil) { (city, province) in
            leftFirstCell.locationText = Tools.getUserDefaults("city") as! String
            leftFirstCell.weatherText = Tools.getUserDefaults("temperature") as! String
        }
    }
}
