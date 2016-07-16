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
    case DefaultStyle
    case AlphaStyle
}

// 位置
public enum ToastPostion {
    case InTop
    case InCente
    case InBottom
}

// MARK: - ---------------------全局变量---------------------

// 屏幕宽高
//private let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
//private let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

// 初始化出Toast
private let toastView:UIView = Toast.init(frame: CGRectMake((SCREEN_WIDTH - (SCREEN_WIDTH / 2)) / 2, SCREEN_HEIGHT - 80, SCREEN_WIDTH / 2, 40))

// Toast上的文字
private var label:UILabel = UILabel()

// MARK: - ---------------------extension继承？---------------------

extension UIView{
    
    // MARK: - ---------------------在viewcontroller直接调用---------------------
    
    // 使用ToastPostion的位置
    func show(message: String, style: ToastStyle, postion: ToastPostion, block: ()->Void) -> Void {
        switch postion {
        case .InTop:
            toastView.frame = CGRectMake((SCREEN_WIDTH - (SCREEN_WIDTH / 2)) / 2, 84, SCREEN_WIDTH / 2, 40)
            break
        case .InCente:
            toastView.frame = CGRectMake((SCREEN_WIDTH - (SCREEN_WIDTH / 2)) / 2, SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2, 40)
            break
        default:
            // 默认为Bottom所以直接不做修改
            break
        }
        
        show(message, style: style, block: block)
    }
    
    // 自定义的输入totast的位置
    func show(message: String, style: ToastStyle, postion: CGRect, block: ()->Void) -> Void {
        
        toastView.frame = postion
        show(message, style: style, block: block)
    }
    
    // 输入自定义样式
    func show(message: String, style: ToastStyle, block: ()->Void) -> Void {
        
        toastView.alpha = CGFloat(style.toastAlpha)
        toastView.backgroundColor = style.toastBackground
        toastView.layer.cornerRadius = CGFloat(style.toastCornerRadius)
        
        show(message, block: block)
    }
    
    // 输入自定义的文字
    func show(message: String, block: () -> Void) -> Void {
        
        label.text = message
        UIView.animateWithDuration(0.25) { 
            self.addSubview(toastView)
        }
        
        // 延时几秒后消失
        self.delay(1.25) {
            toastView.removeFromSuperview()
            block()
        }
    }
    
    // MARK: - ---------------------线程延时---------------------
    
    //线程延时
    typealias Task = (cancel : Bool) -> Void
    
    private func delay(time:NSTimeInterval, task:()->()) ->  Task? {
        
        func dispatch_later(block:()->()) {
            //现场何时开始，延时几秒，在这做完
            let timeController = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            //在什么线程执行
            dispatch_after(timeController, dispatch_get_main_queue(),block)
        }
        
        var closure: dispatch_block_t? = task
        var result: Task?
        
        let delayedClosure: Task = {cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    dispatch_async(dispatch_get_main_queue(), internalClosure);
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(cancel: false)
            }
        }
        
        return result;
    }
    
    //取消线程
    private func cancel(task:Task?) {
        task?(cancel: true)
    }
}

// MARK: - ---------------------本体---------------------

private class Toast: UIView {
    
    // Toast 的一些默认设置
    override private init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
        
        // 初始化label
        label.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ---------------------ToastStyle Toast的样式---------------------

//一些默认的样式值
class ToastStyle{
    
    // Toast的背景
    var toastBackground = UIColor.blackColor()
    
    // Toast的圆角
    var toastCornerRadius = 10.0
    
    // Toast透明度
    var toastAlpha = 0.8
    
    
}
