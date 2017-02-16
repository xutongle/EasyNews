//
//  LoginView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/25.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class LoginView: UIView {

    private var minputView: InputView!
    
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
            make.top.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
