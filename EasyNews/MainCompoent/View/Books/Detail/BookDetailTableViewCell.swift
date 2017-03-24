//
//  BookDetailTableViewCell.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/24.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class BookDetailTableViewCell: UITableViewCell {
    
    public static let ID = "BookDetailTableViewCell"
    
    var simpleLabel: UILabel!
    
    var summyLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.lineToLeft()
        
        simpleLabel = UILabel()
        simpleLabel.setStyle("简介", bgColor: nil, color: MY_TEXT_GRAY, fontName: nil, textSize: 12, alignment: .left)
        self.contentView.addSubview(simpleLabel)
        
        summyLabel = UILabel()
        summyLabel.setStyle("", bgColor: nil, color: .black, fontName: nil, textSize: Font_NormalNum, alignment: .left)
        summyLabel.numberOfLines = 0
        self.contentView.addSubview(summyLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.simpleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(10)
        }
        
        self.summyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.simpleLabel.snp.bottom)
            make.left.equalTo(self.simpleLabel.snp.left)
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self).offset(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func cellWith(tableview: UITableView, indexPath: IndexPath) ->BookDetailTableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: BookDetailTableViewCell.ID, for: indexPath)
        
        return cell as! BookDetailTableViewCell
    }
    
}
