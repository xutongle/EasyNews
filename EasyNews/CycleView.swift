//
//  CycleView.swift
//  CareBaby
//
//  Created by mac_zly on 2016/10/12.
//  Copyright © 2016年 safethink. All rights reserved.
//

import UIKit

//@IBDesignable
class CycleView: UIView {
    
    private var lineWidth: CGFloat = 10       // 画圆那个圈的大小
    private var animation: CABasicAnimation!  // 动画效果
    
    private var shapeLayer: CAShapeLayer!     // 画圆的layer
    
    private var needLabel = false
    private lazy var label: UILabel = {       // 进度 label
        let w = self.frame.width / 2
        let h = self.frame.height / 2
        
        let label = UILabel(frame: CGRect(x: w / 2, y: h / 2, width: w, height: h))
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1622233093, green: 0.6081780195, blue: 0.8383298516, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    /* 进度条 */
    //@IBInspectable
    open var progress: CGFloat = 0 {
        didSet{
            self.setAnimation(toValue: progress)
            self.label.text = String(format: "%.0f", progress * 100) + "%"
        }
    }
    
    init(frame: CGRect, needLabel: Bool) {
        super.init(frame: frame)
        
        self.needLabel = needLabel
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initView()
    }
    
    /* 初始化视图 */
    func initView() -> Void {
        
        lineWidth = frame.width / 15.0
        
        if needLabel {
            self.addSubview(label)
        }
        
        /* 背部视图 */
        self.setGuiderCycle()
        
        /* 设置shapeLayer和它的遮罩 */
        self.setDrawLayer()
    }
    
    //  ============= 圆的路径 _progress(0 - 1) =================
    func getCycleCGPath(_progress: Double) -> CGPath {
        
        let cycleCenter = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2) // 圆心
        let radius: CGFloat = self.bounds.size.width / 2 - self.lineWidth              // 半径
        /* 相当于x轴的中心开始 而不是x轴的最右侧开始 */
        let startPoint = M_PI_2 * 3                                                        // 圆的起点位置
        let endPoint = startPoint + M_PI * 2 * _progress                           // 圆的终点
        
        return UIBezierPath(arcCenter: cycleCenter, radius: radius, startAngle: CGFloat(startPoint), endAngle: CGFloat(endPoint), clockwise: true).cgPath
    }
    
    // ============== 背部的向导圆形 ===============
    func setGuiderCycle() -> Void {
        let guideLayer = CAShapeLayer()
        guideLayer.frame = self.bounds
        self.layer.addSublayer(guideLayer)
        
        guideLayer.lineWidth = self.lineWidth
        guideLayer.opacity = 1
        guideLayer.fillColor = UIColor.clear.cgColor
        guideLayer.strokeColor = UIColor.gray.cgColor
        guideLayer.path = self.getCycleCGPath(_progress: 1)
    }
    
    // ============= 获得渐变层 =================
    func getGradientLayer() -> CALayer {
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
        
        let colors1 = [UIColor(rgba: 0x3DACF7AA), UIColor(rgba: 0xFE6666AA), UIColor(rgba: 0xFFFF02AA), UIColor(rgba: 0x33CC99AA)]
        gradientLayer1.colors = colors1.map {$0.cgColor}
        
        let colors2 = [UIColor(rgba: 0x3DACF7AA), UIColor(rgba: 0xFE6666AA), UIColor(rgba: 0xFFFF02AA), UIColor(rgba: 0x33CC99AA)]
        gradientLayer2.colors = colors2.map {$0.cgColor}
        
        /* 给这个layer上渐变色 用这个普通的图层包住两个渐变图层 */
        gradientLayer.addSublayer(gradientLayer1)
        gradientLayer.addSublayer(gradientLayer2)
        
        /* 添加这个有渐变色的layer */
        self.layer.addSublayer(gradientLayer)
        
        return gradientLayer
    }
    
    // ============== 初始化圆形ShapeLayer =================
    func setDrawLayer() -> Void {
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
        self.shapeLayer.path = self.getCycleCGPath(_progress: 1)
        self.shapeLayer.strokeEnd = 0
        
        // 设置遮罩
        self.getGradientLayer().mask = self.shapeLayer
    }
    
    //
    func setAnimation(toValue: CGFloat) -> Void {
        CATransaction.begin()
        
        /* 设置动画 还有动画执行完的协议 此处没有用到就省略了 */
        self.animation = CABasicAnimation(keyPath: "strokEnd")
        self.animation.duration = 0.25
        
        self.animation.autoreverses = false            // 返回去再执行一次
        //self.animation.fillMode = kCAFillModeBackwards
        //self.animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        //self.animation.isRemovedOnCompletion = false   // 动画执行完后是否移除
        self.animation.fromValue = self.shapeLayer.strokeEnd
        self.animation.toValue = toValue
        self.shapeLayer.add(animation, forKey: "animateStrokeEnd")
        CATransaction.commit()
        
        //
        self.shapeLayer.strokeEnd = self.progress
        
        // CATransaction.begin()
        // CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        // shapeLayer.strokeEnd = CGFloat(progress)
        // CATransaction.commit()
    }
}

extension UIColor {
    convenience public init(rgba: Int64) {
        let red   = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let blue  = CGFloat((rgba & 0x0000FF00) >> 8)  / 255.0
        let alpha = CGFloat( rgba & 0x000000FF)        / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
