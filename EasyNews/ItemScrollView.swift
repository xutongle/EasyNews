//
//  ItemScrollView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/23.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class ItemScrollView: UIScrollView {

    var items: [String] = ["科技资讯", "美女如云", "强势入驻", "CSDOLDLWKNDLQWND", "实在想不到写还是呢么"] {
        didSet{
            
        }
    }
    private var itemManage: [UILabel] = []
    private var remberX: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 30))
        self.backgroundColor = UIColor.white
        
        createView()
    }
    
    /// 创建view
    private func createView() -> Void {
        for str in items {
            let rect = Tools.getLabelSize(font: UIFont.systemFont(ofSize: 15), text: str, maxSize: CGSize(width: SCREEN_WIDTH, height: 30))
            let item = UILabel(frame: CGRect(x: remberX + 5, y: 0, width: rect.size.width, height: 30))
            // 记录
            remberX += rect.size.width + 5
            item.setStyle(str, bgColor: nil, color: MY_BLACK_ALPHA_70, fontName: nil, textSize: 15, alignment: .center)
            self.addSubview(item)
            item.isUserInteractionEnabled = true
            let gestrue = UITapGestureRecognizer(target: self, action: #selector(itemGestrue(gestrue:)))
            item.addGestureRecognizer(gestrue)
            itemManage.append(item)
        }
        
        self.contentSize = CGSize(width: remberX, height: 20)
    }
    
    /// view的action
    func itemGestrue(gestrue: UITapGestureRecognizer) -> Void {
        guard let mview = gestrue.view as? UILabel else {
            return
        }
        setItemColor(mview)
        print(mview.text ?? "None")
    }
    
    /// 设置字体颜色
    func setItemColor(_ label: UILabel) -> Void {
        for lab in itemManage {
            lab.textColor = MY_BLACK_ALPHA_70
            if lab.isEqual(label) {
                label.textColor = UIColor.orange
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
