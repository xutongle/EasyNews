//
//	Image.swift
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation


class Image : NSObject, NSCoding{
    
    var large : String!
    var medium : String!
    var small : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        large = dictionary["large"] as? String
        medium = dictionary["medium"] as? String
        small = dictionary["small"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if large != nil{
            dictionary["large"] = large
        }
        if medium != nil{
            dictionary["medium"] = medium
        }
        if small != nil{
            dictionary["small"] = small
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    public func encode(with aCoder: NSCoder) {
        if large != nil{
            aCoder.encode(large, forKey: "large")
        }
        if medium != nil{
            aCoder.encode(medium, forKey: "medium")
        }
        if small != nil{
            aCoder.encode(small, forKey: "small")
        }
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    public required init?(coder aDecoder: NSCoder) {
        
        large = aDecoder.decodeObject(forKey: "large") as? String
        medium = aDecoder.decodeObject(forKey: "medium") as? String
        small = aDecoder.decodeObject(forKey: "small") as? String
    }
    
}
