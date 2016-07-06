//
//  AnotherInfoTableViewCell.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/24.
//  Copyright © 2016年 private. All rights reserved.
//

/*
 
 */

import UIKit

class AnotherInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var centerBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    //湿度
    var humidity = Tools.getUserDefaults("humidity") != nil ? Tools.getUserDefaults("humidity") as! String : "无" {
        didSet{
            leftBtn.setTitle(humidity, forState: .Normal)
        }
    }
    //最高最低温度
    var fullTemperature = Tools.getUserDefaults("fullTemperature") != nil ? Tools.getUserDefaults("fullTemperature") as! String : "无" {
        didSet{
            centerBtn.setTitle(fullTemperature, forState: .Normal)
        }
    }
    
    //风速
    var wind = Tools.getUserDefaults("wind") != nil ? Tools.getUserDefaults("wind") as! String : "无" {
        didSet{
            rightBtn.setTitle(wind, forState: .Normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //背景透明
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        
        leftBtn.userInteractionEnabled = false
        centerBtn.userInteractionEnabled = false
        rightBtn.userInteractionEnabled = false
        
        //默认值
        leftBtn.setTitle(humidity, forState: .Normal)
        centerBtn.setTitle(fullTemperature, forState: .Normal)
        rightBtn.setTitle(wind, forState: .Normal)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func drawRect(rect: CGRect) {
        //画两条线
        let pathPen = UIBezierPath.init()
        
        //第一条
        pathPen.moveToPoint(CGPointMake(SCREEN_WIDTH / 3, 20))
        pathPen.addLineToPoint(CGPointMake(SCREEN_WIDTH / 3, 40))
        UIColor.whiteColor().setStroke()
        pathPen.lineWidth = 1
        pathPen.stroke()
        
        //第二条
        pathPen.moveToPoint(CGPointMake(SCREEN_WIDTH / 3 * 2, 20))
        pathPen.addLineToPoint(CGPointMake(SCREEN_WIDTH / 3 * 2, 40))
        pathPen.stroke()
    }
}
