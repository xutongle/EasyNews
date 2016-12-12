//
//  WeatherScrollView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/11.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class WeatherScrollView: UIScrollView, UIScrollViewDelegate {

    private var weatherView: WeatherView!
    private var searchTableView: SearchTableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.backgroundColor = UIColor.groupTableViewBackground
        self.isPagingEnabled = true
        self.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: SCREEN_HEIGHT)
        
        weatherView = WeatherView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.addSubview(weatherView)
        
        searchTableView = SearchTableView(frame: CGRect(x: SCREEN_WIDTH, y: 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 20), style: .grouped)
        self.addSubview(searchTableView)
    }
    
    func getWeatherView() -> WeatherView {
        return weatherView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
