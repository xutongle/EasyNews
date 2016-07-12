//
//  AddViewController.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/26.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    static let addViewController = AddViewController()
    
    private var searchTextField:UITextField!
    
    //
    var isFirst = true
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - -----------------------生命周期------------------------------------
    
    override func viewWillAppear(animated: Bool) {
        if isFirst {
            
            // 搞定导航栏 Model过来也有
            let navBar = UINavigationBar.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 64))
            navBar.barStyle = .BlackTranslucent
            let navItem = UINavigationItem.init(title: "搜索城市")
            
            // 导航栏按钮
            let navCancelButton = UIBarButtonItem.init(title: "取消", style: .Done, target: self, action: #selector(dismissMe))
            navCancelButton.tintColor = UIColor.whiteColor()
            
            navBar.pushNavigationItem(navItem, animated: false)
            navItem.setRightBarButtonItems([navCancelButton], animated: false)
            
            /**
             * 搜索框
             **/
            searchTextField = UITextField.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 30))
            searchTextField.borderStyle = .RoundedRect
            searchTextField.textAlignment = .Center
            searchTextField.placeholder = "输入城市名称"
            searchTextField.clearButtonMode = .WhileEditing
            
            searchTextField.delegate = self
            self.view.addSubview(searchTextField)
            
            // 添加上
            navItem.titleView = searchTextField
            
            self.view.addSubview(navBar)
            isFirst = false
        }
        self.searchTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red:0/255.0, green:139/255.0, blue:139/255.0, alpha: 1)
        self.view.addSubview( CityListTableView.init(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - -----------------------自己的方法------------------------------------
    
    func dismissMe() -> Void {
        
        searchTextField.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - -----------------------TextField协议------------------------------------
    
    // 文字改变时
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    // 按下return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 收回键盘(搜索)
        textField.endEditing(true)
        return true
    }
    
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.searchTextField.endEditing(true)
    }
    
}
