//
//  NewsTableViewCell.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/17.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class BooksTableViewCell: UITableViewCell {

    public static let ID = "BooksTableViewCell"
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.lineToLeft()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func cellWith(tableview: UITableView, indexPath: IndexPath) -> BooksTableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: BooksTableViewCell.ID, for: indexPath)
        return cell as! BooksTableViewCell
    }
    
}
