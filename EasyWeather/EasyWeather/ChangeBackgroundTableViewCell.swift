//
//  ChnageBackgroundTableViewCell.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/11.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

var chooseToMakeBackground: (() -> Void)!
var backDefaultBackground: (() -> Void)!

class ChangeBackgroundTableViewCell: UITableViewCell {

    var changeBGBtn: UIButton!
    var backDefaultBtn: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        changeBGBtn = My_Button(frame: CGRectMake(0, 0, SCREEN_WIDTH / 2, SETTING_CELL_HEIGHT), title: "选择图片以做背景", bgColor: DARK_GRAY, titleColor: WHITE_COLOR, touchUpInsideBlock: {
            self.choosePicMakeBg()
        })
        changeBGBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.addSubview(changeBGBtn)
        
        backDefaultBtn = My_Button(frame: CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SETTING_CELL_HEIGHT), title: "恢复默认背景", bgColor: DARK_GRAY, titleColor: WHITE_COLOR, touchUpInsideBlock: { 
            self.backDefault()
        })
        backDefaultBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.addSubview(backDefaultBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 选择图片
    func choosePicMakeBg() -> Void {
        chooseToMakeBackground()
    }
    
    // 恢复默认
    func backDefault() -> Void {
        backDefaultBackground()
    }
    
    // 初始化并复用这个cell
    static func getChangeBackgroundTableViewCell(tableview: UITableView) -> ChangeBackgroundTableViewCell {
        let cellID: String = "ChangeBackgroundTableViewCell"
        
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID) as? ChangeBackgroundTableViewCell
        
        if cell == nil {
            cell = ChangeBackgroundTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }
}
