//
//  SettingViewController.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/25.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settingView = SettingTableView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: .Plain)
        
        settingView.tableHeaderView = UIView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, 20))
        settingView.separatorStyle = .None
        
        settingView.registerNib(UINib.init(nibName: "OtherSettingCellTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherSettingCell")
        
        //签协议
        settingView.delegate = settingView
        settingView.dataSource = settingView
        
        //
        self.view.addSubview(settingView)
        
        let okButton = UIButton.init(frame: CGRectMake(SCREEN_WIDTH - 70, SCREEN_HEIGHT - 70, 60, 60))
        okButton.setImage(UIImage.init(named: "okBtn"), forState: .Normal)
        okButton.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(okButton)
        okButton.addTarget(self, action: #selector(dismissMe), forControlEvents: .TouchUpInside)
    }
    
    @objc
    func dismissMe() -> Void {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
