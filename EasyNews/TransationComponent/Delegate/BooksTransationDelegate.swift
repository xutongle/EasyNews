//
//  NewsTransationDelegate.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/17.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class BooksTransationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private var transationGestrue: TransationGestrue!
    
    init(transationGestrue: TransationGestrue) {
        super.init()
        self.transationGestrue = transationGestrue
    }
   
    
    // 跳转的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SpringShowAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return DissmissGestrueAnimation()
    }
    
    // 交互式控制器
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        
        return transationGestrue.interactionInProgress ? transationGestrue : nil
    }
}
