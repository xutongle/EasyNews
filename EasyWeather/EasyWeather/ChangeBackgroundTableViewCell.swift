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
        
        changeBGBtn = UIButton(frame: CGRectMake(0, 0, SCREEN_WIDTH / 2, SETTING_CELL_HEIGHT))
        changeBGBtn.backgroundColor = DARK_GRAY
        changeBGBtn.setTitle("选择图片以做背景", forState: .Normal)
        changeBGBtn.setTitleColor(WHITE_COLOR, forState: .Normal)
        changeBGBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        changeBGBtn.addTarget(self, action: #selector(choosePicMakeBg), forControlEvents: .TouchUpInside)
        self.addSubview(changeBGBtn)
        
        backDefaultBtn = UIButton(frame: CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SETTING_CELL_HEIGHT))
        backDefaultBtn.backgroundColor = DARK_GRAY
        backDefaultBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        backDefaultBtn.setTitle("恢复默认背景", forState: .Normal)
        backDefaultBtn.setTitleColor(WHITE_COLOR, forState: .Normal)
        backDefaultBtn.addTarget(self, action: #selector(backDefault), forControlEvents: .TouchUpInside)
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
