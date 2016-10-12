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

// MARK: - ------------------------  字体大小 -----------------------------
// 568是5s 和 5c的高 所以一下数值都是以5s大小为基准上下缩放
let Font_Scale = SCREEN_HEIGHT > 568 ? SCREEN_HEIGHT / 568 : 1

private let SuperBigNum: CGFloat = 28.0
let Font_SuperBigSize: CGFloat = SuperBigNum * Font_Scale

private let BigNum: CGFloat =  26.0
let Font_BigSize: CGFloat = BigNum * Font_Scale

private let LitterNum: CGFloat = 19.0
let Font_LitterSize: CGFloat = LitterNum * Font_Scale

private let NormalNum: CGFloat = 17.0
let Font_NormalSize: CGFloat = Font_Scale * NormalNum

private let SomallNum: CGFloat = 15.0
let Font_SmallSize: CGFloat = Font_Scale * SomallNum



