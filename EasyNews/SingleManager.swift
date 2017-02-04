//
//  SingleManager.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/24.
//  Copyright © 2016年 private. All rights reserved.
//

import Foundation


///单利类
class SingleManager: NSObject {
    
    // 字典存取键值
    private var mutableDictionary: [String: Any]!
    
    // swift的单利 只会初始化一次
    static let singleManager = SingleManager()
    
    // 私有化 只能从上面的单利获得自己
    override private init() {
        mutableDictionary = [:]
    }
    
    // 添加
    func add(key: String?, value: Any?) -> Void {
        if key == nil || value == nil { return }
        mutableDictionary[key!] = value!
    }
    
    // 移除
    func remove(key: String?) -> Void {
        if key == nil { return }
        mutableDictionary.removeValue(forKey: key!)
    }
    
    // 取值
    func getValue(key: String?) -> Any? {
        if key == nil { return nil }
        return mutableDictionary[key!]
    }
}
