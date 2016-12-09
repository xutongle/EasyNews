//
//  Constants.swift
//  CareBaby
//
//  Created by mac_zly on 16/9/19.
//  Copyright © 2016年 safethink. All rights reserved.
//

import UIKit


// MARK: - ********************* 长度类 ************************

// 屏幕宽高
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_BOUNDS = UIScreen.main.bounds

// 568是5s 和 5c的高 所以一下数值都是以5s大小为基准上下缩放
let WScale = SCREEN_HEIGHT > 568 ? SCREEN_HEIGHT / 568 : 1

// MARK: - ------------------------  字体大小 -----------------------------

private let SuperBigNum: CGFloat = 24.0
let Font_SuperBigSize: CGFloat = SuperBigNum * WScale

private let BigNum: CGFloat =  20.0
let Font_BigSize: CGFloat = BigNum * WScale

private let LitterNum: CGFloat = 18.0
let Font_LitterSize: CGFloat = LitterNum * WScale

private let NormalNum: CGFloat = 16.0
let Font_NormalSize: CGFloat = WScale * NormalNum

private let SomallNum: CGFloat = 14.0
let Font_SmallSize: CGFloat = WScale * SomallNum



