//
//  DissmissGestrueAnimation.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/14.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class DissmissGestrueAnimation: NSObject, UIViewControllerAnimatedTransitioning {

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
        
        // 这里出现了一个新家伙：容器视图（Container View），我们可以把它想象成过渡动画的舞台。
        // 容器视图自动包含了“from”视图，我们需要自行添加“to”视图。
        containerView.insertSubview(toView, belowSubview: fromView)
        
        // 我们需要让动画时长和整个过渡的时长相同，以便UIKit进行同步。
        let transitionDuration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDuration, animations: {
            
            fromView.frame = CGRect(x: fromView.frame.origin.x, y: fromView.frame.size.height, width: fromView.frame.size.width, height: fromView.frame.size.height)
            toView.frame = transitionContext.finalFrame(for: toViewController!)
        }) { (o) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
