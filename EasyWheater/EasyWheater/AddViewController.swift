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
    
    private var backBtn:UIButton!
    var searchTextField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        backBtn = UIButton.init(frame: CGRectMake(SCREEN_WIDTH - 40 - 10, SCREEN_HEIGHT - 40 - (SCREEN_HEIGHT / 2 + SCREEN_HEIGHT / 10), 40, 40))
        self.view.addSubview(backBtn)
        backBtn.setImage(UIImage.init(named: "backIcon"), forState: .Normal)
        backBtn.backgroundColor = UIColor.whiteColor()
        backBtn.addTarget(self, action: #selector(dismissMe), forControlEvents: .TouchUpInside)
        
        /**
         * 搜索框
        **/
        searchTextField = UITextField.init(frame: CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, 30))
        searchTextField.borderStyle = .RoundedRect
        searchTextField.textAlignment = .Center
        searchTextField.placeholder = "点击输入城市名称"
        searchTextField.clearButtonMode = .WhileEditing
        
        searchTextField.delegate = self
        self.view.addSubview(searchTextField)
    }
    
    
    func dismissMe() -> Void {
        searchTextField.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 点击时
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        upSearchTextField()

        return true
    }
    
    // 文字改变时
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.text != "" {
            backBtn.setImage(UIImage.init(named: "searchIcon"), forState: .Normal)
        }else {
            backBtn.setImage(UIImage.init(named: "backIcon"), forState: .Normal)
        }
        return true
    }
    
    // 清除文字
    func textFieldShouldClear(textField: UITextField) -> Bool {
        backBtn.setImage(UIImage.init(named: "backIcon"), forState: .Normal)
        
        downSearchTextField()
        
        return true
    }
    
    func upSearchTextField() -> Void {
        // 一次动画
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
            self.searchTextField.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30)
        }) { (finshed) in
            // 二次动画
            UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
                self.searchTextField.frame = CGRectMake(0, 20, SCREEN_WIDTH, 30)
                }, completion: { (finshed) in })
        }
    }
    
    func downSearchTextField() -> Void {
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
            self.searchTextField.frame = CGRectMake(0, SCREEN_HEIGHT / 2 + 20, SCREEN_WIDTH, 30)
        }) { (finshed) in
            //
            UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
                self.searchTextField.frame = CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, 30)
                }, completion: { (finshed) in })
        }
    }

}
