//
//  ItemScrollView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/23.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

protocol ItemScrollViewDelegate {
    func ItemCilck(girlType: GirlTypeModel)
}


/// 这个就是横向滚动的 妹子的type
class ItemScrollView: UIScrollView {
    
    var item_delegate: ItemScrollViewDelegate?
    
    var itemModels: [GirlTypeModel] = [GirlTypeModel(keywords: "暂无数据")] {
        didSet{
            createView()
        }
    }
    
    private var itemManage: [UILabel] = []
    private var remberX: CGFloat = 0
    
    init(x: CGFloat, y: CGFloat, width: CGFloat) {
        super.init(frame: CGRect(x: x, y: y, width: width, height: 40))
        
        self.backgroundColor = UIColor.white
    }
    
    /// 创建view
    private func createView() -> Void {
        // 先移除
        removeAllView()
        
        for model in itemModels {
            let rect = Tools.getLabelSize(font: UIFont.systemFont(ofSize: 15), text: model.keywords, maxSize: CGSize(width: SCREEN_WIDTH, height: 30))
            let item = UILabel(frame: CGRect(x: remberX + 5, y: 0, width: rect.size.width, height: 40))
            // 记录
            remberX += rect.size.width + 5
            item.setStyle(model.keywords, bgColor: nil, color: MY_BLACK_ALPHA_70, fontName: nil, textSize: 15, alignment: .center)
            self.addSubview(item)
            item.isUserInteractionEnabled = true
            let gestrue = UITapGestureRecognizer(target: self, action: #selector(itemGestrue(gestrue:)))
            item.addGestureRecognizer(gestrue)
            itemManage.append(item)
        }
        
        self.contentSize = CGSize(width: remberX, height: 20)
        
        if itemManage.count > 0 {
            // 设置第0和颜色高亮
            setItemColor(itemManage[0])
        }
    }
    
    func removeAllView() -> Void {
        guard itemManage.count > 0 else {
            return
        }
        for label in itemManage {
            label.removeFromSuperview()
        }
        itemModels.removeAll()
    }
    
    /// view的action
    func itemGestrue(gestrue: UITapGestureRecognizer) -> Void {
        guard let mview = gestrue.view as? UILabel else {
            return
        }
        setItemColor(mview)
    }
    
    /// 设置字体颜色
    func setItemColor(_ label: UILabel) -> Void {
        for lab in itemManage {
            lab.textColor = MY_BLACK_ALPHA_70
            if lab.isEqual(label) {
                label.textColor = UIColor.orange
                // 走一遍协议 其中lab 必定是itemManage的成员
                let index = itemManage.index(of: lab)!
                item_delegate?.ItemCilck(girlType: itemModels[index])
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
