//
//  InputView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/2/16.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit
import SnapKit

class InputView: UIView, UITextFieldDelegate {

    private var usernameTF: LoginTF!
    private var passwordTF: LoginTF!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        
        self.usernameTF = LoginTF(frame: CGRect.zero)
        self.usernameTF.placeholder = "用户名"
        self.passwordTF = LoginTF(frame: CGRect.zero)
        self.passwordTF.placeholder = "密码"
        self.addSubview(self.usernameTF)
        self.addSubview(self.passwordTF)
        
        self.usernameTF.delegate = self
        self.passwordTF.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.usernameTF.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        self.passwordTF.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.usernameTF)
            make.bottom.equalTo(self).offset(-10)
            make.top.equalTo(self.usernameTF.snp.bottom).offset(1)
            make.height.equalTo(self.usernameTF.snp.height)
        }
        
    }
    
    func getUsernameText() -> String? {
        return usernameTF.text
    }
    
    func getPasswordText() -> String? {
        return passwordTF.text
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setStrokeColor(MY_TEXT_GRAY.cgColor)
        
        let y = rect.height / 2 - 0.5
        let right_x = rect.width - 10 * WScale
        ctx?.addLines(between: [CGPoint(x: 10 * WScale, y: y),
                                CGPoint(x: right_x, y: y)])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LoginTF: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.height, y: 0, width: bounds.width - bounds.height, height: bounds.height)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.height, y: 0, width: bounds.width - bounds.height, height: bounds.height)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
