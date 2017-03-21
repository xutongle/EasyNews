//
//  TempView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/20.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class TempView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    public static func getView(mframe: CGRect) -> TempView {
    
        let nibView = Bundle.main.loadNibNamed("TempView", owner: nil, options: nil)!
        let tempView = nibView[0] as! TempView
        tempView.frame = mframe
        return tempView
    }

}
