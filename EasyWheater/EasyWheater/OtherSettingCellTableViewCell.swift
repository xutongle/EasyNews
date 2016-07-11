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
    case BACK_DEFAULT_BG
}

var bgBlurSettingBlock: () -> Void = {button in }
var chooseBgSettingBlock: () -> Void = {button in }
var backDeafultBgBlock: () -> Void = {button in }

class OtherSettingCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var useBlur: UIButton!
    @IBOutlet weak var changeBg: UIButton!
    @IBOutlet weak var blurProgressBar: UISlider!
    @IBOutlet weak var backDefaultBgBtn: UIButton!

    @IBOutlet weak var bgButtonWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        
        // 设置按钮文字
        useBlur.setTitle("背景透明度:", forState: .Normal)
        changeBg.setTitle("选择背景图片以改变背景", forState: .Normal)
        backDefaultBgBtn.setTitle("恢复默认背景", forState: .Normal)
        
        // 设置按钮事件
        useBlur.addTarget(self, action: #selector(btnAction), forControlEvents: .TouchUpInside)
        changeBg.addTarget(self, action: #selector(btnAction), forControlEvents: .TouchUpInside)
        backDefaultBgBtn.addTarget(self, action: #selector(btnAction), forControlEvents: .TouchUpInside)
        
        // 
        blurProgressBar.addTarget(self, action: #selector(changeBlur), forControlEvents: .ValueChanged)
        blurProgressBar.value = Tools.getUserDefaults("isBlur") != nil ? Tools.getUserDefaults("isBlur") as! Float : 0.5
        // 先保存一次
        SingleManager.singleManager.add(Key: "isBlur", andValue: blurProgressBar.value)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 按钮事件
    func btnAction(button: UIButton) -> Void {
        switch button {
        case useBlur:
            //这个block用来改变背景的透明度 通往BackgroundImageView
            bgBlurSettingBlock()
            break
        case changeBg:
            // 这个block用来改变背景的图片 通往SettingViewController
            chooseBgSettingBlock()
            break
        case backDefaultBgBtn:
            // 这个block用来恢复背景的图片 通往SettingViewController
            backDeafultBgBlock()
            break
        default:
            break
        }
    }
    
    // progressBar值改变的方法
    func changeBlur(sender: UISlider) -> Void {
        bgButtonWidth.constant = 80
        useBlur.setTitle(String.init(format: "%1.2f", sender.value), forState: .Normal)
        
        // 先存在用户变量中，当用户在设定页面点击dissmiss时存入用户变量中
        SingleManager.singleManager.add(Key: "isBlur", andValue: sender.value)
        BackgroundImageView.backgroundImageView.blurValue = sender.value
    }
}
