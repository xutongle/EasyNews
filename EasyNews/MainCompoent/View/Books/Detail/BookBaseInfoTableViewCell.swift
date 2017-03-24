//
//  BookBaseInfoTableViewCell.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/24.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class BookBaseInfoTableViewCell: UITableViewCell {

    public static let ID = "BookBaseInfoTableViewCell"
    
    // 主标题
    fileprivate var titleLabel: UILabel!
    // 副标题
    fileprivate var subtitleLabel: UILabel!
    // 作者
    fileprivate var authorLabel: UILabel!
    // 出版社
    fileprivate var publisherLabel: UILabel!
    // 出版时间
    fileprivate var pubdateLabel: UILabel!
    
    // rating
    
    var model: Books! {
        didSet{
            self.titleLabel.text = model.title
            self.subtitleLabel.text = model.subtitle
            self.authorLabel.text = "作者: " + Tools.arrayToString(array: model.author, s: ",")
            self.publisherLabel.text = "出版社: " + model.publisher
            self.pubdateLabel.text = "出版日期: " + model.pubdate
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.lineToLeft()
        
        // 主标题
        titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.setStyle("null", bgColor: nil, color: UIColor.black, fontName: nil, textSize: Font_LitterNum, alignment: .left)
        self.contentView.addSubview(titleLabel)
        
        // 副标题
        subtitleLabel = UILabel()
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.setStyle("null", bgColor: nil, color: MY_TEXT_GRAY, fontName: nil, textSize: Font_SmallSize, alignment: .left)
        self.contentView.addSubview(subtitleLabel)
        
        // 作者
        authorLabel = UILabel()
        authorLabel.adjustsFontSizeToFitWidth = true
        authorLabel.setStyle("null" , bgColor: nil, color: MY_TEXT_GRAY, fontName: nil, textSize: Font_SmallSize, alignment: .left)
        self.contentView.addSubview(authorLabel)
        
        // 出版社
        publisherLabel = UILabel()
        publisherLabel.adjustsFontSizeToFitWidth = true
        publisherLabel.setStyle("null", bgColor: nil, color: MY_TEXT_GRAY, fontName: nil, textSize: Font_SmallSize, alignment: .left)
        self.contentView.addSubview(publisherLabel)
        
        // 出版日期
        pubdateLabel = UILabel()
        pubdateLabel.adjustsFontSizeToFitWidth = true
        pubdateLabel.setStyle("null", bgColor: nil, color: MY_TEXT_GRAY, fontName: nil, textSize: Font_SmallSize, alignment: .left)
        self.contentView.addSubview(pubdateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        self.subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.titleLabel.snp.left)
        }
        
        self.authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.subtitleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.titleLabel.snp.left)
        }
        
        self.publisherLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.authorLabel.snp.bottom).offset(5)
            make.left.equalTo(self.titleLabel.snp.left)
        }
        
        self.pubdateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.publisherLabel.snp.bottom).offset(5)
            make.left.equalTo(self.titleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func cellWith(tableview: UITableView, indexPath: IndexPath) ->BookBaseInfoTableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: BookBaseInfoTableViewCell.ID, for: indexPath)
        
        return cell as! BookBaseInfoTableViewCell
    }
    
}
