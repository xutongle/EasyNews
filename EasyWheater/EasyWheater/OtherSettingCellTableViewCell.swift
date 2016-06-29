//
//  OtherSettingCellTableViewCell.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/25.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

public enum otherSettingEnum {
    case BLUR
    case CHANGE_BG
}

var otherSettingBlock:(other: otherSettingEnum) -> Void = {button in }

class OtherSettingCellTableViewCell: UITableViewCell {
    @IBOutlet weak var useBlur: UIButton!
    @IBOutlet weak var changeBg: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        useBlur.setTitle("背景是否透明", forState: .Normal)
        changeBg.setTitle("选择背景图片以改变背景", forState: .Normal)
        
        useBlur.addTarget(self, action: #selector(btnAction), forControlEvents: .TouchUpInside)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func btnAction(button: UIButton) -> Void {
        switch button {
        case useBlur:
            otherSettingBlock(other: .BLUR)
            break
        case changeBg:
            otherSettingBlock(other: .CHANGE_BG)
            break
        default:
            break
        }
    }
    
}
