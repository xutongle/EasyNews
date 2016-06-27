//
//  SingleManager.swift
//  EasyWheater
//
//  Created by zly.private on 16/6/24.
//  Copyright © 2016年 private. All rights reserved.
//

import UIKit

class SingleManager: NSObject {
    
    private var mutableDictionary:NSMutableDictionary!
    
    // 私有化
    override private init() {
        mutableDictionary = NSMutableDictionary()
    }
    
    // swift单利
    static let singleManager = SingleManager()
    
    // 添加
    func add(Key key: String?, andValue value: AnyObject?) -> Void {
        if key == nil || value == nil {
            return
        }
        mutableDictionary.addEntriesFromDictionary(NSMutableDictionary.init(object: value!, forKey: key!) as [NSObject : AnyObject])
    }
    
    // 移除
    func remove(Key key: String?) -> Void {
        mutableDictionary.removeObjectForKey(key!)
    }
    
    // 获取
    func getValue(Key key: String?) -> AnyObject {
        if (mutableDictionary.objectForKey(key!) != nil) {
            let value = mutableDictionary.objectForKey(key!)!
            return value
        }else {
            return false
        }
    }
}
