//
//	Rating.swift
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation


class Rating : NSObject, NSCoding{
    
    var average : String!
    var max : Int!
    var min : Int!
    var numRaters : Int!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        average = dictionary["average"] as? String
        max = dictionary["max"] as? Int
        min = dictionary["min"] as? Int
        numRaters = dictionary["numRaters"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if average != nil{
            dictionary["average"] = average
        }
        if max != nil{
            dictionary["max"] = max
        }
        if min != nil{
            dictionary["min"] = min
        }
        if numRaters != nil{
            dictionary["numRaters"] = numRaters
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    public required init?(coder aDecoder: NSCoder) {
        average = aDecoder.decodeObject(forKey: "average") as? String
        max = aDecoder.decodeObject(forKey: "max") as? Int
        min = aDecoder.decodeObject(forKey: "min") as? Int
        numRaters = aDecoder.decodeObject(forKey: "numRaters") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    public func encode(with aCoder: NSCoder) {
        if average != nil{
            aCoder.encode(average, forKey: "average")
        }
        if max != nil{
            aCoder.encode(max, forKey: "max")
        }
        if min != nil{
            aCoder.encode(min, forKey: "min")
        }
        if numRaters != nil{
            aCoder.encode(numRaters, forKey: "numRaters")
        }
        
    }
    
}
