//
//  HistoryTableViewCell.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/26.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
//    var shengText = Tools.getUserDefaults("province") as! String {
//        didSet{
//            shengLabel.text = shengText
//        }
//    }
//    
//    var shiText = Tools.getUserDefaults("city") as! String {
//        didSet{
//            shiLabel.text = shiText
//        }
//    }

    @IBOutlet weak var shengLabel: UILabel!
    @IBOutlet weak var shiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //
//        shengLabel.text = shengText
//        shiLabel.text = shiText
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
