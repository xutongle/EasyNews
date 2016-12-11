//
//  SearchTableView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/11.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class SearchTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private var orginData: [[String]] = [["B"]]
    private var keys: [String] = ["A"]
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        self.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
        self.separatorStyle = .none
        self.tableFooterView = UIView()
        
        Tools.readPlist { (dict) in
            for (key, value) in dict {
                self.keys.append(NetTool.toString(any: key))
                self.orginData.append(value as! [String])
            }
            self.reloadData()
        }
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        return self.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orginData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        
        cell.titleLabel.text = self.orginData[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
