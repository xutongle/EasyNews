//
//  Totast.swift
//  Totast-Swift
//
//  Created by zly.private on 16/6/4.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

// MARK: - ---------------------枚举---------------------

// 样式
public enum Style {
    case defaultStyle
    case alphaStyle
}

// 位置
public enum ToastPostion {
    case inTop
    case inCente
    case inBottom
}

//时长
public enum ToastDuration {
    case long
    case nomal
    case short
}

class Toast: UIView {
    
    // Toast上的文字
    private var label:UILabel = UILabel()
    //
    static let toast = Toast(frame: CGRect(x: SCREEN_WIDTH / 4, y: SCREEN_HEIGHT - 80, width: SCREEN_WIDTH / 2, height: 40))

    // Toast 的一些默认设置
    override fileprivate init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        
        self.layer.cornerRadius = 10
    }
    
    func show(message: String, duration: ToastDuration, block: (() -> Void)?) -> Void {
        
        label.text = message
        // 行数自适应
        label.numberOfLines = 0
        // 截断新内容
        label.lineBreakMode = .byCharWrapping
        
        label.textColor = UIColor.white
        
        let messageStr = message as NSString
        let rect = messageStr.boundingRect(with: CGSize(width: SCREEN_WIDTH / 3 * 2, height: SCREEN_HEIGHT), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:label.font], context: nil)
        
        var useSize: CGSize = rect.size
        
        label.textAlignment = .left
        if rect.width <= SCREEN_WIDTH / 2 {
            useSize.width = SCREEN_WIDTH / 2
            label.textAlignment = .center
        }
        if rect.height < 30 {
            useSize.height = 30
            label.textAlignment = .center
        }
        
        let screen_width = UIScreen.main.bounds.width
        let screen_height = UIScreen.main.bounds.height
        
        let calc_width = useSize.width
        let calc_height = useSize.height
        
        self.frame = CGRect(x: (screen_width - (calc_width + 10)) / 2 , y: (screen_height - (calc_height + 10)) - 50, width: calc_width + 10, height: calc_height + 10)
        
        // 初始化label
        label.frame = CGRect(x: 5, y: 5, width: calc_width, height: calc_height)
        
        self.addSubview(label)
        
        self.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            UIApplication.shared.keyWindow?.addSubview(self)
            self.alpha = 1
        })
        
        // 延迟一秒
        var delay: DispatchTime!
        switch duration {
        case .long:
            delay = DispatchTime.now() + DispatchTimeInterval.seconds(3)
            break
        case .nomal:
            delay = DispatchTime.now() + DispatchTimeInterval.seconds(2)
            break
        case .short:
            delay = DispatchTime.now() + DispatchTimeInterval.seconds(1)
            break
        }
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.removeFromSuperview()
            if block != nil { block!() }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ---------------------ToastStyle Toast的样式---------------------

//一些默认的样式值
class ToastStyle{
    
    // Toast的背景
    var toastBackground = UIColor.black
    
    // Toast的圆角
    var toastCornerRadius = 10.0
    
    // Toast透明度
    var toastAlpha = 0.8
    
}
