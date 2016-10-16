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

// MARK: - ---------------------全局变量---------------------

// 初始化出Toast
private let toastView:UIView = Toast.init(frame: CGRect(x: SCREEN_WIDTH / 4, y: SCREEN_HEIGHT - 80, width: SCREEN_WIDTH / 2, height: 40))

// Toast上的文字
private var label:UILabel = UILabel()

// MARK: - --------------------- extension ---------------------

extension NSObject{
    
    // MARK: - ---------------------在viewcontroller直接调用---------------------
    
    // 使用ToastPostion的位置
    func show(_ message: String , toastPostion: ToastPostion, block: (()->Void)?) -> Void {
        switch toastPostion {
        case .inTop:
            toastView.frame = CGRect(x: SCREEN_WIDTH / 4, y: 84, width: SCREEN_WIDTH / 2, height: 40)
            break
        case .inCente:
            toastView.frame = CGRect(x: SCREEN_WIDTH / 4, y: SCREEN_HEIGHT / 2 - 20, width: SCREEN_WIDTH / 2, height: 40)
            break
        default:
            // 默认为Bottom所以直接不做修改
            break
        }
        
        if (block != nil) {  show(message, block: block)  }
    }
    
    // 自定义的输入totast的位置
    func show(_ message: String, postion: CGRect, block: (()->Void)?) -> Void {
        
        toastView.frame = postion
        if (block != nil) {  show(message, block: block)  }
    }
    
    // 输入自定义样式
    func show(_ message: String, style: ToastStyle, block: @escaping ()->Void) -> Void {
        
        toastView.alpha = CGFloat(style.toastAlpha)
        toastView.backgroundColor = style.toastBackground
        toastView.layer.cornerRadius = CGFloat(style.toastCornerRadius)
        
        show(message, block: block)
    }
    
    // 输入自定义的文字
    func show(_ message: String, block: (() -> Void)?) -> Void {
        
        label.text = message
        // 行数自适应
        label.numberOfLines = 0
        // 截断新内容
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .left
        label.textColor = UIColor.white
        
        let messageStr = message as NSString
        let rect = messageStr.boundingRect(with: CGSize(width: SCREEN_WIDTH / 2, height: SCREEN_HEIGHT), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:label.font], context: nil)
        
        var useSize: CGSize = rect.size
        //print("自适应的大小－>", useSize)
        if rect.width < SCREEN_WIDTH / 2 {
            useSize.width = SCREEN_WIDTH / 2
            label.textAlignment = .center
        }
        if rect.height < 30 {
            useSize.height = 30
            label.textAlignment = .center
        }

        toastView.frame = CGRect(x: toastView.frame.origin.x, y: toastView.frame.origin.y, width: useSize.width + 10, height: useSize.height + 10)
        // 初始化label
        label.frame = CGRect(x: 5, y: 5, width: useSize.width, height: useSize.height)
        
        toastView.addSubview(label)
        toastView.layer.cornerRadius = 10
        
        toastView.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            UIApplication.shared.keyWindow?.addSubview(toastView)
            toastView.alpha = 1
        }) 
        
        // 延时几秒后消失
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            toastView.removeFromSuperview()
            if block != nil { block!() }
        }
    }
}

// MARK: - ---------------------本体---------------------

private class Toast: UIView {
    
    // Toast 的一些默认设置
    override fileprivate init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
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
