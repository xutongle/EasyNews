//
//  FrostedTableViewCell.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/10.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

// 磨砂程度
class FrostedTableViewCell: UITableViewCell {

    // 显示透明度的label
    var showFrostedLabel: UILabel!
    // 调节磨砂程度的进度条
    var frostedAdjustSeekbar: UISlider!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        showFrostedLabel = UILabel(frame: CGRectMake(0, 0, SCREEN_WIDTH / 4, SETTING_CELL_HEIGHT))
        showFrostedLabel.text = "透明度"
        showFrostedLabel.backgroundColor = SETTING_BACKGROUND_COLOR
        showFrostedLabel.textColor = WHITE_COLOR
        showFrostedLabel.textAlignment = .Center
        showFrostedLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(showFrostedLabel)
        
        frostedAdjustSeekbar = UISlider(frame: CGRectMake(SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 4 * 3, SETTING_CELL_HEIGHT))
        frostedAdjustSeekbar.backgroundColor = SETTING_BACKGROUND_COLOR
        frostedAdjustSeekbar.maximumTrackTintColor = UIColor.blackColor()
        frostedAdjustSeekbar.minimumTrackTintColor = UIColor.orangeColor()
        frostedAdjustSeekbar.thumbTintColor = UIColor.cyanColor()
        frostedAdjustSeekbar.addTarget(self, action: #selector(changeValueAction), forControlEvents: .ValueChanged)
        self.addSubview(frostedAdjustSeekbar)
        
        frostedAdjustSeekbar.value = Tools.getUserDefaults("BlurValue") as! Float
        SingleManager.singleManager.add(Key: "BlurValue", andValue: frostedAdjustSeekbar.value)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeValueAction(slider: UISlider) -> Void {
        showFrostedLabel.text = String(format: "%.2f", slider.value)
        
        // 先存在用户变量中，当用户在设定页面点击dissmiss时存入用户变量中
        SingleManager.singleManager.add(Key: "BlurValue", andValue: slider.value)
        BackgroundImageView.backgroundImageView.blurValue = slider.value
    }
    
    // 初始化并复用这个cell
    static func getFrostedTableViewCell(tableview: UITableView) -> FrostedTableViewCell {
        let cellID: String = "FrostedTableViewCell"
        
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID) as? FrostedTableViewCell
        
        if cell == nil {
            cell = FrostedTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }
}
