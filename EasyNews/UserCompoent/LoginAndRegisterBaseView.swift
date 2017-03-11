//
//  LoginView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/25.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

protocol LoginAndRegisterBaseViewButtonProtocol {
    func chooseLoginButtonAction() -> Void
    
    func chooseRegisterButtonAction() -> Void
}

class LoginAndRegisterBaseView: UIView {
    
    fileprivate var chooseLoginButton: UIButton!
    fileprivate var chooseRegisterButton: UIButton!
    
    var delegate: LoginAndRegisterBaseViewButtonProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        // 选择登录
        chooseLoginButton = UIButton()
        chooseLoginButton.setStyle("登录", bgColor: .clear, textSize: 50, color: .white)
        chooseLoginButton.addTarget(self, action: #selector(chooseLoginButtonAction), for: .touchUpInside)
        self.addSubview(chooseLoginButton)
        
        // 选择注册
        chooseRegisterButton = UIButton()
        chooseRegisterButton.setStyle("注册", bgColor: .clear, textSize: 30, color: .white)
        chooseRegisterButton.addTarget(self, action: #selector(chooseRegisterButtonAction), for: .touchUpInside)
        self.addSubview(chooseRegisterButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.chooseLoginButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(40)
            make.left.equalTo(self).offset(20)
            make.height.equalTo(50 * WScale)
        }
        
        self.chooseRegisterButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.chooseLoginButton.snp.right).offset(20)
            make.bottom.equalTo(self.chooseLoginButton)
        }
        
    }
    
    func bringToTop() -> Void {
        self.bringSubview(toFront: self.chooseLoginButton)
        self.bringSubview(toFront: self.chooseRegisterButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 按钮事件
extension LoginAndRegisterBaseView {
    
    func chooseLoginButtonAction() -> Void {
        buttonToggleAnimation(loginFontSize: 50, registerFontSize: 30)
        delegate?.chooseLoginButtonAction()
    }
    
    func chooseRegisterButtonAction() -> Void {
        buttonToggleAnimation(loginFontSize: 30, registerFontSize: 50)
        delegate?.chooseRegisterButtonAction()
    }
    
    private func buttonToggleAnimation(loginFontSize: CGFloat, registerFontSize: CGFloat) -> Void {
        //UIView.animate(withDuration: 0.25, animations: {
            self.chooseLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: loginFontSize)
            self.chooseRegisterButton.titleLabel?.font = UIFont.systemFont(ofSize: registerFontSize)
        //}, completion: nil)
    }
}
