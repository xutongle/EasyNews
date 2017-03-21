//
//  RegisterViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/1.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

// 注册控制器
class RegisterViewController: UIViewController {

    fileprivate var registerView: RegisterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerView = RegisterView(frame: self.view.frame)
        self.view.addSubview(registerView)
        
        // 注册
        registerView.registerBlock = {
            // 注册的网络请求
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalConstant.RegisterButtonClickNotification), object: nil)
        }
        
        makeKeyboradAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 移除通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

}

extension RegisterViewController {
    
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
            self.moveView(offset:  self.registerView.getRegisterButtonBottom() - height)
        }
        
        /// 键盘将要隐藏
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            self.moveView(offset: 0)
        }
    }
    
    /// 移动view
    private func moveView(offset: CGFloat) -> Void {
        UIView.animate(withDuration: 0.25, animations: {
            let fm = self.registerView.frame
            self.registerView.frame = CGRect(x: fm.origin.x, y: self.view.frame.origin.y + offset, width: fm.width, height: fm.height)
        }, completion: nil)
    }
}
