//
//  SlidingView.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/29.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

// 设置按钮的回调
var setttingBlock: (() -> Void)!
var clickCellBlock: ((city: String, province: String) -> Void)!

// MARK: - ----------------------- extension ----------------------------------

let slidingView = SlidingView(frame: CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT))

extension UIView {
    // 添加侧滑到视图
    func addSlidingView_zly() -> SlidingView {
        slidingView.tableview.delegate = slidingView
        slidingView.tableview.dataSource = slidingView
        self.addSubview(slidingView)
        return slidingView
    }
    
    func getSlidingView_zly() -> SlidingView {
        return slidingView
    }
}

// MARK: - ----------------------- 侧滑类 ----------------------------------

class SlidingView: UIView, UITableViewDelegate, UITableViewDataSource {
    // 数据源
    var dataForTableView: [[String:String]]!
    // tableview
    private var tableview: UITableView!
    // 顶部视图
    private var topView: UIView!
    // 膜
    private var alphaView: UIView!
    // 设置按钮
    private var settingButton: UIButton!
    // 是否侧滑
    var isSliding = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        dataForTableView = []
        // 膜
        alphaView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        alphaView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        alphaView.alpha = 0
        self.addSubview(alphaView)
        
        //侧滑的顶部视图
        topView = UIView.init(frame: CGRectMake(0, 0, SlidingStyle.slidingStyle.slidingViewSize, 64))
        topView.backgroundColor = UIColor(red:32/255.0, green:178/255.0, blue:170/255.0, alpha: 1)
        let label = UILabel.init(frame: CGRectMake(0, 30, topView.frame.size.width, 30))
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.text = "保存的天气"
        topView.addSubview(label)
        self.addSubview(topView)
        
        // 侧滑的tableview
        tableview = UITableView.init(frame: CGRectMake(0, 64, SlidingStyle.slidingStyle.slidingViewSize, SCREEN_HEIGHT - 124), style: .Plain)
        tableview.separatorInset = UIEdgeInsetsZero
        tableview.layoutMargins = UIEdgeInsetsZero
        self.addSubview(tableview)
        
        // 设置按钮
        settingButton = myButton.init(frame: CGRectMake(0, SCREEN_HEIGHT - 60, SlidingStyle.slidingStyle.slidingViewSize, 60))
        settingButton.backgroundColor = UIColor.whiteColor()
        settingButton.setImage(UIImage.init(named: "settings"), forState: .Normal)
        settingButton.setTitle("设置", forState: .Normal)
        settingButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        settingButton.imageView?.contentMode = .ScaleAspectFit
        settingButton.addTarget(self, action: #selector(settingAction), forControlEvents: .TouchUpInside)
        self.addSubview(settingButton)
        
        // 关闭侧滑的手势
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(gesTrueAction))
        alphaView.addGestureRecognizer(tapGesture)
        //
        let swipGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(gesTrueAction))
        swipGesture.direction = .Left
        self.addGestureRecognizer(swipGesture)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ----------------------- tableview 协议 ----------------------------------
    
    // 返回cell数量
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }
    
    // 配置cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SlidingViewCell.getSlidingViewCellWith(tableView)
        
        let view = UIView()
        view.backgroundColor = ORANGE_COLOR
        cell.selectedBackgroundView = view
        
        let dict = dataForTableView[indexPath.row]
        cell.leftLabel.text =  dict["city"]
        cell.rightLabel.text =  dict["province"]
        
        return cell
    }
    
    // cell高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    // 点击cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 去首页刷新天气
        clickCellBlock(city: dataForTableView[indexPath.row]["city"]!, province: dataForTableView[indexPath.row]["province"]!)
    }
    
    // 是否允许删除
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if (editingStyle == .Delete) {
            let result = DBOperaCityList.dbOperaCityList.delectByCityName(dataForTableView[indexPath.row]["city"]!)
            if result != nil && result != false {
                dataForTableView.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }else {
                self.show("删除失败", block: { })
            }
        }
        else if (editingStyle == .Insert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: - ----------------------- 自己的方法 ----------------------------------
    
    // 手势关闭侧划
    func gesTrueAction() -> Void {
        toggleSldingView(false)
    }
    
    // 重载数据
    func reloadData() -> Void {
        self.tableview.reloadData()
    }
    
    // 开关侧滑
    func toggleSldingView(open: Bool) -> Void {
        
        // 如果没有打开侧滑
        if !isSliding && open {
            UIView.animateWithDuration(0.25, animations: {
                self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            })
            self.alphaView.alpha = 1
        }else {
            self.alphaView.alpha = 0
            UIView.animateWithDuration(0.25, animations: {
                self.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            })
        }
        
    }
    
    // 设置按钮事件
    func settingAction() -> Void {
        setttingBlock()
    }
    
    // 让cell一来选中默认的cell
    func lightCell() -> Void {
        print("lightcell")
        var n = 0
        for dict in dataForTableView {
            if dict["city"] == TopView.topView.location {
                tableview.selectRowAtIndexPath(NSIndexPath.init(forRow: n, inSection: 0), animated: true, scrollPosition: .None)
            }
            n += 1
        }
    }
}

// MARK: - --------------------- 设置按钮 ----------------------
class myButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath.init()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(SlidingStyle.slidingStyle.slidingViewSize, 0))
        path.lineWidth = 2
        UIColor.blackColor().setStroke()
        path.stroke()
    }
}

// MARK: - ------------------- 侧滑样式控制类 ----------------------------------
class SlidingStyle: NSObject {
    static let slidingStyle = SlidingStyle()
    
    var slidingViewSize: CGFloat = SCREEN_WIDTH / 4 * 3
}

// MARK: - ------------------- 侧滑的cell ----------------------------------
class SlidingViewCell: UITableViewCell {
    var leftLabel: UILabel!
    var rightLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.selectionStyle = .None
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
        
        leftLabel = UILabel(frame: CGRectMake(0 , 0 ,SlidingStyle.slidingStyle.slidingViewSize / 2, 40))
        leftLabel.textAlignment = .Center
        rightLabel = UILabel(frame: CGRectMake(SlidingStyle.slidingStyle.slidingViewSize / 2, 0, SlidingStyle.slidingStyle.slidingViewSize / 2, 40))
        rightLabel.textAlignment = .Center
        self.addSubview(leftLabel)
        self.addSubview(rightLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getSlidingViewCellWith(tableview: UITableView) ->SlidingViewCell {
        let cellID = "SlidingViewCell"
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID) as? SlidingViewCell
        
        if cell == nil {
            cell = SlidingViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }
}
