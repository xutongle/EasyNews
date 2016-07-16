//
//  LocationTableViewCell.swift
//  EasyWheater
//
//  Created by zly.private on 16/7/12.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.textColor = UIColor.brownColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func initTableViewCell(tableView: UITableView) -> UITableViewCell {
        let cellID = NSStringFromClass(self)
        
        var locationCell = tableView.dequeueReusableCellWithIdentifier(cellID)
        
        if locationCell == nil {
            locationCell = LocationTableViewCell.init(style: .Default, reuseIdentifier: cellID)
        }
        return locationCell!
    }

}
