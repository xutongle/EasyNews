//
//  EasyWeatherViewController.swift
//  EasyWeather-Version3
//
//  Created by mac_zly on 2016/10/15.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    fileprivate let url = "https://api.heweather.com/x3/weather"
    fileprivate let privateKey = "e66a51b533c9451b87163c0a3c10eb2f"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MY_DARK_GREEN
        
        self.view.addSubview(WeatherBGView.weatherBGView)
        WeatherBGView.weatherBGView.bgImage = #imageLiteral(resourceName: "lvzaotou")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func GetWeather(city: String, complete: (() -> Void) ) -> Void {
        
        ZLY_NetWorking.POST(url: self.url, parameter: "city=" + city + "&key=" + self.privateKey, serializationOption: .mutableContainers, Complete: { (res) in
            print(res)
            
        }) { (str) in
            print(str)
        }
        
    }

}
