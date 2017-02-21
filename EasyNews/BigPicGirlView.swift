//
//  BigPicGirlView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/9.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

// 查看大图
class BigPicGirlView: UIImageView {
    
    // 进度条
    private lazy var progressView: CycleView = {
        let w = SCREEN_WIDTH / 4
        let h = SCREEN_HEIGHT / 4
        
        let progressView = CycleView(frame: CGRect(x: SCREEN_WIDTH_2 - (w / 2), y: SCREEN_HEIGHT_2 - (w / 2), width: w, height: w))
        progressView.needLabel = true
        
        return progressView
    }()
    
    var url: String = "" {
        didSet{
            makePic()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black
        self.contentMode = .scaleAspectFit
        
        self.isUserInteractionEnabled = true
        
        self.addSubview(progressView)
    }
    
    private func makePic() {
        guard let murl = URL(string: url) else {
            return
        }
        
        self.kf.setImage(with: murl, placeholder: nil, options: nil, progressBlock: { [weak self] (a, b) in
            DispatchQueue.main.async {
                if let weakSelf = self {
                    weakSelf.progressView.progress = CGFloat(a) / CGFloat(b)
                }
            }
        }) { (image, error, cache, url) in
            DispatchQueue.main.async(execute: {
                self.progressView.removeFromSuperview()
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

