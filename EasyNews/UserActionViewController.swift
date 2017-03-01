//
//  UserActionViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/25.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class UserActionViewController: UIViewController {

    static let WINDOW_HEIGT = 100 * WScale
    
    /// 登录
    fileprivate var loginVC: LoginViewController!
    /// 注册
    fileprivate var registerVC: RegisterViewController!
    /// 基本的view
    fileprivate var loginAndRegisterBaseView: LoginAndRegisterBaseView!
    /// 盛放注册的登录按钮
    fileprivate var mWindow: UIWindow!
}

// MARK: - 生命周期
extension UserActionViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = MY_BACK_GRAY
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        makeNotification()
        
        mWindow = UIWindow(frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: UserActionViewController.WINDOW_HEIGT))
        
        self.loginAndRegisterBaseView = LoginAndRegisterBaseView(frame: CGRect(x: 0, y: 0, width: mWindow.frame.width, height: mWindow.frame.height))
        self.loginAndRegisterBaseView.delegate = self
        mWindow.windowLevel = UIWindowLevelAlert - 1
        mWindow.addSubview(self.loginAndRegisterBaseView)
        
        loginVC = LoginViewController()
        self.addChildViewController(loginVC)
        registerVC = RegisterViewController()
        self.addChildViewController(registerVC)
        
        self.view.addSubview(loginVC.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mWindow.makeKeyAndVisible()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 移除
        mWindow.isHidden = true
        mWindow.removeFromSuperview()
        mWindow = nil
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: LocalConstant.LoginButtonClickNotification), object: nil)
    }
}

// MARK: - LoginAndRegisterBaseViewButtonProtocol
extension UserActionViewController: LoginAndRegisterBaseViewButtonProtocol {
    
    /// 按了登录按钮
    func chooseLoginButtonAction() -> Void {
        self.transition(from: self.registerVC, to: self.loginVC, duration: 0.5, options: .transitionFlipFromRight,
                        animations: {
                            self.loginVC.didMove(toParentViewController: self)
                            
        }, completion: nil)
    }
    
    /// 按了注册按钮
    func chooseRegisterButtonAction() -> Void {
        self.transition(from: self.loginVC, to: self.registerVC, duration: 0.5, options: .transitionFlipFromLeft,
                        animations: {
            self.registerVC.didMove(toParentViewController: self)
        }, completion: nil)
    }
}

// MARK: - 处理通知
extension UserActionViewController {
    
    fileprivate func makeNotification() -> Void {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: LocalConstant.LoginButtonClickNotification), object: nil, queue: nil) { (notification) in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
