//
//  WeatherHeadView.swift
//  EasyWeather-Version3
//
//  Created by mac_zly on 2016/10/15.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class WeatherHeadView: UIView {

    static let weatherHeadView = WeatherHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
    
    //城市按钮
    fileprivate var cityButton: UIButton!
    
    // 城市
    var city = "💢" {
        didSet{
            cityButton.setTitle(city, for: .normal)
        }
    }
    
    // 按了添加按钮的回调
    var addActionBlock: (() -> Void)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // 容器
        let contentView = UIView()
        contentView.backgroundColor = UIColor.clear
        self.addSubview(contentView)
        contentView.snp.makeConstraints { [weak self] (make) in
            make.centerX.equalTo(self!)
            make.top.equalTo(self!).offset(20)
            make.left.right.equalTo(self!)
        }
        
        // 城市按钮
        self.cityButton = UIButton()
        self.cityButton.setTitle(city, for: .normal)
        contentView.addSubview(cityButton)
        self.cityButton.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
        
        let rightAddBtn = UIButton()
        rightAddBtn.setTitle("➕", for: .normal)
        contentView.addSubview(rightAddBtn)
        rightAddBtn.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
