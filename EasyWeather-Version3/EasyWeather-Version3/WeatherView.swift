//
//  WeatherView.swift
//  EasyWeather-Version3
//
//  Created by mac_zly on 2016/10/15.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

// 天气视图
class WeatherView: UIView, UITableViewDelegate, UITableViewDataSource {

    static let weatherView = WeatherView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
    
    // 后续天气
    fileprivate var otherDayWeatherTableView: UITableView!
    var dataSourceArray: [[String:String]]! = [[:]] {
        didSet{
            self.otherDayWeatherTableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.otherDayWeatherTableView = UITableView()
        self.otherDayWeatherTableView.delegate = self
        self.otherDayWeatherTableView.dataSource = self
        self.otherDayWeatherTableView.rowHeight = SCREEN_HEIGHT / 3.5 / 3.0
        self.otherDayWeatherTableView.separatorInset = UIEdgeInsets.zero
        self.otherDayWeatherTableView.layoutMargins = UIEdgeInsets.zero
        self.otherDayWeatherTableView.backgroundColor = UIColor.clear
        self.otherDayWeatherTableView.bounces = false
        self.addSubview(self.otherDayWeatherTableView)
        self.otherDayWeatherTableView.snp.makeConstraints { [weak self] (make) in
            make.bottom.left.right.equalTo(self!)
            make.height.equalTo(SCREEN_HEIGHT / 3.5)
        }
    }
    
    // MARK: - ===================  UITableViewDataSource ===================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if dataSourceArray != nil {
            return dataSourceArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OtherDayWeatherTableViewCell.cellWith(tableView: tableView)
        
        let dict = dataSourceArray[indexPath.row]
        
        cell.dayLabel.text = dict["date"]
        cell.weekLabel.text = dict["week"]
        cell.sun_rise_downLabel.text = dict["sun_rise_down"]
        cell.temperatureLabel.text = dict["temperature"]
        
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// cell
private class OtherDayWeatherTableViewCell: UITableViewCell {
    
    // 日期
    var dayLabel: UILabel!
    var weekLabel: UILabel!
    var sun_rise_downLabel: UILabel!
    var temperatureLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.backgroundColor = UIColor.clear
        
        self.dayLabel = UILabel()
        self.contentView.addSubview(self.dayLabel)
        self.weekLabel = UILabel()
        self.contentView.addSubview(self.weekLabel)
        self.sun_rise_downLabel = UILabel()
        self.contentView.addSubview(self.sun_rise_downLabel)
        self.temperatureLabel = UILabel()
        self.contentView.addSubview(self.temperatureLabel)
        
        self.weekLabel.setStyle(nil, bgColor: nil, color: WHITE, fontName: nil, textSize: nil, alignment: .center)
        self.weekLabel.snp.makeConstraints { [weak self] (make) in
            make.top.equalTo(self!.contentView)
            make.left.equalTo(self!.contentView)
        }
        
        self.dayLabel.setStyle(nil, bgColor: nil, color: WHITE, fontName: nil, textSize: nil, alignment: .center)
        self.dayLabel.snp.makeConstraints { [weak self] (make) in
            make.leading.equalTo(self!.weekLabel)
            make.top.equalTo(self!.weekLabel.snp.bottom)
            make.height.equalTo(self!.weekLabel.snp.height)
            make.bottom.equalTo(self!.contentView)
        }
        
        self.sun_rise_downLabel.setStyle(nil, bgColor: nil, color: WHITE, fontName: nil, textSize: nil, alignment: .center)
        self.sun_rise_downLabel.snp.makeConstraints { [weak self] (make) in
            make.top.equalTo(self!.weekLabel)
            make.left.equalTo(self!.weekLabel.snp.right)
            make.right.equalTo(self!.contentView)
            make.width.equalTo(self!.weekLabel.snp.width)
        }
        
        self.temperatureLabel.setStyle(nil, bgColor: nil, color: WHITE, fontName: nil, textSize: nil, alignment: .center)
        self.temperatureLabel.snp.makeConstraints { [weak self] (make) in
            make.left.equalTo(self!.dayLabel.snp.right)
            make.top.equalTo(self!.sun_rise_downLabel.snp.bottom)
            make.right.equalTo(self!.contentView)
            make.bottom.equalTo(self!.contentView)
            make.width.equalTo(self!.dayLabel.snp.width)
            make.height.equalTo(self!.sun_rise_downLabel.snp.height)
        }
    }
    
    static func cellWith(tableView: UITableView) -> OtherDayWeatherTableViewCell {
        let ID = "OtherDayWeatherTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? OtherDayWeatherTableViewCell
        if cell == nil {
            cell = OtherDayWeatherTableViewCell(style: .default, reuseIdentifier: ID)
        }
        return cell!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

