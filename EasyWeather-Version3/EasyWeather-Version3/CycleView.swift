//
//  CycleView.swift
//  CareBaby
//
//  Created by mac_zly on 2016/10/12.
//  Copyright © 2016年 safethink. All rights reserved.
//

import UIKit

class CycleView: UIView {
    
    // 进度
    var _progress: Double = 0 {
        didSet{
            self.redraw()
        }
    }
    
    // 圆
    fileprivate var cyclePath: UIBezierPath!
    // 
    fileprivate var gradientLayer: CALayer!
    // 画圆的layer
    fileprivate var shapeLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // 设置圆
        self.setCycle()
        
        //
        self.gradientLayer = CALayer()
        // self.gradientLayer.frame = frame
        // 给这个layer上渐变色
        self.setGradientLayer(layer: self.gradientLayer)
        // 添加有渐变色的layer
        self.layer.addSublayer(self.gradientLayer)
        
        // ============= 画图 =================
        // 画圆的layer
        self.shapeLayer = CAShapeLayer()
        // self.shapeLayer.frame = frame
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = UIColor.orange.cgColor
        // 背景颜色透明度
        self.shapeLayer.opacity = 1
        // 线的边缘是圆的
        self.shapeLayer.lineCap = kCALineCapRound
        self.shapeLayer.lineWidth = 10
        
        // 给定上面的圆
        self.shapeLayer.path = self.cyclePath.cgPath
        // 添加路径的layer
        self.layer.addSublayer(self.shapeLayer)
        // 设置遮罩
        self.gradientLayer.mask = self.shapeLayer
    }
    
    //  ============= 圆的路径 =================
    func setCycle() -> Void {
        
        let lineWidth: CGFloat = 5
        // 圆心
        let cycleCenter = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        // 半径
        let radius: CGFloat = self.frame.size.width / 2 - lineWidth
        // 圆的起点位置
        let startPoint = -M_PI_2
        // 圆的终点
        let endPoint = -M_PI_2 + M_PI * 2 * (_progress / 100)
        
        // 圆的路径
        self.cyclePath = UIBezierPath(arcCenter: cycleCenter, radius: radius, startAngle: CGFloat(startPoint), endAngle: CGFloat(endPoint), clockwise: true)
    }
    
    // ============= 给layer渐变层 =================
    func setGradientLayer(layer: CALayer) -> Void {
        
        // 给定两个渐变色
        let gradientLayer1 = CAGradientLayer()
        let gradientLayer2 = CAGradientLayer()
        layer.addSublayer(gradientLayer1)
        layer.addSublayer(gradientLayer2)
        
        gradientLayer1.frame = CGRect(x: 0, y: 0, width: frame.size.width / 2, height: frame.size.height)
        gradientLayer2.frame = CGRect(x: frame.size.width / 2, y: 0, width: frame.size.width / 2, height: frame.size.height)
        gradientLayer1.locations = [0.1, 0.4, 0.6, 0.9]
        gradientLayer2.locations = [0.1, 0.4, 0.6, 0.9]
        gradientLayer1.colors = [#colorLiteral(red: 0.1991458535, green: 0.8004527092, blue: 0.5997542143, alpha: 1).cgColor, #colorLiteral(red: 0.9980185628, green: 0.3990157247, blue: 0.3981621861, alpha: 1).cgColor, #colorLiteral(red: 0.5991889238, green: 0.7987883687, blue: 0.2024019957, alpha: 1).cgColor, #colorLiteral(red: 0.2019459605, green: 0.3999276757, blue: 0.5992789865, alpha: 1).cgColor]
        gradientLayer2.colors = [#colorLiteral(red: 0.1991458535, green: 0.8004527092, blue: 0.5997542143, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.9999318719, blue: 0.006641706917, alpha: 1).cgColor, #colorLiteral(red: 0.9980185628, green: 0.3990157247, blue: 0.3981621861, alpha: 1).cgColor, #colorLiteral(red: 0.2019459605, green: 0.3999276757, blue: 0.5992789865, alpha: 1).cgColor]
    }
    
    func redraw() -> Void {
        // 重新设置圆
        self.setCycle()
        // 重新给定圆
        self.shapeLayer.path = self.cyclePath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    override func draw(_ rect: CGRect) {
        let lineWidth: CGFloat = 5
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(lineWidth)
        ctx?.setStrokeColor(UIColor.black.cgColor)
        ctx?.setLineJoin(.round)
        ctx?.setLineCap(.round)
        // 圆心
        let cycleCenter = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        // 半径
        let radius: CGFloat = self.frame.size.width / 2 - lineWidth
        // 圆的起点位置
        let startPoint = -M_PI_2
        // 圆的终点
        let endPoint = -M_PI_2 + M_PI * 2 * (_progress / 100)
        
        // 圆的路径
        let path = UIBezierPath(arcCenter: cycleCenter, radius: radius, startAngle: CGFloat(startPoint), endAngle: CGFloat(endPoint), clockwise: true)
        
        ctx?.addPath(path.cgPath)
        
        ctx?.strokePath()
    }
    */
    
}
