//
//  BottomView.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/24.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

private let bottomView = BottomView.init(frame: CGRectMake(0, mainTabbleViewHeight + heandViewHeight + 20, SCREEN_WIDTH, SCREEN_HEIGHT - mainTabbleViewHeight - heandViewHeight - 20))

weak var info_delegate:InfoBtnProtocol?

private var isShowInfo = false

// MARK: ------------------扩展------------------------

extension UIViewController {
    func addBottomView() -> Void {
        
        self.view.addSubview(bottomView)
        SingleManager.singleManager.add(Key: "bottomView", andValue: bottomView)
    }
}

class BottomView: UIView {
    
    // MARK: ----------------Label---------------
    
    //穿衣指数label
    var dressingIndexLabel:UILabel!
    //锻炼label
    var exerciseIndexLabel:UILabel!
    //空气质量Label
    var airConditionLabel:UILabel!
    //更新时间Label
    var updateTimeLabel:UILabel!
    
    //APP信息
    var infoBtn:UIButton!
    
    // MARK: ---------------属性--------------------
    
    //穿衣指数
    var dressingIndex = Tools.getUserDefaults("dressingIndex") as! String {
        didSet{
            dressingIndexLabel.text = dressingIndex
        }
    }
    
    //锻炼
    var exerciseIndex = Tools.getUserDefaults("exerciseIndex") as! String {
        didSet{
            exerciseIndexLabel.text = exerciseIndex
        }
    }
    
    //空气质量
    var airCondition = Tools.getUserDefaults("airCondition") as! String {
        didSet{
            airConditionLabel.text = airCondition
        }
    }
    
    //更新时间
    var updateTime = Tools.getUserDefaults("updateTime") as! String {
        didSet{
            updateTimeLabel.text = updateTime
        }
    }
    
    // MARK: ----生命周期-------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        //穿衣指数
        dressingIndexLabel = UILabel.init(frame: CGRectMake(30, 40, self.frame.size.width - 30, 20))
        dressingIndexLabel.text = dressingIndex
        dressingIndexLabel.textColor = UIColor.whiteColor()
        self.addSubview(dressingIndexLabel)
        
        //锻炼
        exerciseIndexLabel = UILabel.init(frame: CGRectMake(30, 80, self.frame.size.width - 30, 20))
        exerciseIndexLabel.text = exerciseIndex
        exerciseIndexLabel.textColor = UIColor.whiteColor()
        self.addSubview(exerciseIndexLabel)
        
        //空气质量
        airConditionLabel = UILabel.init(frame: CGRectMake(30, 120, self.frame.size.width - 30, 20))
        airConditionLabel.text = airCondition
        airConditionLabel.textColor = UIColor.whiteColor()
        self.addSubview(airConditionLabel)
        
        //更新时间
        let infoLabelHeight:CGFloat = 20
        updateTimeLabel = UILabel.init(frame: CGRectMake(0, self.frame.size.height - infoLabelHeight, self.frame.size.width, infoLabelHeight))
        updateTimeLabel.font = UIFont.systemFontOfSize(14)
        updateTimeLabel.textAlignment = .Center
        updateTimeLabel.text = updateTime
        updateTimeLabel.textColor = UIColor.orangeColor()
        self.addSubview(updateTimeLabel)
        
        //信息按钮
        infoBtn = UIButton.init(frame: CGRectMake(self.frame.size.width - 20, self.frame.size.height - 20, 20, 20))
        infoBtn.setImage(UIImage.init(named: "infoBtn"), forState: .Normal)
        infoBtn.imageView?.contentMode = .ScaleAspectFill
        self.addSubview(infoBtn)
        infoBtn.addTarget(self, action: #selector(infoBtnAction), forControlEvents: .TouchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func infoBtnAction(sender: UIButton) -> Void {
        if isShowInfo {
            UIView.animateWithDuration(0.25, animations: {
                //如果已经显示了就回归成info按钮
                sender.removeFromSuperview()
                self.addSubview(sender)
                sender.frame = CGRectMake(self.frame.size.width - 20, self.frame.size.height - 20, 20, 20)
                }, completion: { (finished) in
                    //
                    isShowInfo = false
                    sender.setImage(UIImage.init(named: "infoBtn"), forState: .Normal)
            })
            
        }else {
            //协议,使按钮和主视图一样大
            info_delegate?.infoBtnAction(sender)
            isShowInfo = true
        }
    }
}
