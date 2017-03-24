//
//  RatingView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/24.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class RatingView: UIView {

    init(frame: CGRect, model: Rating) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class StartLayer: CALayer {
    
    private var start: CGFloat!
    private var drawLayer: CAShapeLayer!
    
    init(start: CGFloat) {
        super.init()
        
        self.start = start
        drawLayer = CAShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
