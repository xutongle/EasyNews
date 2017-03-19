//
//  GirlTransationDelegate.swift
//  EasyNews
//
//  Created by mac_zly on 2017/2/9.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class GirlTransationDelegate: NSObject, UIViewControllerTransitioningDelegate {

    private var topBottomSwapGestrue: TopBottomSwapGestrue!
    private var frame: CGRect!
    
    init(topBottomSwapGestrue: TopBottomSwapGestrue, mFrame: CGRect) {
        super.init()
        self.topBottomSwapGestrue = topBottomSwapGestrue
        self.frame = mFrame
    }
    
    // 跳转的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ScaleShowAnimation(mFrame: self.frame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ToLineAnimation(mFrame: self.frame)
    }
    
    // 交互式控制器
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        
        return topBottomSwapGestrue.interactionInProgress ? topBottomSwapGestrue : nil
    }
}
