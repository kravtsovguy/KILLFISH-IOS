//
//  ReserveInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 04.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class ReserveInfo: NSObject, NSCoding{
    
    var id: Int = 0
    var bar: String = ""
    var dateUnix:Double=0
    var count: Int = 0
    var sum: Int = 0
    var status: Int = 0
    var cancelable: Bool = true
    
    static var priceVIP: Int = 0
    static var priceNormal: Int = 0
    
    static var kVIP: Int = 0
    static var kNormal: Int = 0
    
    
    var date:NSDate{
        return NSDate(timeIntervalSince1970: dateUnix)
    }
    var dayAndMonth:String{
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM"
        
        return f.stringFromDate(date)
    }
    
    var dayAndMonthAndYear:String{
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        return f.stringFromDate(date)
    }
    
    var timeHM:String{
        let f = NSDateFormatter()
        f.dateFormat = "HH:mm"
        return f.stringFromDate(date)
    }
    
    static func initPrices(json: NSDictionary){
        let pricelist = json["pricelist"] as! [NSDictionary]
        for pl in pricelist{
            if let vip = pl["vip"]{
                if (vip as! Int) == 0{
                    priceNormal = pl["price"] as! Int
                    kNormal = pl["kratnost"] as! Int
                }else{
                    priceVIP = pl["price"] as! Int
                    kVIP = pl["kratnost"] as! Int
                }
                
            }
        }
    }
    
    init(json: NSDictionary)
    {
        self.id = json["bronid"] as! Int
        self.bar = json["bar"] as! String
        self.dateUnix = json["dt"] as! Double
        self.count = json["num"] as! Int
        self.sum = json["sum"] as! Int
        self.status = json["status"] as! Int
        self.cancelable = json["cancel"] as! Bool
    }
    
    init(bar:String,dateUnix:Double,count:Int )
    {
        self.bar=bar
        self.dateUnix = dateUnix
        self.count = count
    }
    
    required init(coder decoder: NSCoder) {
        
        self.id = decoder.decodeIntegerForKey("id")
        self.bar = decoder.decodeObjectForKey("bar") as! String
        self.dateUnix = decoder.decodeDoubleForKey("dateUnix")
        self.count = decoder.decodeIntegerForKey("count")
        self.sum = decoder.decodeIntegerForKey("sum")
        self.status = decoder.decodeIntegerForKey("status")
        self.cancelable = decoder.decodeBoolForKey("cancelable")
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.bar, forKey: "bar")
        coder.encodeDouble(self.dateUnix, forKey: "dateUnix")
        coder.encodeInteger(self.count, forKey: "count")
        coder.encodeInteger(self.sum, forKey: "sum")
        coder.encodeInteger(self.status, forKey: "status")
        coder.encodeBool(self.cancelable, forKey: "cancelable")
    }
    
    
}
