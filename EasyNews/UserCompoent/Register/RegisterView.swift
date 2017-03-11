//
//  RegisterView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/1.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

typealias RegisterBlock = (() -> Void)

class RegisterView: UIView {

    /// 所有输入框
    private var registerInputView: RegisterInputView!
    
    /// 上方的图片
    private var topImageView: UIImageView!
    
    /// 注册按钮
    private var registerButton: UIButton!
    
    var registerBlock: RegisterBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registerInputView = RegisterInputView(frame: CGRect.zero)
        self.addSubview(registerInputView)
        
        topImageView = UIImageView(image: #imageLiteral(resourceName: "register-top"))
        topImageView.contentMode = .scaleToFill
        self.addSubview(topImageView)
        
        registerButton = UIButton()
        registerButton.setStyle("注册", bgColor: MY_LOGIN_GRAY, textSize: nil, color: .white)
        registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        self.addSubview(registerButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        registerInputView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(180)
        }
        
        topImageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.registerInputView)
            make.bottom.equalTo(self.registerInputView.snp.top).offset(-20)
            make.top.equalTo(self).offset(UserActionViewController.WINDOW_HEIGT)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.registerInputView)
            make.top.equalTo(self.registerInputView.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
        
    }
    
    /// 获得按钮所在距离底部的距离 计算是否要弹起view
    ///
    /// - Returns: 按钮的位置
    func getRegisterButtonBottom() -> CGFloat {
        return frame.height - (registerButton.frame.origin.y + registerButton.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RegisterView {
    
    func registerButtonAction() -> Void {
        registerBlock?()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
