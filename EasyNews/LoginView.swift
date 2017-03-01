//
//  LoginView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/1.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

typealias LoginBlock = (()->Void)

class LoginView: UIView {

    // 登录按钮的回调
    var loginBlock: LoginBlock?
    
    // 用户名和密码的View
    private var loginInputView: LoginInputView!
    /// 登录按钮
    private var loginButton: UIButton!
    /// 顶部图片
    private var topImageView: UIImageView!
        
    /// 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loginInputView = LoginInputView(frame: CGRect.zero)
        self.addSubview(loginInputView)
        
        topImageView = UIImageView(image: #imageLiteral(resourceName: "login-top"))
        topImageView.contentMode = .scaleAspectFill
        topImageView.clipsToBounds = true
        self.addSubview(topImageView)
        
        loginButton = UIButton()
        loginButton.setStyle("登录", bgColor: MY_LOGIN_GRAY, textSize: nil, color: .white)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        self.addSubview(loginButton)
    }
    
    /// 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        loginInputView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(100)
        }
        
        topImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.loginInputView.snp.top).offset(-10)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(UserActionViewController.WINDOW_HEIGT)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginInputView.snp.bottom).offset(20)
            make.left.right.equalTo(self.loginInputView)
            make.height.equalTo(44)
        }
    }
    
    /// 获得按钮所在距离底部的距离 计算是否要弹起view
    ///
    /// - Returns: 按钮的位置
    func getLoginButtonBottom() -> CGFloat {
        return frame.height - (loginButton.frame.origin.y + loginButton.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 其他
extension LoginView {
    
    /// 登录事件
    @objc fileprivate func loginButtonAction() -> Void {
        loginBlock?()
    }
    
    /// 触摸了view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
