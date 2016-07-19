//
//  SettingViewController.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/25.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit
import MobileCoreServices

class SettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - -------------------属性-------------------------
    
    var imagePicker:UIImagePickerController? = nil
    
    // MARK: - -------------------生命周期-----------------------
    
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
        okButton.backgroundColor = UIColor.clearColor()
        self.view.addSubview(okButton)
        okButton.addTarget(self, action: #selector(dismissMe), forControlEvents: .TouchUpInside)
        
        // 从设置的view传回来的block
        chooseBgSettingBlock = {other in
            // 弹出提示从哪里选择图片
            let alert = UIAlertController.init(title: "", message: "选择图片自", preferredStyle: .ActionSheet)
            let photoLibrayAction = UIAlertAction.init(title: "图库", style: .Default, handler: { (action) in
                self.choosePic(.PhotoLibrary)
            })
            let cameraAction = UIAlertAction.init(title: "相机", style: .Default, handler: { (action) in
                self.choosePic(.Camera)
            })
            let cancleAction = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
            
            alert.addAction(photoLibrayAction)
            alert.addAction(cameraAction)
            alert.addAction(cancleAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        // 用于恢复默认的背景
        backDeafultBgBlock = {other in
            if SaveImageToDocment.saveImageToDocment.removeImage() {
                BackgroundImageView.backgroundImageView.image = UIImage.init(named: "weather_temp")
                self.view.show("恢复成功", style: ToastStyle(), postion: .InCente, block: { 
                    
                })
            }else {
                self.view.show("恢复失败，稍后试试", block: { })
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 状态栏
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: - －－－－－－－－－－－－－－自己的方法－－－－－－－－－－－－－－－－
    
    func choosePic(type: UIImagePickerControllerSourceType) -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(type) {
            imagePicker = nil
            
            imagePicker = UIImagePickerController.init()
            imagePicker!.delegate = self
            
            //设置图片选择器类型
            imagePicker!.sourceType = type
            //设置选中的媒体文件是否能被编辑
            imagePicker!.allowsEditing = true;
            //设置可以被选择的媒体文件的类型
            imagePicker!.mediaTypes = [kUTTypeImage as String]
            
            self.presentViewController(imagePicker!, animated: true, completion: nil)
        }else {
            let alert = UIAlertController.init(title: "提示", message: type == .Camera ? "啊哦,无法获取摄像头" : "图库获取失败,稍后试试看", preferredStyle: .Alert)
            let cancleAction = UIAlertAction.init(title: "好的", style: .Cancel, handler: nil)
            alert.addAction(cancleAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc
    func dismissMe() -> Void {
        Tools.setUserDefaults(key: "isBlur", andVluew: SingleManager.singleManager.getValue(Key: "isBlur")!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate协议
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage;
        
        // 保存图片并显示图片
        SaveImageToDocment.saveImageToDocment.save(image: image, withName: "currentImage.png") { (compltete, backImage) in
            if compltete {
                // 存储成功直接给背景图
                BackgroundImageView.backgroundImageView.image = backImage
                
                self.view.show("存储成功，更换背景成功", block: {
                    //self.dismissViewControllerAnimated(true, completion: nil)
                })
            }else {
                self.view.show("存储失败，更换背景失败", block: {
                    //self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
