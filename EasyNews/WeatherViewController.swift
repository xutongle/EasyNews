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

class WeatherViewController: UIViewController {
    
    private var models: [WeatherModel] = []
    private var tableview: WeatherTableView!
    
    // state bar变白
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        tableview = WeatherTableView(frame: self.view.bounds)
        self.view.addSubview(tableview)
        
        // 请求天气数据
        Alamofire.request(NetTool.weathereUrl, method: .get, parameters: nil).responseJSON { (response) in
            guard let result = response.result.value as? [String : Any] else {
                return
            }
            guard let results = result["results"] as? [String : Any] else {
                return
            }
            guard let daily = results["daily"] as? [[String : String]] else {
                return
            }
            for model in daily {
                self.models.append(WeatherModel(fromDictionary: model as NSDictionary))
            }
            
        }
        
        
    }

}
