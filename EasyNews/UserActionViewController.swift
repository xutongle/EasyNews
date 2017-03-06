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
        
        // 处理通知
        makeNotification()
        
        /// ========================================= ⬇️⬇️⬇️⬇️
        mWindow = UIWindow(frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: UserActionViewController.WINDOW_HEIGT))
        
        self.loginAndRegisterBaseView = LoginAndRegisterBaseView(frame: CGRect(x: -mWindow.frame.width, y: 0, width: mWindow.frame.width, height: mWindow.frame.height))
        self.loginAndRegisterBaseView.delegate = self
        
        mWindow.addSubview(self.loginAndRegisterBaseView)
        mWindow.windowLevel = UIWindowLevelAlert - 1
        mWindow.makeKeyAndVisible()

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.loginAndRegisterBaseView.frame = CGRect(x: 0, y: 0, width: self.mWindow.frame.width, height: self.mWindow.frame.height)
        }, completion: nil)
        /// ========================================= ⬆️⬆️⬆️⬆️
        
        loginVC = LoginViewController()
        self.addChildViewController(loginVC)
        registerVC = RegisterViewController()
        self.addChildViewController(registerVC)
        
        self.view.addSubview(loginVC.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    /// 按了选择登录界面按钮
    func chooseLoginButtonAction() -> Void {
        self.transition(from: self.registerVC, to: self.loginVC, duration: 0.25, options: .transitionFlipFromRight,
                        animations: {
                            self.loginVC.didMove(toParentViewController: self)
                            
        }, completion: nil)
    }
    
    /// 按了选择注册界面按钮
    func chooseRegisterButtonAction() -> Void {
        self.transition(from: self.loginVC, to: self.registerVC, duration: 0.25, options: .transitionFlipFromLeft,
                        animations: {
                            self.registerVC.didMove(toParentViewController: self)
        }, completion: nil)
    }
}

// MARK: - 处理通知
extension UserActionViewController {
    
    fileprivate func makeNotification() -> Void {
        // 登录通知
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: LocalConstant.LoginButtonClickNotification), object: nil, queue: nil) { (notification) in
            
            Tools.setUserDefaults(key: LocalConstant.UserIsLogin, andValue: true)
            self.dismiss(animated: true, completion: nil)
        }
        
        // 注册通知
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: LocalConstant.RegisterButtonClickNotification), object: nil, queue: nil) { (notification) in
            
            Tools.setUserDefaults(key: LocalConstant.UserIsLogin, andValue: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
