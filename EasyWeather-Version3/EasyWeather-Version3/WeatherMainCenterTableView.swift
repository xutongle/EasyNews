//
//  WeatherMainCenterTableView.swift
//  EasyWeather-Version3
//
//  Created by mac_zly on 2016/10/15.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class WeatherMainCenterTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    fileprivate let m_height = SCREEN_HEIGHT - 64 - SCREEN_HEIGHT / 3.5
    static let weatherMainCenterTableView = WeatherMainCenterTableView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - SCREEN_HEIGHT / 3.5), style: .plain)
    
    var dataSourceDict: [String: String]! = [:] {
        didSet{
            self.reloadData()
        }
    }
    
    // 空气质量
    fileprivate var airQuality: UILabel!
    // pm2.5
    fileprivate var pm25Label: UILabel!
    // 风向
    fileprivate var windDir: UILabel!
    
    
    // 今日天气图标
    fileprivate var temperatureImage: UIImageView!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        self.tableFooterView = UIView()
    }
    
    // MARK: - ===================  UITableViewDataSource ===================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if dataSourceDict != nil {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return UITableViewCell()
        case 1:
            let cell = WeatherMainCenterTableViewCell_1.cellWith(tableView: tableView)
            cell.temperatureLabel.text = "31°C"
            cell.fellTemperatureLabel.text = "20°C"
            cell.maxMinTempratureLabel.text = "20°C/30°C"
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return m_height - 180
        case 1:
            return 180
        default:
            return 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class WeatherMainCenterTableViewCell_1: UITableViewCell {
    
    // 今日天气温度
    var temperatureLabel: UILabel!
    // 最低最高温度
    var maxMinTempratureLabel: UILabel!
    // 体感温度
    var fellTemperatureLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = UIColor.clear
        
        self.temperatureLabel = UILabel()
        self.contentView.addSubview(self.temperatureLabel)
        self.maxMinTempratureLabel = UILabel()
        self.contentView.addSubview(self.maxMinTempratureLabel)
        self.fellTemperatureLabel = UILabel()
        self.addSubview( self.fellTemperatureLabel)
        
        self.temperatureLabel.setStyle(nil, bgColor: MY_LIGHT_GREEN, color: nil, fontName: nil, textSize: 50 * Font_Scale, alignment: .center)
        self.temperatureLabel.snp.makeConstraints { [weak self] (make) in
            make.top.equalTo(self!)
            make.width.equalTo(self!.temperatureLabel.snp.height)
        }
        
        self.fellTemperatureLabel.setStyle(nil, bgColor: MY_ORANGE, color: nil, fontName: nil, textSize: nil, alignment: .center)
        self.fellTemperatureLabel.snp.makeConstraints { [weak self] (make) in
            make.left.equalTo(self!.temperatureLabel.snp.right)
            make.bottom.equalTo(self!.temperatureLabel.snp.bottom)
        }
        
        self.maxMinTempratureLabel.setStyle(nil, bgColor: MY_SOME_RED, color: nil, fontName: nil, textSize: nil, alignment: .center)
        self.maxMinTempratureLabel.snp.makeConstraints { [weak self] (make) in
            make.top.equalTo(self!.temperatureLabel.snp.bottom)
            make.leading.equalTo(self!.temperatureLabel)
            make.trailing.equalTo(self!.temperatureLabel)
            make.bottom.equalTo(self!.contentView)
            make.height.equalTo(20 * Font_Scale)
        }
        
    }
    
    static func cellWith(tableView: UITableView) -> WeatherMainCenterTableViewCell_1 {
        let ID = "WeatherMainCenterTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? WeatherMainCenterTableViewCell_1
        if cell == nil {
            cell = WeatherMainCenterTableViewCell_1(style: .default, reuseIdentifier: ID)
        }
        return cell!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
