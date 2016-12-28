//
//  GirlModel.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/27.
//  Copyright © 2016年 zly. All rights reserved.
//
import Foundation


class GirlModel : NSObject, NSCoding{
    
    var count : Int!
    var fcount : Int!
    var galleryclass : Int!
    var id : Int!
    var img : String!
    var rcount : Int!
    var size : Int!
    var time : Int!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        count = dictionary["count"] as? Int
        fcount = dictionary["fcount"] as? Int
        galleryclass = dictionary["galleryclass"] as? Int
        id = dictionary["id"] as? Int
        img = dictionary["img"] as? String
        rcount = dictionary["rcount"] as? Int
        size = dictionary["size"] as? Int
        time = dictionary["time"] as? Int
        title = dictionary["title"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if count != nil{
            dictionary["count"] = count
        }
        if fcount != nil{
            dictionary["fcount"] = fcount
        }
        if galleryclass != nil{
            dictionary["galleryclass"] = galleryclass
        }
        if id != nil{
            dictionary["id"] = id
        }
        if img != nil{
            dictionary["img"] = img
        }
        if rcount != nil{
            dictionary["rcount"] = rcount
        }
        if size != nil{
            dictionary["size"] = size
        }
        if time != nil{
            dictionary["time"] = time
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init?(coder aDecoder: NSCoder)
    {
        count = aDecoder.decodeObject(forKey: "count") as? Int
        fcount = aDecoder.decodeObject(forKey: "fcount") as? Int
        galleryclass = aDecoder.decodeObject(forKey: "galleryclass") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        img = aDecoder.decodeObject(forKey: "img") as? String
        rcount = aDecoder.decodeObject(forKey: "rcount") as? Int
        size = aDecoder.decodeObject(forKey: "size") as? Int
        time = aDecoder.decodeObject(forKey: "time") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    public func encode(with aCoder: NSCoder)
    {
        if count != nil{
            aCoder.encode(count, forKey: "count")
        }
        if fcount != nil{
            aCoder.encode(fcount, forKey: "fcount")
        }
        if galleryclass != nil{
            aCoder.encode(galleryclass, forKey: "galleryclass")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if rcount != nil{
            aCoder.encode(rcount, forKey: "rcount")
        }
        if size != nil{
            aCoder.encode(size, forKey: "size")
        }
        if time != nil{
            aCoder.encode(time, forKey: "time")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        
    }
    
}
