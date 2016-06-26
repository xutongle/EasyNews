//
//  OtherSettingCellTableViewCell.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/25.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class OtherSettingCellTableViewCell: UITableViewCell {
    @IBOutlet weak var useBlur: UIButton!
    @IBOutlet weak var changeBg: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        useBlur.setTitle("背景是否透明", forState: .Normal)
        changeBg.setTitle("选择背景图片以改变背景", forState: .Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
