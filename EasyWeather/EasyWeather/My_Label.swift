//
//  My_Label.swift
//  EasyWeather
//
//  Created by mac_zly on 16/8/22.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit

// 
class My_Label: UILabel {
    
    init(frame: CGRect, title: String?, bgColor: UIColor?, textColor: UIColor?, textFontName: String?, textSize: CGFloat?, textPostion: NSTextAlignment?) {
        super.init(frame: frame)
        
        if title != nil { self.text = title }
        if bgColor != nil { self.backgroundColor = bgColor }
        if textColor != nil { self.textColor = textColor }
        if textSize != nil {
            self.font = UIFont.systemFontOfSize(textSize!)
            
            if textFontName != nil { self.font = UIFont(name: textFontName!,size: textSize!) }
        }
        if textPostion != nil { self.textAlignment = textPostion! }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
