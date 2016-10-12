//
//  ZLY_SlidingViewController.swift
//  ZLY_Sliding
//
//  Created by mac_zly on 2016/9/23.
//  Copyright © 2016年 safethink. All rights reserved.
//

import UIKit

// 自己本身是UIViewController 也是控制视图
class ZLY_SlidingViewController: UIViewController {
    
    // 主视图
    fileprivate var mainViewController: UIViewController!
    // 左视图
    fileprivate var leftViewController: UIViewController!
    
    // 何时显示中间视图
    fileprivate var slidingWidth: CGFloat = 0
    
    fileprivate var isOpened = false
    fileprivate var openSlidingGestrue: UIPanGestureRecognizer!
    static fileprivate var _zly_slidingView: ZLY_SlidingViewController!
    
    // alpha view
    fileprivate var alphaView: UIView!
    
    // 滑动速率
    var speed: CGFloat = 0.8
    // 侧滑宽度
    var leftWidth = UIScreen.main.bounds.width / 7 * 4
    
    deinit {
        
    }
    
    public convenience init(mainVC: UIViewController, leftVC: UIViewController) {
        self.init()
        
        // 给左右视图赋值
        self.mainViewController = mainVC
        self.leftViewController = leftVC
        
        // 先添加左视图并隐藏 再添加主视图
        self.view.insertSubview(self.leftViewController.view, at: 1)
        self.leftViewController.view.isHidden = true
        self.view.insertSubview(self.mainViewController.view, at: 2)
        alphaView = UIView(frame: self.mainViewController.view.frame)
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0
        self.mainViewController.view.addSubview(alphaView)
        
        // 手势
        openSlidingGestrue = UIPanGestureRecognizer(target: self, action: #selector(openSliding(gestrue:)))
        openSlidingGestrue.maximumNumberOfTouches = 1
        self.mainViewController.view.addGestureRecognizer(openSlidingGestrue)
        
        ZLY_SlidingViewController._zly_slidingView = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.leftViewController = LeftTableViewController()
        //self.view.addSubview(self.leftViewController.view)
        // 先隐藏
        //self.leftViewController.view.isHidden = true
        
        //let rootController = MainViewController()
        // 带导航栏的mainview
        //self.mainViewController = UINavigationController(rootViewController: rootController)
        //self.view.addSubview(self.mainViewController.view)
        
        // 添加滑动手势
        //let panGestrue = UIPanGestureRecognizer(target: self, action: #selector(openSliding))
        //panGestrue.maximumNumberOfTouches = 1
        //self.mainViewController.view.addGestureRecognizer(panGestrue)
    }
    
    // 滑动手势事件
    @objc
    fileprivate func openSliding(gestrue: UIPanGestureRecognizer) -> Void {
        
        // 获取手指的位置
        let point = gestrue.translation(in: gestrue.view)
        
        // 右滑
        if ( gestrue.view!.frame.origin.x >= 0 ) {

            // point.x小于0说明往左推(默认的是(0, 0))，isOpened说明侧滑是否打开 (打开了往左推那可以走正常逻辑，如果侧滑没打开往左滑 那就重置手势位置就行了)
            // 防止左滑过头
            if point.x < 0 && gestrue.view!.frame.origin.x == 0  {
                gestrue.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                return
            }
            
            // 防止右划过头
            if gestrue.view!.frame.origin.x >= leftWidth && point.x > 0 {
                gestrue.view!.frame.origin.x = leftWidth
                gestrue.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                
                return
            }
            
            self.mainViewController.view.bringSubview(toFront: self.alphaView)
            
            let alpha = (gestrue.view!.frame.origin.x / leftWidth - 0.3)
            self.alphaView.alpha = alpha < 0 ? 0 : alpha
            
            // 手指移动的最真实的坐标(有一个speed 所以要重新算)
            self.slidingWidth += point.x * self.speed
            
            // 手指触摸到的view往右移 用的是center 比较方便
            gestrue.view!.center = CGPoint(x: gestrue.view!.center.x + point.x * self.speed, y: gestrue.view!.center.y)
            // 重置手势
            gestrue.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            self.leftViewController.view.isHidden = false
            
        }else { //左划 (目前无用 不做右侧滑动)
            gestrue.view!.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
            //因为拖动起来一直是在递增，所以每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
            gestrue.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            
            self.leftViewController.view.isHidden = true
        }
        
        // 手指离开屏幕
        if gestrue.state == .ended {
            if self.slidingWidth >= UIScreen.main.bounds.width / 4 {
                self.showLeftView()
                isOpened = true
            }else {
                self.showMainView()
                isOpened = false
            }
        }
    }
    
    // 显示主视图
    fileprivate func showMainView() -> Void {
        UIView.beginAnimations(nil, context: nil)
        
        alphaView.alpha = 0
        self.mainViewController.view.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        
        UIView.commitAnimations()
    }
    
    // 显示左边视图
    fileprivate func showLeftView() -> Void {
        UIView.beginAnimations(nil, context: nil)
        
        alphaView.alpha = 0.7
        self.mainViewController.view.center = CGPoint(x: UIScreen.main.bounds.size.width / 2 + self.leftWidth, y: UIScreen.main.bounds.size.height / 2)
        
        UIView.commitAnimations()
    }
}

extension UIViewController {
    func zly_slidingView() -> ZLY_SlidingViewController? {
        return ZLY_SlidingViewController._zly_slidingView
    }
    
    func showLeftVC() -> Void {
        ZLY_SlidingViewController._zly_slidingView.showLeftView()
    }
}
