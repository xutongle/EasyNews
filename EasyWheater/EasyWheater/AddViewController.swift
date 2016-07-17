//
//  AddViewController.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/26.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit
import CoreFoundation

var backSearchViewBlock: ((cityName: NSString) -> Void)!

class AddViewController: UIViewController, UITextFieldDelegate {
    
    // 自己
    static let addViewController = AddViewController()
    
    // 搜索输入框
    private var searchTextField:UITextField!
    
    // 搜索的View
    let searchView = SearchView.searchView
    
    // 所有城市的字典
    var dataDict:NSDictionary! = nil
    
    //
    var queue:dispatch_queue_t! = nil
    var myqueue: NSOperationQueue! = nil
    var timer:NSTimer! = nil
    var operation:NSBlockOperation? = nil
    
    //
    var isFirst = true
    
    //
    var pinyinStr: NSString! = nil
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - -----------------------生命周期------------------------------------
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFirst {
            
            // 搞定导航栏 Model过来也有
            let navBar = UINavigationBar.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 64))
            navBar.barStyle = .Black
            let navItem = UINavigationItem.init(title: "选择城市")
            
            // 导航栏按钮
            let navCancelButton = UIBarButtonItem.init(title: "取消", style: .Done, target: self, action: #selector(dismissMe))
            navCancelButton.tintColor = UIColor.whiteColor()
            
            navBar.pushNavigationItem(navItem, animated: false)
            navItem.setRightBarButtonItems([navCancelButton], animated: false)
            
            /**
             * 搜索框
             **/
            searchTextField = UITextField.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 30))
            searchTextField.borderStyle = .None
            searchTextField.backgroundColor = UIColor.whiteColor()
            searchTextField.layer.cornerRadius = searchTextField.frame.size.height / 2
            searchTextField.textAlignment = .Center
            searchTextField.placeholder = "输入城市名称"
            searchTextField.clearButtonMode = .WhileEditing
            searchTextField.keyboardType = .Default
            searchTextField.returnKeyType = .Search
            searchTextField.delegate = self
            searchTextField.addTarget(self, action: #selector(valueChange), forControlEvents: .EditingChanged)
            
            // 添加上
            navItem.titleView = searchTextField
            
            self.view.addSubview(navBar)
            isFirst = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化字典
        dataDict = Tools.readPlist()
        
        self.view.backgroundColor = UIColor(red:0/255.0, green:139/255.0, blue:139/255.0, alpha: 1)
        
        self.view.addSubview(CityListTableView.cityListTableView)
        
        // 搜索后弹出来的视图(UIView上的UITableView)
        self.view.addSubview(searchView)
        searchView.alpha = 0
        
        queue = dispatch_queue_create("queryQueue", DISPATCH_QUEUE_CONCURRENT)
        myqueue = NSOperationQueue.init()
        myqueue.maxConcurrentOperationCount = 1
        
        searchChooseCityBlock = {city in
            // 去往MainViewController
            backSearchViewBlock(cityName: city)
            self.dismissMe()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - -----------------------自己的方法------------------------------------
    
    func dismissMe() -> Void {
        
        searchTextField.endEditing(true)
        searchView.dataArray?.removeAllObjects()
        searchView.alpha = 0
        searchTextField.text = ""
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func valueChange(textFiled: UITextField) -> Void {
        searchView.alpha = 1
        
        let inputStr = textFiled.text
        if inputStr == nil {
            print("nil")
            searchView.alpha = 0
            return
        }
        
        let caseInputStr = inputStr?.lowercaseString
        pinyinStr = Tools.hanZiZhuanPinYin(caseInputStr!, yinbiao: false)!
        pinyinStr = pinyinStr.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        if inputStr == "" {
            print("空")
            searchView.alpha = 0
            self.searchView.tableview.reloadData()
            
            return
        }
        
        //getDataToTableview()
        
    }
    
    func getDataToTableview() -> Void {
        
        myqueue.cancelAllOperations()
        
        if operation != nil {
            operation?.cancel()
            operation = nil
        }
        
        operation = NSBlockOperation.init(block: {
            
            for allData in self.dataDict {
                for dict in allData.value as! NSArray {
                    // 汉字
                    let cityName = dict["name"] as! String
                    // pinyin
                    let subCityName = self.subStr(cityName)
                    // 对比
                    if subCityName == self.pinyinStr {
                        self.searchView.dataArray?.addObject(cityName)
                    }
                }
            }
            
            // 抛回去
            dispatch_async(dispatch_get_main_queue(), {
                self.searchView.tableview.reloadData()
            })
            
        })
        
        myqueue.addOperation(operation!)
        searchView.dataArray?.removeAllObjects()
        
    }
    
    // 处理字符串
    func subStr(string: String) -> NSString {
        
        // 未裁剪的拼音
        let strCityName: NSString = Tools.hanZiZhuanPinYin(string, yinbiao: false)!
        // 去除空格
        let noSpaceStr: NSString = strCityName.stringByReplacingOccurrencesOfString(" ", withString: "")
        // 裁剪后的拼音
        let subStr: NSString = noSpaceStr.substringToIndex(self.pinyinStr.length <= noSpaceStr.length ? self.pinyinStr.length : noSpaceStr.length)
        
        return subStr
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
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if self.pinyinStr != nil {
            getDataToTableview()
        }
        return true
    }
    
}
