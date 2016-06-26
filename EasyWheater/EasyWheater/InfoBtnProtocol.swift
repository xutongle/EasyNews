//
//  InfoBtnProtocol.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/24.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

//协议继承NSObjectProtocol
protocol InfoBtnProtocol: NSObjectProtocol {
    
    func infoBtnAction(button: UIButton) -> Void
    
}