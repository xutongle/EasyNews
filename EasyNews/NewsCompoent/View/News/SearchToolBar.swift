//
//  SearchToolBar.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/20.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

protocol SearchToolBarProtocol {
    func searchAction(q: String) -> Void
}

class SearchToolBar: UIView {

    private var searchButton: UIButton!
    private var searchTF: UITextField!
    
    var delegate: SearchToolBarProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.searchButton = UIButton()
        self.searchButton.setStyle("🔍", bgColor: nil, textSize: nil, color: nil)
        self.searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        self.addSubview(self.searchButton)
        
        self.searchTF = UITextField()
        self.searchTF.clearButtonMode = .whileEditing
        self.searchTF.textAlignment = .center
        self.searchTF.placeholder = "输入关键字搜索"
        self.addSubview(self.searchTF)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.searchButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(self.searchButton.snp.height)
        }
        
        self.searchTF.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(self.searchButton.snp.left)
        }
        
    }
    
    //
    @objc private func searchAction() -> Void {
        let q = self.searchTF.text
        if q == nil || q == "" {
            return
        }
        delegate?.searchAction(q: q!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
