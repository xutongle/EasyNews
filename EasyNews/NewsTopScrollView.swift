//
//  NewsTopScrollView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/14.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

enum ScrollLeftOrRight {
    case Left
    case Right
}

class NewsTopScrollView: UIScrollView, UIScrollViewDelegate {

    private var centerImageView: UIImageView!
    private var leftImageView: UIImageView!
    private var rightImageView: UIImageView!
    
    private var needScroll: ScrollLeftOrRight?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.groupTableViewBackground
        self.isPagingEnabled = true
        self.delegate = self
        
        self.centerImageView = UIImageView()
        self.addSubview(self.centerImageView)
        self.centerImageView.contentMode = .scaleAspectFill
        self.centerImageView.image = UIImage(named: "A1")
        
        self.leftImageView = UIImageView()
        self.addSubview(self.leftImageView)
        self.leftImageView.contentMode = .scaleAspectFill
        self.leftImageView.image = UIImage(named: "A2")
        
        self.rightImageView = UIImageView()
        self.addSubview(self.rightImageView)
        self.rightImageView.contentMode = .scaleAspectFill
        self.rightImageView.image = UIImage(named: "A3")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentSize = CGSize(width: SCREEN_WIDTH * 3, height: 120 * WScale)
        
        self.leftImageView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: frame.height)
        
        self.centerImageView.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: frame.height)
        
        self.rightImageView.frame = CGRect(x: SCREEN_WIDTH * 2, y: 0, width: SCREEN_WIDTH, height: frame.height)
    }
    
    /* ScrollView 协议 */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.x > SCREEN_WIDTH * 2 {
            needScroll = .Left
        }else if scrollView.contentOffset.x < 0 {
            needScroll = .Right
        }
    }
    
    // 滚动完毕
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)  {
        guard needScroll != nil else {
            return
        }
        switch needScroll! {
        case .Left:
            self.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            break
        case .Right:
            self.setContentOffset(CGPoint(x: SCREEN_WIDTH * 2, y: 0), animated: true)
            break
        }
        needScroll = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
