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
    private var label: UILabel = UILabel()
    
    private static let screen_width = UIScreen.main.bounds.width
    private static let screen_height = UIScreen.main.bounds.height
    //
    static let toast = Toast(frame: CGRect(x: screen_width / 4, y: screen_height - 49 - 40, width: screen_width / 2, height: 40))

    // Toast 的一些默认设置
    override fileprivate init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.layer.cornerRadius = 10
    }
    
    func show(message: String, duration: ToastDuration, removed: (() -> Void)?) -> Void {
        
        let messageStr = message as NSString
        
        label.text = message
        // 行数自适应
        label.numberOfLines = 0
        // 截断新内容
        label.lineBreakMode = .byCharWrapping
        label.textColor = UIColor.white
        label.textAlignment = .left
        
        var _size = messageStr.boundingRect(
            with: CGSize(width: SCREEN_WIDTH / 3 * 2, height: SCREEN_HEIGHT),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName : label.font],
            context: nil).size
        
        // 最小宽度
        if _size.width <= SCREEN_WIDTH / 3 {
            _size.width = SCREEN_WIDTH / 3
            label.textAlignment = .center
        }
        // 最小高度
        if _size.height < 30 {
            _size.height = 30
            label.textAlignment = .center
        }
        
        let calc_width = _size.width
        let calc_height = _size.height
        
        self.frame = CGRect(
            x: (Toast.screen_width - calc_width) / 2 ,
            y: Toast.screen_height - calc_height - 40,
            width: calc_width,
            height: calc_height
        )
        
        // 初始化label
        label.frame = CGRect(x: 5, y: 5, width: calc_width - 10, height: calc_height - 10)
        
        self.addSubview(label)
        
        self.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            UIApplication.shared.keyWindow?.addSubview(self)
            self.alpha = 1
        })
        
        // 延时
        var delay: Int = 1
        switch duration {
        case .long:
            delay = 3
            break
        case .nomal:
            delay = 2
            break
        case .short:
            delay = 1
            break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.removeFromSuperview()
            removed?()
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
