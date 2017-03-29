//
//  ToLineAnimation.swift
//  EasyNews
//
//  Created by mac_zly on 2017/2/9.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class ToLineAnimation: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {

    private var frame: CGRect!
    private var transitionContext: UIViewControllerContextTransitioning?
    
    init(mFrame: CGRect) {
        super.init()
        self.frame = mFrame
    }
    
    // 转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        self.transitionContext = transitionContext
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        let containerView = transitionContext.containerView
        
        var fromView: UIView! = fromViewController?.view
        var toView: UIView! = toViewController?.view
        
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            fromView = transitionContext.view(forKey: .from)
            toView = transitionContext.view(forKey: .to)
        }
        
        let transationView = UIView(frame: fromView.frame)
        transationView.backgroundColor = UIColor.black
        transationView.alpha = 1
        
        
        containerView.insertSubview(transationView, belowSubview: fromView)
        containerView.insertSubview(toView, belowSubview: transationView)
        
        fromView.backgroundColor = .clear
        
        // 我们需要让动画时长和整个过渡的时长相同，以便UIKit进行同步。
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        let caBasicAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        caBasicAnimation.fromValue = 1.0
        caBasicAnimation.toValue = 0.01
        caBasicAnimation.isRemovedOnCompletion = true
        caBasicAnimation.delegate = self
        caBasicAnimation.duration = transitionDuration
        caBasicAnimation.fillMode = kCAFillModeForwards
        
        fromView.layer.add(caBasicAnimation, forKey: nil)
        
        //
        UIView.animate(withDuration: transitionDuration, animations: {
            /**
             a 表示水方向的缩放
             tx 表示水平方向的偏移
             d 表示垂直方向的缩放，
             ty 表示垂直方向的偏移
             如果 b c 不为 0 的话，那么坑定发生了旋转。
             **/
             // fromView.transform = CGAffineTransform(a: 0.01, b: 0, c: 0, d: 0.01, tx: 0.5, ty: 0)
            
            transationView.alpha = 0.5
            
        }) { (complete) in
            if !transitionContext.transitionWasCancelled {
                transationView.removeFromSuperview()
//                transationView = nil
            }
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        transitionContext!.completeTransition(!transitionContext!.transitionWasCancelled)
    }
}
