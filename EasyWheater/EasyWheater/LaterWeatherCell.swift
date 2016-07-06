//
//  LaterWeatherCell.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/24.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

private var count = 1

class LaterWeatherCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherAndStateBtn: UIButton!
    
    //星期几
    var week =  Tools.getUserDefaults(String.init(format: "week%d", count)) != nil ? Tools.getUserDefaults(String.init(format: "week%d", count)) as! String : "无"{
        didSet{
            dateLabel.text = week
        }
    }
    
    //最低最高温度
    var dayTime1 = Tools.getUserDefaults(String.init(format: "dayTime%d", count)) != nil ? Tools.getUserDefaults(String.init(format: "dayTime%d", count)) as! String : "无" {
        didSet{
            changeBtnValue()
        }
    }

    //风力风向
    var temperature1 = Tools.getUserDefaults(String.init(format: "temperature%d", count)) != nil ? Tools.getUserDefaults(String.init(format: "temperature%d", count)) as! String : " "{
        didSet{
            changeBtnValue()
        }
    }
    
    func changeBtnValue() -> Void {
        let btnValue = dayTime1 + "   " + temperature1

        weatherAndStateBtn.setTitle(btnValue, forState: .Normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.selectionStyle = .None
        
        //
        count += 1
        
        //给予保存到的值或者默认值
        self.dateLabel.text = week
        let btnValue = dayTime1 + temperature1
        self.weatherAndStateBtn.setTitle(btnValue, forState: .Normal)
        self.weatherAndStateBtn.userInteractionEnabled = false
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
