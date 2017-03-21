//
//  LoginViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/1.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

// 登录控制器
class LoginViewController: UIViewController {

    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView(frame: self.view.frame)
        self.view.addSubview(loginView)
        
        /// 登录按钮的事件
        loginView.loginBlock = {
            // 登陆逻辑
            // 然后发送通知dissMiss掉 现在不做登陆逻辑
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalConstant.LoginButtonClickNotification), object: nil)
        }
        
        // 处理键盘
        makeKeyboradAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 移除通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

}

// MARK: - 处理键盘弹出后 view的操作
extension LoginViewController {
    
    fileprivate func makeKeyboradAction() -> Void {
        /// 键盘将要出现
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (notification) in
            guard let dict = notification.userInfo else {
                return
            }
            guard let value = dict["UIKeyboardFrameEndUserInfoKey"] as? NSValue else {
                return
            }
            /// 键盘高度
            let height = value.cgRectValue.height
            
            /// 移动键盘高度和按钮距离底部高度的差 正的(按钮远在键盘之上)就往下移 负的(按钮在键盘之下)就往上移
            self.moveView(offset:  self.loginView.getLoginButtonBottom() - height)
        }
        
        /// 键盘将要隐藏
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            self.moveView(offset: 0)
        }
    }
    
    /// 移动view
    private func moveView(offset: CGFloat) -> Void {
        UIView.animate(withDuration: 0.25, animations: {
            let fm = self.loginView.frame
            self.loginView.frame = CGRect(x: fm.origin.x, y: self.view.frame.origin.y + offset, width: fm.width, height: fm.height)
        }, completion: nil)
    }
}
