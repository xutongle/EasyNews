//
//  BigPicGirlView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/9.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

extension UIViewController {
    func showImage(url: String) -> Void {
        
        let bigPicGirlView = BigPicGirlView(frame: CGRect(x: -SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bigPicGirlView.url = url
        UIApplication.shared.keyWindow?.addSubview(bigPicGirlView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { 
            bigPicGirlView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }) { (finshed) in
            
        }
    }
}

// 查看大图
class BigPicGirlView: UIImageView {
    
    private var removeMeGestrue: UITapGestureRecognizer!
    
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
        removeMeGestrue = UITapGestureRecognizer(target: self, action: #selector(removeMe))
        self.addGestureRecognizer(removeMeGestrue)
        
        self.addSubview(progressView)
    }
    
    private func makePic() {
        guard let murl = URL(string: url) else {
            return
        }

        self.kf.setImage(with: murl, placeholder: nil, options: nil, progressBlock: { (a, b) in
            DispatchQueue.main.async(execute: {
                self.progressView.progress = CGFloat(a) / CGFloat(b)
            })
        }) { (image, error, cache, url) in
            DispatchQueue.main.async(execute: {
                self.progressView.removeFromSuperview()
            })
        }
    }
    
    @objc private func removeMe() {
        UIView.animate(withDuration: 0.3, animations: { 
            self.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }) { (o) in
            self.removeFromSuperview()
            self.removeMeGestrue = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
