//
//  WeatherViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import CoreLocation

/// 天气控制器
class WeatherViewController: UIViewController {
    
    // view
    fileprivate var weatherScrollView: WeatherScrollView!
    
    // 定位
    fileprivate let locationManager = Tools.locationManage
    
    // 两个model
    fileprivate var nowModel: TodayViewModel!
    fileprivate var weatherModels: [WeatherModel] = []
    fileprivate var isRequest = false
    // 显示的view
    fileprivate var isShow = false
    
    //  线程
    fileprivate let group = DispatchGroup()
    let currentQueue = DispatchQueue(label: "com.requestCurrentWeather")
    let threeQueue = DispatchQueue(label: "com.requestThreeDayWeather")
    
    // state bar变白
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isShow {
            let count = Tools.getUserDefaults(key: "ShowHelperCircleCount") as? Int ?? 0
            // 只显示3次
            if count < 3 {
                showHelperCircle()
                Tools.setUserDefaults(key: "ShowHelperCircleCount", andValue: count + 1)
            }
            isShow = !isShow
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
     
        self.weatherScrollView = WeatherScrollView(frame: self.view.bounds)
        self.view.addSubview(self.weatherScrollView)
        
        // 准备定位
        self.getLocationPre()
        
        // 监听通知 需要改变Scroll的位置
        NotificationCenter.default.addObserver(forName: NSNotification.Name(LocalConstant.NeedChangeScrollPostion), object: nil, queue: nil, using: { notification in
            //
            self.weatherScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
            self.setEditing(false, animated: true)
            
            guard let info = notification.userInfo else {
                return
            }
            guard let city = info["city"] as? String else {
                return
            }
            self.requestWeather(city: city)
        })
    }
}

// MARK: - 网络请求
extension WeatherViewController {
    
    func requestWeather(city: String?) -> Void {
        guard !isRequest && (city != nil) else {
            return
        }
        
        // 正在请求
        isRequest = true
        
        currentQueue.sync { [weak self] in
            if let weakSelf = self {
                // 入
                weakSelf.group.enter()
                weakSelf.requestCurrentWeather(city: city!)
            }
        }
        threeQueue.sync { [weak self] in
            if let weakSelf = self {
                // 入
                weakSelf.group.enter()
                weakSelf.requestThreeDayWeather(city: city!)
            }
        }
        
        // 网络任务都完成
        group.notify(queue: DispatchQueue.main) {
            // 请求完成
            self.isRequest = false
            if self.nowModel != nil && self.weatherModels.count > 0 {  // 展示完成的结果
                self.weatherScrollView.getWeatherView().models = self.weatherModels
                self.weatherScrollView.getWeatherView().todayViewModel = self.nowModel
                
                Toast.toast.show(message: "数据请求成功", duration: .nomal, removed: nil)
            }else {
                Toast.toast.show(message: "数据请求失败", duration: .nomal, removed: nil)
            }
        }
    }
    
    // 当时天气
    func requestCurrentWeather(city: String) -> Void {
        self.nowModel = nil
        Alamofire.request(NetTool.currentUrl, method: .get, parameters: NetTool.getCurrentUrlParam(city: city)).responseJSON { (response) in
            // 出
            self.group.leave()
            guard let result = response.result.value as? [String : Any] else {
                return
            }
            guard let resultsArr = result["results"] as? [[String : Any]?] else {
                return
            }
            guard let results = resultsArr[0] else {
                return
            }
            guard let locations = results["location"] as? [String : String] ,let nows = results["now"] as? [String : String] else {
                return
            }
            
            let location = NetTool.toString(any: locations["name"])
            let now = NetTool.toString(any: nows["temperature"])
            self.nowModel = TodayViewModel(cityName: location, temperature: now)
        }
    }
    
    // 请求天气数据
    func requestThreeDayWeather(city: String) -> Void {
        self.weatherModels.removeAll()
        Alamofire.request(NetTool.weathereUrl, method: .get, parameters: NetTool.getWeathereUrlParam(city: city)).responseJSON { (response) in
            // 出
            self.group.leave()
            guard let result = response.result.value as? [String : Any] else { // 获得数据
                return
            }
            guard let resultArr = result["results"] as? [[String : Any]?] else {
                return
            }
            guard let results = resultArr[0] else {
                return
            }
            guard let daily = results["daily"] as? [[String : String]] else {
                return
            }
            
            for model in daily {
                self.weatherModels.append(WeatherModel(fromDictionary: model as NSDictionary))
            }
        }
    }
}

extension WeatherViewController {
    //
    fileprivate func showHelperCircle(){
        let circle = UIView(frame: CGRect(
            origin: CGPoint(x: view.bounds.width * 0.5, y: 100),
            size: CGSize(width: 30, height: 30)
        ))
        circle.layer.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor.white
        circle.layer.shadowOpacity = 0.8
        circle.layer.shadowOffset = CGSize.zero
        view.addSubview(circle)
        
        UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseIn, animations: {
            circle.frame.origin.y += 200
            circle.layer.opacity = 0
        }) { (finsh) in
            circle.removeFromSuperview()
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    // MARK: - ======== 定位=========
    func getLocationPre() -> Void {
        
        // 开启了定位
        if (CLLocationManager.locationServicesEnabled()) {
            // 请求允许使用定位
            if self.locationManager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) {
                self.locationManager.requestWhenInUseAuthorization()
            }
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest //定位精准度
            self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
            // 开始定位
            self.locationManager.startUpdatingLocation()
        }else {
            CLLocationManager.authorizationStatus()
            Toast.toast.show(message: "定位未开启", duration: .nomal, removed: nil)
        }
    }
    
    //
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            
            self.reverseGeocodeLocation(location: newLocation, complete: { [weak self] (city) in
                if let strongSelf = self {
                    strongSelf.requestWeather(city: city)
                }
            })
        }
    }
    
    
    //MARK:定位错误信息
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        Toast.toast.show(message: "定位出错", duration: .nomal, removed: nil)
    }
    
    //检测是否获取到定位
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //如果未开启定位服务或者获取不到定位，会走此代理方法
        manager.stopUpdatingLocation()
        Toast.toast.show(message: "未得到位置， 重新获取中...", duration: .nomal, removed: nil)
    }
    
    // MARK: - ============ 逆地理编码 ==================
    func reverseGeocodeLocation(location: CLLocation, complete: @escaping (_ city: String) -> Void) -> Void {
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (pms, err) -> Void in
            guard pms != nil else {
                return
            }
            // 停止定位
            self.locationManager.stopUpdatingLocation()
            //取得最后一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
            guard let placemark = pms!.last else {
                return
            }
            
            if let locality=placemark.locality{ // 城市
                complete(locality)
            }
            
        })
    }
}
