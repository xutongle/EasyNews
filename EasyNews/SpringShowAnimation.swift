//
//  SpringShowAnimation.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/14.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class SpringShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 实验证明 这个就是自身
        let fromViewController = transitionContext.viewController(forKey: .from)
        // 实验证明 这个就是SecondViewController
        let toViewController = transitionContext.viewController(forKey: .to)
        
        var fromView: UIView! = fromViewController?.view
        var toView: UIView! = toViewController?.view
        // iOS8引入了viewForKey方法，尽可能使用这个方法而不是直接访问controller的view属性
        // 比如在form sheet样式中，我们为presentedViewController的view添加阴影或其他decoration，animator会对整个decoration view
        // 添加动画效果，而此时presentedViewController的view只是decoration view的一个子视图
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            fromView = transitionContext.view(forKey: .from)
            toView = transitionContext.view(forKey: .to)
        }
        
        let containerView = transitionContext.containerView
        
        // 我们让toview的origin.y在屏幕的一半处，这样它从屏幕的中间位置弹起而不是从屏幕底部弹起
        toView.frame = CGRect(x: -fromView.frame.width, y: fromView.frame.origin.y, width: fromView.frame.width, height: fromView.frame.height)
        
        // 在present和dismiss时，必须将toview添加到视图层次中
        containerView.addSubview(toView)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        // 使用spring动画，有弹簧效果，动画结束后一定要调用completeTransition方法
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
            
            toView.frame = transitionContext.finalFrame(for: toViewController!)    // 移动到指定位置
        }) { (finished) in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    //    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
    //
    //    }
}
