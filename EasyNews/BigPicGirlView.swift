//
//  BigPicGirlView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/1/9.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

extension UIViewController {
    func showImage(url: String, mframe: CGRect) -> Void {
        
        let bigPicGirlView = BigPicGirlView(frame: mframe)
        bigPicGirlView.url = url
        UIApplication.shared.keyWindow?.addSubview(bigPicGirlView)
        
        UIView.animate(withDuration: 0.3) {
            bigPicGirlView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
    }
}

// 查看大图
class BigPicGirlView: UIImageView {
    
    private var removeMeGestrue: UITapGestureRecognizer!
    
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
    }
    
    private func makePic() {
        guard let murl = URL(string: url) else {
            return
        }
        
        self.kf.setImage(with: murl, placeholder: nil, options: nil, progressBlock: { (a, b) in
            
        }) { (image, error, cache, url) in
            
        }
    }
    
    @objc private func removeMe() {
        self.removeFromSuperview()
        self.removeMeGestrue = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
