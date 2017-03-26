//
//  DetailScrollView.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/23.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

protocol BookDetailTableViewProtocol: class {
    func GoDetail(value: String) -> Void
}

class BookDetailTableView: UITableView {
    
    // 顶部图片
    fileprivate var topImageView: UIImageView!
    // 数据
    fileprivate var model: Books!
    
    weak var book_detail_delegate: BookDetailTableViewProtocol?
    
    init(frame: CGRect, model: Books) {
        super.init(frame: frame, style: .plain)
        self.backgroundColor = UIColor.white
        
        self.model = model
        
        self.delegate = self
        self.dataSource = self
        
        self.lineToLeft()
        
        self.register(BookBaseInfoTableViewCell.self, forCellReuseIdentifier: BookBaseInfoTableViewCell.ID)
        self.register(BookDetailTableViewCell.self, forCellReuseIdentifier: BookDetailTableViewCell.ID)

        // 图片
        topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 240))
        topImageView.clipsToBounds = true
        topImageView.backgroundColor = UIColor.black
        topImageView.contentMode = .scaleAspectFit
        self.tableHeaderView = topImageView

        self.tableFooterView = UIView()
        
        // 设置图片
        topImageView.kf.setImage(with: URL(string: model.images.large), placeholder: #imageLiteral(resourceName: "none"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource 协议
extension BookDetailTableView: UITableViewDelegate, UITableViewDataSource {
    
    // cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 4
        if model.summary == nil || model.summary == "" {
            count -= 1
        }
        if model.authorIntro == nil || model.authorIntro == "" {
            count -= 1
        }
        if model.catalog == nil || model.catalog == "" {
            count -= 1
        }
        return count
    }
    
    // config cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = BookBaseInfoTableViewCell.cellWith(tableview: tableView, indexPath: indexPath)
            cell.model = self.model
            return cell
        case 1:
            let cell = BookDetailTableViewCell.cellWith(tableview: tableView, indexPath: indexPath)
            cell.summyLabel.text = model.summary
            return cell
        case 2:
            let cell = BookDetailTableViewCell.cellWith(tableview: tableView, indexPath: indexPath)
            cell.simpleLabel.text = "作者介绍"
            cell.summyLabel.text = model.authorIntro
            return cell
        case 3:
            let cell = BookDetailTableViewCell.cellWith(tableview: tableView, indexPath: indexPath)
            cell.simpleLabel.text = "目录"
            cell.summyLabel.text = model.catalog
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // 点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 1:
            book_detail_delegate?.GoDetail(value: model.summary)
            break
        case 2:
            book_detail_delegate?.GoDetail(value: model.authorIntro)
            break
        case 3:
            book_detail_delegate?.GoDetail(value: model.catalog)
            break
        default:
            break
        }
    }
}
