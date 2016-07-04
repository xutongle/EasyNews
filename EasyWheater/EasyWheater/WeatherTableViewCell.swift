//
//  WeatherTableViewCell.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/16.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weaterButton: UIButton!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var apparentLabel: UILabel!
    
    //天气情况
    var stateText:String = Tools.getUserDefaults("dayTime") as! String {
        didSet{
            stateLabel.text = stateText
            
            var image = UIImage.init(named: stateText)
            if image == nil {
                self.weatherImageView.backgroundColor = UIColor.orangeColor()
                self.weatherImageView.image = UIImage.init(named: "")
                
            }else {
                self.weatherImageView.image = UIImage.init(named: stateText)
                self.weatherImageView.backgroundColor = UIColor.clearColor()
            }
            image = nil
        }
    }
    
    //温度
    var weatherText:String = Tools.getUserDefaults("temperature") as! String {
        didSet{
            weaterButton.setTitle(weatherText, forState: .Normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        
        //颜色
        self.weaterButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.stateLabel.textColor = UIColor.whiteColor()
        self.apparentLabel.textColor = UIColor.whiteColor()
        
        //默认值
        stateLabel.text = stateText
        weaterButton.setTitle(weatherText, forState: .Normal)
        self.apparentLabel.text = "体感温度 40°C"
        self.weatherImageView.contentMode = .ScaleAspectFill
        
        //判断有没有图，有图就显示，没有图就显示黄色
        var image = UIImage.init(named: stateText)
        if image == nil {
            self.weatherImageView.backgroundColor = UIColor.orangeColor()
            self.weatherImageView.image = UIImage.init(named: "");
        }else {
            self.weatherImageView.backgroundColor = UIColor.clearColor()
            self.weatherImageView.image = image
        }
        image = nil
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func weatherButtonAction(sender: UIButton, forEvent event: UIEvent) {
        
    }
}
