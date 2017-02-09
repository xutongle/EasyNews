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
    
    init(topBottomSwapGestrue: TopBottomSwapGestrue) {
        super.init()
        self.topBottomSwapGestrue = topBottomSwapGestrue
    }
    
    // 跳转的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SpringShowAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ToLineAnimation()
    }
    
    // 交互式控制器
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        
        return topBottomSwapGestrue.interactionInProgress ? topBottomSwapGestrue : nil
    }
}
