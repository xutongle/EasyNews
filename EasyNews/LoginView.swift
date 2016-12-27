//
//  LoginView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/25.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class LoginView: UIView {

    private var usernameTF: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        usernameTF = UITextField()
        usernameTF.textAlignment = .center
        usernameTF.placeholder = "输入用户名"
        self.addSubview(usernameTF)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        usernameTF.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(64)
            make.left.right.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
