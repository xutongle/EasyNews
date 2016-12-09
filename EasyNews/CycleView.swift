//
//  CycleView.swift
//  CareBaby
//
//  Created by mac_zly on 2016/10/12.
//  Copyright © 2016年 safethink. All rights reserved.
//

import UIKit

@IBDesignable
class CycleView: UIView {
    
    private var isLoad = false
    
    /* 进度条 */
    @IBInspectable
    var progress: Double = 0 {
        didSet{
            guard self.shapeLayer != nil else {
                return
            }
            
            self.setCyclePath(_progress: progress)       // 重新设置圆
            self.shapeLayer.add(animation, forKey: "strokeEndAnimation")  // 动画
            self.shapeLayer.path = self.cyclePath.cgPath // 重新给定圆
        }
    }
    
    fileprivate var lineWidth = 10 * WScale

    fileprivate var cyclePath: UIBezierPath!      // 圆的路径
    fileprivate var shapeLayer: CAShapeLayer!     // 画圆的layer
    fileprivate var animation: CABasicAnimation!  // 动画效果
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /* 万恶之源 */
    override func layoutSubviews() {
        if !isLoad {
            self.initView()
            isLoad = true
        }
    }
    
    /* 初始化视图 */
    func initView() -> Void {
        self.backgroundColor = MY_GOUP_GRAY
        
        /* 背部视图 */
        self.setGuiderCycle()
        
        /* 设置圆的路径 */
        self.setCyclePath(_progress: progress)
        
        /* 设置遮罩和绘图的shapeLayer */
        self.setGradientLayer()
    }
    
    //  ============= 圆的路径 _progress(0 - 100) =================
    func setCyclePath(_progress: Double) -> Void {
        
        let cycleCenter = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2) // 圆心
        let radius: CGFloat = self.bounds.size.width / 2 - self.lineWidth              // 半径
        /* 相当于x轴的中心开始 而不是x轴的最右侧开始 */
        let startPoint = -M_PI_2                                                       // 圆的起点位置
        let endPoint = -M_PI_2 + M_PI * 2 * (_progress / 100)                          // 圆的终点
        self.cyclePath = UIBezierPath(arcCenter: cycleCenter, radius: radius, startAngle: CGFloat(startPoint), endAngle: CGFloat(endPoint), clockwise: true)                                               // 圆的路径
    }
    
    // ============== 背部的向导园形 ===============
    func setGuiderCycle() -> Void {
        let guideLayer = CAShapeLayer()
        guideLayer.frame = self.bounds
        
        guideLayer.lineWidth = self.lineWidth
        guideLayer.opacity = 1
        guideLayer.fillColor = UIColor.clear.cgColor
        guideLayer.strokeColor = MY_GRAY.cgColor
        
        self.setCyclePath(_progress: 100)
        
        guideLayer.path = self.cyclePath.cgPath
        
        self.layer.addSublayer(guideLayer)
    }
    
    // ============= 给layer设定渐变层 =================
    func setGradientLayer() -> Void {
        /* 要设置两个渐变色的图层 */
        let gradientLayer = CALayer()
        gradientLayer.frame = self.bounds
        
        /* 设定定两个渐变色图层 */
        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.frame = CGRect(x: 0, y: 0, width: self.bounds.width / 2, height: self.bounds.size.height)
        
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = CGRect(x: self.bounds.width / 2, y: 0, width: self.bounds.width / 2, height: self.bounds.size.height)
        
        gradientLayer1.locations = [0.1, 0.4, 0.6, 0.9]
        gradientLayer2.locations = [0.1, 0.4, 0.6, 0.9]
        
        gradientLayer1.colors = [#colorLiteral(red: 0.1991458535, green: 0.8004527092, blue: 0.5997542143, alpha: 1).cgColor, #colorLiteral(red: 0.9980185628, green: 0.3990157247, blue: 0.3981621861, alpha: 1).cgColor, #colorLiteral(red: 0.5991889238, green: 0.7987883687, blue: 0.2024019957, alpha: 1).cgColor, #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor]
        gradientLayer2.colors = [#colorLiteral(red: 0.1991458535, green: 0.8004527092, blue: 0.5997542143, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.9999318719, blue: 0.006641706917, alpha: 1).cgColor, #colorLiteral(red: 0.9980185628, green: 0.3990157247, blue: 0.3981621861, alpha: 1).cgColor, #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor]
        
        /* 给这个layer上渐变色 用这个普通的图层包住两个渐变图层 */
        gradientLayer.addSublayer(gradientLayer1)
        gradientLayer.addSublayer(gradientLayer2)
        
        /* 添加这个有渐变色的layer */
        self.layer.addSublayer(gradientLayer)
        
        /* 把遮罩给到shapeLayer */
        self.setDrawLayerWith(maskLayer: gradientLayer)
    }
    
    // ============== 画图 =================
    func setDrawLayerWith(maskLayer: CALayer) -> Void {
        // 画圆的layer
        self.shapeLayer = CAShapeLayer()
        self.layer.addSublayer(self.shapeLayer)

        self.shapeLayer.frame = self.bounds
        
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = UIColor.orange.cgColor
        // 背景颜色透明度
        self.shapeLayer.opacity = 1
        // 线的边缘是圆的
        self.shapeLayer.lineCap = kCALineCapRound
        self.shapeLayer.lineWidth = self.lineWidth
        
        // 绘制圆
        self.shapeLayer.path = self.cyclePath.cgPath
        
        /* 设置动画 还有动画执行完的协议 此处没有用到就省略了 */
        self.animation = CABasicAnimation(keyPath: "strokeEnd")
        self.animation.fromValue = 0.0
        self.animation.toValue = 1.0
        self.animation.duration = 0.25
        self.animation.autoreverses = false   // 返回去再执行一次
        self.animation.fillMode = kCAFillModeForwards  //
        self.animation.isRemovedOnCompletion = true  // 动画执行完后是否移除
        self.animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn) //
        
        // self.shapeLayer.autoreverses = false
        self.shapeLayer.add(animation, forKey: "strokeEndAnimation")
        
        // 设置遮罩
        maskLayer.mask = self.shapeLayer
    }
}
