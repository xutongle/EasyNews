//
//  ToLineAnimation.swift
//  EasyNews
//
//  Created by mac_zly on 2017/2/9.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class ToLineAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    private var frame: CGRect!
    
    init(mFrame: CGRect) {
        super.init()
        self.frame = mFrame
    }
    
    // 转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
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
//        toView.clipsToBounds = true
        toView.frame = toFrame
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        // 我们需要让动画时长和整个过渡的时长相同，以便UIKit进行同步。
        let transitionDuration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDuration, animations: {
            /**
             a 表示水方向的缩放
             tx 表示水平方向的偏移
             d 表示垂直方向的缩放，
             ty 表示垂直方向的偏移
             如果 b c 不为 0 的话，那么坑定发生了旋转。
             **/
//             fromView.transform = CGAffineTransform(a: 0.01, b: 0, c: 0, d: 0.01, tx: 0.5, ty: 0)
            
            // 变成一条线消失
            fromView.frame = self.frame
            
            //toView.frame = transitionContext.finalFrame(for: toViewController!)
        }) { (complete) in
            if (transitionContext.transitionWasCancelled) {
                fromView.frame = fromFrame
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
