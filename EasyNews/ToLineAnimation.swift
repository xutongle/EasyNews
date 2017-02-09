//
//  ToLineAnimation.swift
//  EasyNews
//
//  Created by mac_zly on 2017/2/9.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class ToLineAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    // 转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        let containerView = transitionContext.containerView
        
        var fromView: UIView! = fromViewController?.view
        var toView: UIView! = toViewController?.view
        
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            fromView = transitionContext.view(forKey: .from)
            toView = transitionContext.view(forKey: .to)
        }
        
        let fromFrame = transitionContext.finalFrame(for: fromViewController!)
        let toFrame = transitionContext.finalFrame(for: toViewController!)
        
        fromView.frame = fromFrame
        toView.frame = toFrame
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        // 我们需要让动画时长和整个过渡的时长相同，以便UIKit进行同步。
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, animations: {
            
            fromView.transform = CGAffineTransform(a: 0.1, b: 0.5, c: 0.5, d: 0.1, tx: 0, ty: 0)
            
            toView.frame = transitionContext.finalFrame(for: toViewController!)
        }) { (complete) in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
