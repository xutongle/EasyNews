//
//  TopBottomSwapGestrue.swift
//  EasyNews
//
//  Created by mac_zly on 2017/2/9.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

// 上下滑动
class TopBottomSwapGestrue: UIPercentDrivenInteractiveTransition {
    
    // 是不是在处理手势
    var interactionInProgress = false
    
    // 旋转程度不够 就不dismiss
    private var shouldCompleteTransition = false
    
    // 就是要加手势的vc
    private weak var viewController: UIViewController!
    
    // 对要要加手势的vc设置手势
    func wire(to viewController: UIViewController!) {
        self.viewController = viewController
        
        prepareGestureRecognizer(in: viewController.view)
    }
    
    // 设置手势
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer:)))
        gesture.maximumNumberOfTouches = 1
        view.addGestureRecognizer(gesture)
        
        let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(handleTapGestrue))
        view.addGestureRecognizer(tapGestrue)
    }
    
    @objc private func handleTapGestrue() {
        update(1)
        interactionInProgress = true
        viewController.dismiss(animated: true, completion: nil)
        finish()
    }
    
    // 手势该如何处理
    @objc private func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        guard let gestrueView = gestureRecognizer.view else {
            return
        }
        
        // 1
        let translation = gestureRecognizer.translation(in: gestrueView.superview)
        var progress = Float(translation.y / (gestrueView.frame.size.height / 2))
        
        //  大小 -1 到 1 之间但是取绝对值
        progress = fabs(fminf(fmaxf(progress, -1.0), 1.0))
        
        switch gestureRecognizer.state {
        case .began:
            // 2
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
            break
        case .changed:
            // 3 当翻转超过一半就执行翻转finsh 否则就返回去cancel
            shouldCompleteTransition = progress > 0.5
            update(CGFloat(progress))
            break
        case .cancelled:
            // 4
            interactionInProgress = false
            cancel()
            break
        case .ended:
            // 5
            interactionInProgress = false
            if !shouldCompleteTransition { cancel() } else { finish() }
            break
        default:
            print("UnSupport")
            break
        }
        
    }
}
