//
//  TransationGestrue.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/14.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class TransationGestrue: UIPercentDrivenInteractiveTransition {

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
//        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer:)))
//        gesture.edges = .left
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer:)))
        gesture.maximumNumberOfTouches = 1
        view.addGestureRecognizer(gesture)
    }
    
    // 手势该如何处理
    @objc private func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        guard let gestrueView = gestureRecognizer.view else {
            return
        }
        
        // 1
        let translation = gestureRecognizer.translation(in: gestrueView.superview)
        var progress = Float(translation.y / (gestrueView.frame.size.height / 4))
        progress = fminf(fmaxf(progress, 0.0), 1.0)
        
        print(progress)
        
        switch gestureRecognizer.state {
            
        case .began:
            // 2
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            // 3 当翻转超过一半就执行翻转finsh 否则就返回去cancel
            shouldCompleteTransition = progress > 0.5
            update(CGFloat(progress))
            
        case .cancelled:
            // 4
            interactionInProgress = false
            cancel()
            
        case .ended:
            // 5
            interactionInProgress = false
            
            if !shouldCompleteTransition { cancel() } else { finish() }
            
        default:
            print("Unsupported")
        }
    }
    
}
