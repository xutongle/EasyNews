//
//  GirlsScrollView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/29.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

enum Direction {
    case Left
    case Right
}

class GirlsScrollView: UIScrollView, UIScrollViewDelegate {

    private var modess: [[GirlModel]] = [] {
        didSet{
            self.reloadData()
        }
    }
    
    private var leftCollectionView: GirlsCollectionView!
    private var centerCollectionView: GirlsCollectionView!
    private var rightCollectionView: GirlsCollectionView!
    
    private var leftFrame: CGRect!
    private var centerFrame: CGRect!
    private var rightFrame: CGRect!
    
    private var managePostion: [CGRect] = []
    private var manageP: [Int] = [0, 1, 2]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isPagingEnabled = true
        self.contentSize = CGSize(width: frame.width * 3, height: frame.height)
        self.delegate = self
        
        leftFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        leftCollectionView = GirlsCollectionView(frame: leftFrame)
        leftCollectionView.backgroundColor = UIColor.red
        
        centerFrame = CGRect(x: frame.width, y: 0, width: frame.width, height: frame.height)
        centerCollectionView = GirlsCollectionView(frame: centerFrame)
        centerCollectionView.backgroundColor = UIColor.orange
        
        rightFrame = CGRect(x: frame.width * 2, y: 0, width: frame.width, height: frame.height)
        rightCollectionView = GirlsCollectionView(frame: rightFrame)
        rightCollectionView.backgroundColor = UIColor.blue
        
        // 位置规划
        managePostion.append(leftFrame)
        managePostion.append(centerFrame)
        managePostion.append(rightFrame)
        
        self.addSubview(leftCollectionView)
        self.addSubview(centerCollectionView)
        self.addSubview(rightCollectionView)
    }
    
    // 协议
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= frame.width * 2 {
            scrollLeftOrRight(direction: .Right)
        }else
        if scrollView.contentOffset.x <= 0 {
            scrollLeftOrRight(direction: .Left)
        }
    }
    
    private func scrollLeftOrRight(direction: Direction) {
        if direction == .Left {
            let rect = manageP
            manageP[0] = rect[1]
            manageP[1] = rect[2]
            manageP[2] = rect[0]
        }else if direction == .Right {
            let rect = manageP
            manageP[0] = rect[2]
            manageP[1] = rect[0]
            manageP[2] = rect[1]
        }
        
        leftCollectionView.frame = managePostion[manageP[0]]
        centerCollectionView.frame = managePostion[manageP[1]]
        rightCollectionView.frame = managePostion[manageP[2]]
        self.setContentOffset(CGPoint(x: frame.width, y: 0), animated: false)
    }
    
    func reloadData() -> Void {
        leftCollectionView.reloadData()
        centerCollectionView.reloadData()
        rightCollectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
