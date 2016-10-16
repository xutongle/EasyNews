//
//  ZLY_NetWorking.swift
//  ZLY_NetWoring
//
//  Created by mac_zly on 2016/9/29.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class ZLY_NetWorking: NSObject {

    
    /// HTTP GET 请求
    ///
    /// - parameter url:                 url
    /// - parameter parameter:           参数
    /// - parameter serializationOption: 序列化
    /// - parameter Complete:            完成的回调
    /// - parameter Fail:                失败的回调
    static func GET(url: String, parameter: [String:Any]?, serializationOption: JSONSerialization.ReadingOptions, Complete: ((_ data: Any) -> Void)?, Fail: @escaping ((_ errorString: String)->Void)) -> Void {
        if let requestUrl = URL(string: url) {
            let request = URLRequest(url: requestUrl)
            let session = URLSession.shared
            //
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if (error != nil || data == nil) {  Fail("has error or no data") }else {
                    // 异常捕获
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data!, options: serializationOption)
                        if Complete != nil { Complete!(jsonDict) }
                    }catch {
                        Fail(error.localizedDescription)
                    }
                }
            })
            // 开始访问网络
            dataTask.resume()
        }else {
            Fail("request url error")
        }
    }
    
    
    /// Post方法
    ///
    /// - parameter url:                 url
    /// - parameter parameter:           post的参数 比如username=zly&password=zly123go
    /// - parameter serializationOption: 返回结果序列化选项
    /// - parameter requestComplete:     成功回调
    /// - parameter requestFail:         失败回调
    static func POST(url: String, parameter: String?, serializationOption: JSONSerialization.ReadingOptions, Complete: ((_ data: Any) -> Void)?, Fail: @escaping ((_ errorString: String)->Void)) -> Void {
        if let requestUrl = URL(string: url) {
            let session = URLSession.shared
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            if parameter != nil {
                request.httpBody = parameter!.data(using: String.Encoding.utf8)
            }
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if (error != nil || data == nil) { Fail("has error or no data") }else {
                    // 异常捕获
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data!, options: serializationOption)
                        if Complete != nil { Complete!(jsonDict) }
                    }catch {
                        Fail(error.localizedDescription)
                    }
                }
            })
            dataTask.resume()
        }else{
            Fail("request url error")
        }
    }
    
    // 上传图片
    static func upload(url: String, data: Data, parameter: String?, serializationOption: JSONSerialization.ReadingOptions, Complete: ((_ data: Any) -> Void)?, Fail: @escaping ((_ errorString: String)->Void)) -> Void {
        if let requestUrl = URL(string: url) {
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            if parameter != nil {
                request.httpBody = parameter!.data(using: String.Encoding.utf8)
            }
            // 缓存
            request.cachePolicy = .reloadIgnoringCacheData
            let session = URLSession.shared
            let uploadTask = session.uploadTask(with: request, from: data, completionHandler: { (data, response, error) in
                if error == nil {
                    print("=In=")
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data!, options: serializationOption)
                        if Complete != nil { Complete!(jsonDict) }
                    }catch {
                        Fail(error.localizedDescription)
                    }
                }
            })
            uploadTask.resume()
        }else{
            Fail("request url error")
        }
    }
}
