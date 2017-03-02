//
//  RegisterInputView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/1.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class RegisterInputView: UIView, UITextFieldDelegate {

    /// 必须要输入的
    private var usernameTF: LoginTF!
    private var passwordTF: LoginTF!
    private var confimTF: LoginTF!
    
    /// 可选的
    private var emailTF :LoginTF!
    
    /// 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        //self.layer.cornerRadius = 10
        
        self.usernameTF = LoginTF(frame: CGRect.zero)
        self.usernameTF.placeholder = "用户名"
        self.usernameTF.clearButtonMode = .whileEditing
        self.passwordTF = LoginTF(frame: CGRect.zero)
        self.passwordTF.placeholder = "密码"
        self.passwordTF.clearButtonMode = .whileEditing
        self.confimTF = LoginTF(frame: CGRect.zero)
        self.confimTF.placeholder = "确认密码"
        self.confimTF.clearButtonMode = .whileEditing
        self.emailTF = LoginTF(frame: CGRect.zero)
        self.emailTF.placeholder = "邮箱(选填)"
        self.emailTF.clearButtonMode = .whileEditing
        
        self.addSubview(self.usernameTF)
        self.addSubview(self.passwordTF)
        self.addSubview(self.confimTF)
        self.addSubview(self.emailTF)
        
        self.usernameTF.delegate = self
        self.passwordTF.delegate = self
        self.confimTF.delegate = self
        self.emailTF.delegate = self
    }
    
    /// 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.usernameTF.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        self.passwordTF.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.usernameTF)
            make.top.equalTo(self.usernameTF.snp.bottom).offset(5)
            make.height.equalTo(self.usernameTF.snp.height)
        }
        
        self.confimTF.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.usernameTF)
            make.top.equalTo(self.passwordTF.snp.bottom).offset(5)
            make.height.equalTo(self.usernameTF.snp.height)
        }
        
        self.emailTF.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.usernameTF)
            make.top.equalTo(self.confimTF.snp.bottom).offset(5)
            make.height.equalTo(self.usernameTF.snp.height)
            make.bottom.equalTo(self).offset(-10)
        }
        
    }
    
    func getUsernameText() -> String? {
        return usernameTF.text
    }
    
    func getPasswordText() -> String? {
        return passwordTF.text
    }
    
    func getConfimText() -> String? {
        return confimTF.text
    }
    
    func getEmailText() -> String? {
        return emailTF.text
    }
    
    /// 绘制线条
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setStrokeColor(MY_TEXT_GRAY.cgColor)
        
        let y = rect.height / 4
        let right_x = rect.width - 10
        
        for n in 1...3 {
            ctx?.addLines(between: [CGPoint(x: 10 + self.usernameTF.frame.height, y: y * CGFloat(n)),
                                    CGPoint(x: right_x, y: y * CGFloat(n))])
            ctx?.strokePath()
        }
    }
    
    // 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
