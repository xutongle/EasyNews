//
//  LeftSlidingView.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/14.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

enum SlidingControl {
    case OPEN
    case CLOSE
}

// MARK: - -------------------一些全局的私有属性-------------------

//
private let leftSlidingView:LeftSlidingView = LeftSlidingView.init(frame: CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
//
private let myControl:MySlidingControl = MySlidingControl()

//创建一层膜用于让主界面变暗
private let alphaView = UIView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))

//侧滑的tableview
private var tableview:UITableView?

//协议
weak var left_delegate:LeftViewProtocol?

// MARK: - -------------------extension UIView-------------------

extension UIView {
    
    func addLeftSlidingView() -> Void {
        alphaView.backgroundColor = UIColor.blackColor()
        alphaView.alpha = 0
        
        self.addSubview(alphaView)
        self.addSubview(leftSlidingView)
        //把视图带到最前
        alphaView.bringSubviewToFront(self)
        leftSlidingView.bringSubviewToFront(self)
        
        //        let swipGesrue = UISwipeGestureRecognizer.init(target: self, action: #selector(gestrueOpenSliding))
        //        swipGesrue.direction = .Right
        //        self.addGestureRecognizer(swipGesrue)
    }
    
    @objc
    private func gestrueOpenSliding() -> Void {
        sliding(.OPEN)
    }
    
    //侧滑开关
    func sliding(slidingCotrol: SlidingControl) -> Void {
        switch slidingCotrol {
        case .OPEN:
            myControl.isOpen = true
            break
        case .CLOSE:
            myControl.isOpen = false
            break
        }
    }
    
    //获得控制侧滑的实例
    func getMyControl() -> MySlidingControl {
        return myControl
    }
}

// MARK: - -------------------本体-------------------

private class LeftSlidingView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var dataArray:NSMutableArray!
    
    // MARK: - -------------------生命周期-------------------
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        //
        self.backgroundColor = UIColor.whiteColor()
        
        initailTableView()
        
        //拖动视图
        //let panGestrue = UIPanGestureRecognizer.init(target: self, action: #selector(moveSlidingView))
        //alphaView.addGestureRecognizer(panGestrue)
        
        //滑动手势
        let swipGesrue = UISwipeGestureRecognizer.init(target: self, action: #selector(closeSliding))
        swipGesrue.direction = .Left
        //alphaView.addGestureRecognizer(swipGesrue)
        self.addGestureRecognizer(swipGesrue)
        
        //点击alpha视图收回
        let tapGestrue = UITapGestureRecognizer.init(target: self, action: #selector(closeSliding))
        alphaView.addGestureRecognizer(tapGestrue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - -------------------初始化tableview-------------------
    
    private func initailTableView() -> Void {
        let buttonWidth:CGFloat = 60
        
        tableview = UITableView.init(frame: CGRectMake(SCREEN_WIDTH - myControl.openSize, 0, myControl.openSize, SCREEN_HEIGHT - buttonWidth), style: .Plain)
        tableview!.delegate = self
        tableview!.dataSource = self
        // 注册Cell
        tableview?.registerNib(UINib.init(nibName: "LeftTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableview?.registerNib(UINib.init(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        //
        tableview?.bounces = false
        
        //tableview?.separatorStyle = .None
        tableview?.tableFooterView = UIView()
        //组合拳 使下划线往左靠
        tableview?.separatorInset = UIEdgeInsetsZero
        tableview?.layoutMargins = UIEdgeInsetsZero
        
        //tableview的头视图
        let label = UILabel.init(frame: CGRectMake(0, 0, tableview!.frame.size.width, 80))
        label.text = "保存的天气"
        label.backgroundColor = UIColor.init(red: 30 / 255.0, green: 144 / 255.0, blue: 255 / 255.0, alpha: 1)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Justified
        tableview?.tableHeaderView = label
        
        //tableview下面的视图(不是footerview)
        let button = settingButton.init(frame: CGRectMake(SCREEN_WIDTH - myControl.openSize, SCREEN_HEIGHT - buttonWidth, tableview!.frame.size.width, buttonWidth))
        self.addSubview(button)
        button.addTarget(self, action: #selector(jumpToSetting), forControlEvents: .TouchUpInside)
        self.addSubview(tableview!)
    }
    
    // MARK: - ----------------------私有方法-------------------
    
    @objc
    func jumpToSetting() -> Void {
        left_delegate?.settingBtnAction()
    }
    
    // 自己的方法 查询完后执行
    func getAllLocationFormSQLite() -> Void {
        
        weak var weakSelf:LeftSlidingView! = self
        dataArray = NSMutableArray()
        
        // 判断查询到的值如果和当前显示的位置是一样的 就不加入
        DBOperate.dbOperate.queryData { backCitys in
            print(backCitys["city"])
            if backCitys["city"] as! String != HeadView.headView.location {
                weakSelf.dataArray.addObject(backCitys)
            }
            tableview?.reloadData()
        }
    }
    
    // MARK: - -------------------打开侧滑-------------------
    private func openSliding() -> Void{
        //获得历史记录
        getAllLocationFormSQLite()
        //
        
        
        //做个控制 防止侧滑漂移
        if myControl.openSize > SCREEN_WIDTH{
            myControl.openSize = SCREEN_WIDTH - 50
        }
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
            self.frame = CGRectMake((-SCREEN_WIDTH + myControl.openSize), 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            alphaView.alpha = 0.8
            }, completion: { (completion) in
                
        })
    }
    
    // MARK: - -------------------关闭侧滑-------------------
    @objc
    private func closeSliding() -> Void {
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut
            , animations: {
                self.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                alphaView.alpha = 0.0
            }, completion: { (conpletion) in
                
        })
    }
    
    // MARK: - -------------------tableView协议-------------------
    @objc
    private func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if dataArray != nil {
            return dataArray.count + 1
        }else {
            return 1
        }
    }
    
    @objc
    private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! LeftTableViewCell
            
            //组合拳 使下划线往左靠
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
            
            SingleManager.singleManager.add(Key: "LeftSldingView_1", andValue: cell)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell", forIndexPath: indexPath) as! HistoryTableViewCell
            
            let dict = dataArray[indexPath.row - 1] as! NSDictionary
            
            // 显示省和市
            cell.shengLabel.text = dict["province"] as? String
            cell.shiLabel.text = dict["city"] as? String
            
            //组合拳 使下划线往左靠
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
            return cell
        }
    }
    
    @objc
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        left_delegate?.chooseHitsoryCity(dataArray[indexPath.row - 1] as! NSDictionary)
    }
    
    @objc
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: - -------------------侧滑控制类-------------------

class MySlidingControl {
    
    //侧滑打开的大小
    var openSize:CGFloat = SCREEN_WIDTH / 7 * 5{
        didSet{
            tableview?.frame = CGRectMake(SCREEN_WIDTH - myControl.openSize, 0, myControl.openSize, SCREEN_HEIGHT)
        }
    }
    
    //判断是否打开状态
    var isOpen:Bool!{
        didSet{
            if (isOpen == true) {
                leftSlidingView.openSliding()
                
            }else{
                leftSlidingView.closeSliding()
            }
        }
    }
}

// MARK: - -------------------设置按钮-------------------

class settingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        self.setTitle("设置", forState: .Normal)
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.imageView?.contentMode = .ScaleAspectFill
        self.setImage(UIImage.init(named: "Settings"), forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        //绘制线条在button最上方
        let path = UIBezierPath.init()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(self.frame.size.width, 0))
        path.lineWidth = 1
        path.stroke()
    }
}
