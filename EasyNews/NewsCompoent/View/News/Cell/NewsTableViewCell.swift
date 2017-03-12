//
//  NewsTableViewCell.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/12.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    public static let ID: String = "NewsTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func cellWith(tableview: UITableView, indexPath: IndexPath) -> NewsTableViewCell {
        return tableview.dequeueReusableCell(withIdentifier: NewsTableViewCell.ID, for: indexPath) as! NewsTableViewCell
    }
    
}
