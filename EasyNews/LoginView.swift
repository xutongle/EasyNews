//
//  LoginView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/25.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class LoginView: UIView {

    // 用户名和密码的View
    private var minputView: InputView!
    
    private var chooseLoginButton: UIButton!
    private var chooseRegisterButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MY_BACK_GRAY
    
        minputView = InputView(frame: CGRect.zero)
        self.addSubview(minputView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        minputView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(100)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
