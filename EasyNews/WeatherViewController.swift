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

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    private var tableview: WeatherView!
    
    private let locationManager = Tools.locationManage
    
    private var gestrue: UISwipeGestureRecognizer!
    
    private var nowModel: TodayViewModel = TodayViewModel()
    private var models: [WeatherModel] = []
    
    private var isRequest = [false, false] {
        didSet{
            if !isRequest[0] && !isRequest[1] {  // 两个网路都请求完毕
                self.tableview.models = models
                self.tableview.todayViewModel = nowModel
                self.removeTransationView()
            }
        }
    }
    
    // state bar变白
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        tableview = WeatherView(frame: self.view.bounds)
        self.view.addSubview(tableview)
     
        // 准备定位
        self.getLocationPre()
        
        gestrue = UISwipeGestureRecognizer(target: self, action: #selector(closeMe))
        gestrue.direction = .down
        self.view.addGestureRecognizer(gestrue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if gestrue != nil {
            self.view.removeGestureRecognizer(gestrue)
        }
    }
    
    func closeMe() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestWeather(city: String?) -> Void {
        if isRequest[0] || isRequest[1] || city == nil{
            return
        }
        isRequest = [true, true]
        requestCurrentWeather(city: city!)
        requestThreeDayWeather(city: city!)
    }
    
    // 当时天气
    func requestCurrentWeather(city: String) -> Void {
        Alamofire.request(NetTool.currentUrl, method: .get, parameters: NetTool.getCurrentUrlParam(city: city)).responseJSON { (response) in
            self.isRequest[0] = false
            if response.result.isFailure {
                Toast.toast.show(message: "当前天气获取出错", duration: .nomal, block: nil)
            }
            guard let result = response.result.value as? [String : Any] else {
                return
            }
            guard let resultsArr = result["results"] as? [[String : Any]?] else {
                return
            }
            guard let results = resultsArr[0] else {
                return
            }
            guard let locations = results["location"] as? [String : String] , let nows = results["now"] as? [String : String] else {
                return
            }
            let location = NetTool.toString(any: locations["name"])
            let now = NetTool.toString(any: nows["temperature"])
            self.nowModel = TodayViewModel(cityName: location, temperature: now)
        }
    }
    
    // 请求天气数据
    func requestThreeDayWeather(city: String) -> Void {
        Alamofire.request(NetTool.weathereUrl, method: .get, parameters: NetTool.getWeathereUrlParam(city: city)).responseJSON { (response) in
            self.isRequest[1] = false
            if response.result.isFailure {
                Toast.toast.show(message: "天气数据获取出错", duration: .nomal, block: nil)
            }
            guard let result = response.result.value as? [String : Any] else {
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
                self.models.append(WeatherModel(fromDictionary: model as NSDictionary))
            }
            self.tableview.models = self.models
        }
    }
    
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
            Toast.toast.show(message: "定位未开启", duration: .nomal, block: nil)
        }
    }
    
    //
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            
            self.showTransationView(style: .dark)  // 展示过场动画 当isRequest的两个值都为false 都不在请求网络时 消失 通过KVO
            
            self.reverseGeocodeLocation(location: newLocation, complete: { [weak self] (city) in
                if let strongSelf = self {
                    strongSelf.requestWeather(city: city)
                }
            })
        }
    }
    
    
    //MARK:定位错误信息
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        
        Toast.toast.show(message: "定位出错", duration: .nomal, block: nil)
    }
    
    //检测是否获取到定位
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //如果未开启定位服务或者获取不到定位，会走此代理方法
        manager.stopUpdatingLocation()
        Toast.toast.show(message: "未得到位置， 重新获取中...", duration: .nomal, block: nil)
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
