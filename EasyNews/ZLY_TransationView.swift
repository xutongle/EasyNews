//
//  ZLY_TransationView.swift
//  CareBaby
//
//  Created by mac_zly on 2016/12/8.
//  Copyright © 2016年 safethink. All rights reserved.
//

import UIKit

fileprivate var transationView: ZLY_TransationView?

extension UIViewController {
    func showTransationView(style: UIBlurEffectStyle) -> Void {
        if transationView == nil {
            transationView = ZLY_TransationView(frame: SCREEN_BOUNDS, style: style)
            UIApplication.shared.keyWindow?.addSubview(transationView!)
        }
    }
    
    func removeTransationView() -> Void {
        if transationView != nil {
            transationView?.removeFromSuperview()
            transationView = nil
        }
    }
    
}

class ZLY_TransationView: UIView {
    
    let bWidth: CGFloat = 30
    let sWidth: CGFloat = 30
    
    var bigLayer: CALayer!
    var smallLayer: CALayer!
    
    init(frame: CGRect, style: UIBlurEffectStyle) {
        super.init(frame: frame)
        self.isOpaque = true
        
        let blurEffect = UIBlurEffect(style: style)
        let visView = UIVisualEffectView(effect: blurEffect)
        visView.frame = frame
        visView.alpha = 0.9
        self.addSubview(visView)
        
        bigLayer = CALayer()    // 背部的更大一点的圆
        smallLayer = CALayer()  // 背部跟小一点的圆
        
        // 大图层
        bigLayer.frame = CGRect(x: frame.size.width / 2 - bWidth / 2, y: frame.height / 2 - bWidth / 2, width: bWidth, height: bWidth)
        bigLayer.cornerRadius = bWidth / 2
        self.layer.addSublayer(bigLayer)
        
        // 小层图
        smallLayer.frame = CGRect(x: frame.size.width / 2 - sWidth / 2, y: frame.height / 2 - sWidth / 2, width: sWidth, height: sWidth)
        smallLayer.cornerRadius = sWidth / 2
        self.layer.addSublayer(smallLayer)
        
        // 颜色
        bigLayer.backgroundColor = #colorLiteral(red: 0.8092681766, green: 0, blue: 0.180472225, alpha: 1).cgColor
        smallLayer.backgroundColor = #colorLiteral(red: 0.5949943662, green: 0.8073067069, blue: 0, alpha: 1).cgColor
        
        // 时间
        let beginTime = CACurrentMediaTime()
        
        // 创建动画
        let animation1 = makeAnimation(isBig: true, beginTime: beginTime)
        let animation2 = makeAnimation(isBig: false, beginTime: beginTime)
        
        // 动画
        bigLayer.add(animation1, forKey: "animation")
        smallLayer.add(animation2, forKey: "animation")
    }
    
    // 创建CAKeyframeAnimation
    private func makeAnimation(isBig: Bool, beginTime: CFTimeInterval) -> CAKeyframeAnimation {
        
        let transformAnimation = CAKeyframeAnimation(keyPath: "transform")
        transformAnimation.isRemovedOnCompletion = false
        transformAnimation.repeatCount = Float(Int.max)
        transformAnimation.duration = 2.0
        transformAnimation.keyTimes = [0.0, 0.5, 1.0]
        
        if isBig {
            transformAnimation.beginTime = CFTimeInterval(CGFloat(beginTime) - CGFloat(1 * 0))
            transformAnimation.values = [
                CATransform3DMakeScale(0.5,0.5, 0.0),
                CATransform3DMakeScale(1.0,1.0, 0.0),
                CATransform3DMakeScale(0.5,0.5, 0.0)
            ]
        }else {
            transformAnimation.beginTime = CFTimeInterval(CGFloat(beginTime) - CGFloat(1 * 1))
            transformAnimation.values = [
                CATransform3DMakeScale(0.0,0.0, 0.0),
                CATransform3DMakeScale(1.0,1.0, 0.0),
                CATransform3DMakeScale(0.0,0.0, 0.0)
            ]
        }
        return transformAnimation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
