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
    
    override func viewWillAppear(animated: Bool) {
        self.searchTextField.becomeFirstResponder()
        if isFirst {
            
            // 搞定导航栏 Model过来也有
            let navBar = UINavigationBar.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 64))
            navBar.barStyle = .BlackTranslucent
            let navItem = UINavigationItem.init(title: "搜索城市")
            
            let navLeftButton = UIBarButtonItem.init(title: "<返回", style: .Done, target: self, action: #selector(dismissMe))
            let navRightButton = UIBarButtonItem.init(title: "搜索", style: .Done, target: self, action: #selector(searchIt))
            navLeftButton.tintColor = UIColor.whiteColor()
            navRightButton.tintColor = UIColor.whiteColor()
            
            navBar.pushNavigationItem(navItem, animated: false)
            navItem.setLeftBarButtonItem(navLeftButton, animated: false)
            navItem.setRightBarButtonItem(navRightButton, animated: false)
            
            self.view.addSubview(navBar)
            isFirst = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        wself.view.backgroundColor = UIColor.whiteColor()
        let bgImageView = UIImageView.init(frame: self.view.frame)
        bgImageView.image = UIImage.init(named: "SearchBg")
        self.view.addSubview(bgImageView)
        
        /**
         * 搜索框
         **/
        searchTextField = UITextField.init(frame: CGRectMake(0, 64, SCREEN_WIDTH, 30))
        searchTextField.borderStyle = .RoundedRect
        searchTextField.textAlignment = .Center
        searchTextField.placeholder = "输入城市名称"
        searchTextField.clearButtonMode = .WhileEditing
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(upSearchTextField), forControlEvents: .TouchDown)
        self.view.addSubview(searchTextField)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(inputBegin))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    func dismissMe() -> Void {
        
        //
        searchTextField.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchIt() -> Void {
        
    }
    
    // 点击空白处
    func inputBegin() -> Void {
        self.searchTextField.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 文字改变时
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    // 按下return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 收回键盘(搜索)
        searchIt()
        textField.endEditing(true)
        return true
    }
    
    // 上升键盘
    func upSearchTextField() -> Void {
        // 一次动画
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
            self.searchTextField.frame = CGRectMake(0, 44, SCREEN_WIDTH, 30)
        }) { (finshed) in
            // 二次动画
            UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
                self.searchTextField.frame = CGRectMake(0, 64, SCREEN_WIDTH, 30)
                }, completion: { (finshed) in })
        }
    }
    
    // 暂时不用
//    func downSearchTextField() -> Void {
//        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
//            self.searchTextField.frame = CGRectMake(0, SCREEN_HEIGHT / 2 + 20, SCREEN_WIDTH, 30)
//        }) { (finshed) in
//            //
//            self.searchTextField.resignFirstResponder()
//
//            UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
//                self.searchTextField.frame = CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, 30)
//                }, completion: { (finshed) in
//            })
//        }
//    }
    
}
