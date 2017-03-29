//
//  ImageScrollView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/2/8.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class ImageScrollView: UIScrollView {

    fileprivate var imageUrl: [String] = []
    
    private var countManager: Set<Int> = Set()
    // 当前滑动到第几张图片
    fileprivate var count: Int = 1 {
        didSet {
            // 如果没有出现过
            if !countManager.contains(count) {
                countManager.insert(count)
                //
                self.addSubview(getImageView(mcount: count - 1))
            }
        }
    }
    
    public init(frame: CGRect, imageUrl: [String]) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.imageUrl = imageUrl
        
        let count: CGFloat = CGFloat(imageUrl.count == 0 ? 1 : imageUrl.count)
        self.contentSize = CGSize(width: SCREEN_WIDTH * count, height: SCREEN_HEIGHT)
        
        self.isPagingEnabled = true
        self.delegate = self
        
        if count == 1 {
            self.addSubview(getImageView(mcount: 0))
        }
    }
    
    // 获得mcount位置上的BigPicGirlView
    fileprivate func getImageView(mcount: Int) -> BigPicGirlView {
        let bigPicView = BigPicGirlView(frame: CGRect(x: self.frame.size.width * CGFloat(mcount), y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height))
        
        if imageUrl.count >= count{
            bigPicView.url = imageUrl[count - 1]
        }
        
        return bigPicView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        count = Int(scrollView.contentOffset.x.multiplied(by: SCREEN_WIDTH)) + 1
    }
    
}
