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

class MainViewController: UIViewController {
    
    //mob天气的相关
    let url = "http://apicloud.mob.com/v1/weather/query"
    let APP_KEY = "12c3624ad5993"
    
    var slidingView: SlidingView!
    
    //
    var mainTableView: MainTableView!
    
    // 重写方法让那个状态栏变白
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let background = BackgroundImageView.backgroundImageView
        background.weather = "多云"
        self.view.addSubview(background)
        
        let topView = TopView(frame: CGRectMake(0, 20, SCREEN_WIDTH, 44))
        self.view.addSubview(topView)
        
        mainTableView = MainTableView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64), style: .Plain)
        self.view.addSubview(mainTableView)
        
        slidingView = self.view.addSlidingView_zly()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
                break
            }
        }
        
        // 设置按钮回掉
        setttingBlock = {
            
        }
        
        getWeather("深圳") {
            
        }
    }
    
    // MARK: - －－－－－－－－－－－－－－－－－－－－ 自己的方法 －－－－－－－－－－－－－－－－－－
    func getWeather(city: String?, Over: () -> Void) -> Void {
        
        let parameters = ["key":APP_KEY,"city":city == nil ?  Tools.getUserDefaults("city")! : city!,"province":Tools.getUserDefaults("province") == nil ? "" : Tools.getUserDefaults("province")!]
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON { (response) in
            let result = response.result
            if result.isSuccess {
                let json = JSON(response.result.value!)
                // 如果获得天气成功
                if json["retCode"].intValue == 200 {
                    let allInfo = json["result"].arrayValue[0].dictionaryValue
                    let futureInfo = allInfo["future"]
                    
                    // 天气信息
                    self.mainTableView.weatherInfoDict = NSMutableDictionary()
                    self.mainTableView.weatherInfoDict =
                        ["temperature_now": allInfo["temperature"]!.stringValue,
                            "weather": allInfo["weather"]!.stringValue,
                            "temperature_future": futureInfo![0]["temperature"].stringValue]
                    // 其他天气信息
                    self.mainTableView.otherWeatherInfoDict = NSMutableDictionary()
                    self.mainTableView.otherWeatherInfoDict = ["wind": allInfo["wind"]!.stringValue, "humidity": allInfo["humidity"]!.stringValue, "coldIndex": allInfo["coldIndex"]!.stringValue]
                    self.mainTableView.lastdayWeatherInfo = NSMutableArray()
                    for (index: index, subJson: value) in futureInfo!{
                        if NSInteger(index) > 0 {
                            self.mainTableView.lastdayWeatherInfo[NSInteger(index)! - 1] = ["week":value["week"].stringValue, "dayTime":value["dayTime"].stringValue, "temperature":value["temperature"].stringValue]
                        }
                    }
                    
                    print(allInfo)
                    self.mainTableView.reloadData()
                }else {
                    self.view.show("获取天气失败", block: { })
                }
            }
        }
    }
    
}
