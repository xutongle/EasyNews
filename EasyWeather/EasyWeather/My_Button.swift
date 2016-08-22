//
//  My_Button.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/22.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

class My_Button: UIButton {

    private var _touchUpInsideBlick: (()->Void)!
    
    init(frame: CGRect, title: String?, bgColor: UIColor?, titleColor: UIColor?, touchUpInsideBlock:(()->Void)? ) {
        super.init(frame: frame)
        
        if title != nil { self.setTitle(title, forState: .Normal) }
        if bgColor != nil { self.backgroundColor = bgColor }
        if titleColor != nil { self.setTitleColor(titleColor, forState: .Normal) }  
        //
        if (touchUpInsideBlock != nil) {
            _touchUpInsideBlick = touchUpInsideBlock
            self.addTarget(self, action: #selector(TouchUpInsideAction), forControlEvents: .TouchUpInside)
        }
    }
    
    func TouchUpInsideAction() -> Void {
        
        _touchUpInsideBlick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
