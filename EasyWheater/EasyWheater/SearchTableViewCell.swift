//
//  SearchCellTableViewCell.swift
//  EasyWheater
//
//  Created by zly.private on 16/7/14.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func initTableView(WithTableView tableview: UITableView) -> UITableViewCell {
        let cellID = "SearchCell"
        
        var cell = tableview.dequeueReusableCellWithIdentifier(cellID)
        
        if cell == nil {
            cell = SearchTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        
        return cell!
    }

}
