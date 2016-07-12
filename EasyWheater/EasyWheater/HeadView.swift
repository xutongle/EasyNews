//
//  HeadView.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/13.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

public enum WhichButton {
    case isDrawUpButton
    case isLocationButton
    case isAddLocationButton
}

// 按钮事件闭包
var btnAction:(whichButton:WhichButton) -> Void = {whichButton in }

class HeadView: UIView {
    
    static let headView:HeadView = HeadView.init(frame: CGRectMake(0, 20, SCREEN_WIDTH, heandViewHeight))
    
    //label宽度
    let locationLabelWidth:CGFloat = 100
    
    var locationButton:UIButton!
    var drawUpButton:UIButton!
    var addLocationButton:UIButton!
    
    var location:String = Tools.getUserDefaults("city") != nil ? Tools.getUserDefaults("city") as! String : "无"{
        didSet{
            locationButton.setTitle(location, forState: .Normal)
        }
    }
 
    // MARK: - -----------------生命周期-----------------
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
                
        //侧滑按钮
        setSlidingButton()
        //位置按钮
        setLocationButton()
        //添加地理按钮
        setAddButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - -----------------设置按钮-----------------
    
    // 左侧按钮
    private func setSlidingButton() -> Void {
        drawUpButton = UIButton.init(frame: CGRectMake(0, 10, 39, heandViewHeight - 25))
        drawUpButton.setImage(UIImage.init(named: "Menu"), forState: .Normal)
        drawUpButton.imageView?.contentMode = .ScaleAspectFit
        
        drawUpButton.addTarget(self, action: #selector(self.slidingAction), forControlEvents: .TouchUpInside)
        self.addSubview(drawUpButton)
    }
    
    // 显示位置按钮
    private func setLocationButton() -> Void {
        locationButton = UIButton.init(frame: CGRectMake((SCREEN_WIDTH - locationLabelWidth) / 2, 5,locationLabelWidth, heandViewHeight - 10))
        //locationButton.frame = CGRectMake((SCREEN_WIDTH - locationLabelWidth) / 2, 5,locationLabelWidth, selfHeght - 10)
        //locationButton.imageEdgeInsets.right = 20
        //locationButton.titleEdgeInsets.left = 20
        
        //locationButton.setImage(UIImage.init(named: "Location"), forState: .Normal)
        locationButton.imageView?.contentMode = .ScaleAspectFit
        
        //监听
        locationButton.setTitle(location, forState: .Normal)
        locationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        //locationButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        locationButton.addTarget(self, action: #selector(self.slidingAction), forControlEvents: .TouchUpInside)

        self.addSubview(locationButton)
    }
    
    // 加号按钮
    private func setAddButton() -> Void {
        addLocationButton = UIButton.init(frame: CGRectMake(SCREEN_WIDTH - 49, 10, 39, heandViewHeight - 25))
        addLocationButton.setImage(UIImage.init(named: "Add"), forState: .Normal)
        addLocationButton.imageView?.contentMode = .ScaleAspectFit
        addLocationButton.addTarget(self, action: #selector(self.slidingAction), forControlEvents: .TouchUpInside)
        self.addSubview(addLocationButton)
    }
    
    // MARK: - -----------------按钮事件-----------------
    
    //采用闭包的方式
    @objc
    private func slidingAction(sender: UIButton) -> Void {
        switch sender {
        case drawUpButton:
            btnAction(whichButton: .isDrawUpButton)
            break
        case locationButton:
            btnAction(whichButton: .isLocationButton)
            break
        case addLocationButton:
            btnAction(whichButton: .isAddLocationButton)
            break
        default:
            break
        }
    }

}
