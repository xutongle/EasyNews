//
//  GirlTypeModel.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/27.
//  Copyright © 2016年 zly. All rights reserved.
//


import Foundation

class GirlTypeModel : NSObject, NSCoding {
    
    var descriptionField : String!
    var id : Int!
    var keywords : String!
    var name : String!
    var seq : Int!
    var title : String!
    
    init(keywords: String) {
        self.keywords = keywords
    }
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        keywords = dictionary["keywords"] as? String
        name = dictionary["name"] as? String
        seq = dictionary["seq"] as? Int
        title = dictionary["title"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if keywords != nil{
            dictionary["keywords"] = keywords
        }
        if name != nil{
            dictionary["name"] = name
        }
        if seq != nil{
            dictionary["seq"] = seq
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
    public required init?(coder aDecoder: NSCoder)
    {
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        keywords = aDecoder.decodeObject(forKey: "keywords") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        seq = aDecoder.decodeObject(forKey: "seq") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    public func encode(with aCoder: NSCoder)
    {
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if keywords != nil{
            aCoder.encode(keywords, forKey: "keywords")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if seq != nil{
            aCoder.encode(seq, forKey: "seq")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        
    }
    
}
