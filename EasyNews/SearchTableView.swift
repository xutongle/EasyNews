//
//  SearchTableView.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/11.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class SearchTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private var orginData: [String : [String]] = [:]          //
    private var remberOrginData: [String : [String]] = [:]    // 保存起来的数据 用于筛选还原数据
    private var keys: [String] = []                           //
    private var remberAllkeys: [String] = []
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.groupTableViewBackground
        
        self.delegate = self
        self.dataSource = self
        
        self.keyboardDismissMode = .onDrag
        self.separatorStyle = .none
        
        self.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
        // 顶部搜索视图
        let searchHeaderView = SearchHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        self.tableHeaderView = searchHeaderView
        
        searchHeaderView.valueChange = { value in
           self.searchIt(value: value)
        }
        
        readAndSortArray()
    }
    
    // 读取数据并且排序
    func readAndSortArray() -> Void {
        // 读取城市数据
        Tools.readPlist { (dict) in
            
            self.orginData = dict as! [String : [String]]
            
            // 排序好后再赋值回去...
            for value in self.orginData.sorted(by: {$0.0 < $1.0}){
                let key = value.key
                self.keys.append(key)
                self.orginData[key] = value.value
            }
            self.remberOrginData = self.orginData
            self.remberAllkeys = self.keys
            // 主线程刷新数据
            DispatchQueue.main.async(execute: {
                self.reloadData()
            })
        }
    }
    
    // 搜索事件
    func searchIt(value: String) -> Void {
        DispatchQueue.global().async {
            let whiteSpace = NSCharacterSet.whitespaces // 空格
            var mvalue: String = ""
            for val in value.components(separatedBy: whiteSpace){  //  按空格把字符串拆分成数组
                mvalue = mvalue + val
            }
            mvalue = mvalue.lowercased()
            
            if mvalue == "" {
                self.keys = self.remberAllkeys
                self.orginData = self.remberOrginData
            }else {
                var firstStr = Tools.hanZiZhuanPinYin(hanzi: mvalue, yinbiao: false) // shen zhen
                firstStr = firstStr.subString(start: 0, end: firstStr.characters.count - 1).uppercased() // S
                if self.keys.contains(firstStr) {   // 是否包含 S
                    self.keys = [firstStr]                                // 保存key
                    let data = self.remberOrginData[firstStr]!            // key 对应的所有城市
                    self.orginData[firstStr]?.removeAll()                 // 移除所有数据
                    for hStr in data {                                    // 便利 key 对应的所有城市
                        // 深圳 -> shenzhen
                        let pStr = Tools.hanZiZhuanPinYin(hanzi: hStr, yinbiao: false).replacingOccurrences(of: " ", with: "")
                        // 城市的str是否包含输入的value 包括中文和拼音 和包含空格的
                        if pStr.contains(mvalue) || hStr.contains(mvalue) {
                            self.orginData[firstStr]?.append(hStr)        // 包含就加入
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orginData[self.keys[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        
        cell.titleLabel.text = self.orginData[self.keys[indexPath.section]]?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.keys
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dict = ["city" : self.orginData[self.keys[indexPath.section]]![indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(LocalConstant.NeedChangeScrollPostion), object: nil, userInfo: dict)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchHeaderView: UIView, UITextFieldDelegate {
    
    private var searchTextField: UITextField!
    var valueChange: ((_ value: String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = WHITE
        
        searchTextField = UITextField()
        searchTextField.layer.cornerRadius = 5
        searchTextField.textAlignment = .center
        searchTextField.placeholder = "输入搜索的城市名称"
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(valueChange(textField:)), for: .editingChanged)
        self.addSubview(searchTextField)
    }
    
    func valueChange(textField: UITextField) -> Void {
        if let text = textField.text {
            valueChange?(text)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.searchTextField.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(5)
            make.right.bottom.equalTo(self).offset(-5)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
