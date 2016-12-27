//
//  UserActionViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/25.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class UserActionViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.navigationItem.title = "登陆/注册"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(rightAction))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(LoginView(frame: self.view.frame))
    }

    @objc private func rightAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
}
