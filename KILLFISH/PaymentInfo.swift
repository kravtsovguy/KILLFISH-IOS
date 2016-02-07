//
//  PaymentInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 06.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class PaymentInfo: NSObject, NSCoding{
    
    var id: Int = 0
    var type: String = ""
    var dateUnix: Double = 0
    var sum: Int = 0
    var curr: String = ""
    var discr: String = ""
    var check: [CheckInfo] = []
    
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
    
    init(type:String, dateUnix:Double, sum: Int, curr: String){
        self.type = type
        self.dateUnix = dateUnix
        self.sum = sum
        self.curr = curr
    }
    
    
    init(json: NSDictionary){
        self.id = json["checkid"] as! Int
        self.type = json["type"] as! String
        self.dateUnix = json["dt"] as! Double
        self.sum = json["sum"] as! Int
        self.curr = json["curr"] as! String
        self.discr = json["opis"] as! String
    }
    
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeIntegerForKey("id")
        self.type = decoder.decodeObjectForKey("type") as! String
        self.dateUnix = decoder.decodeDoubleForKey("dateUnix")
        self.sum = decoder.decodeIntegerForKey("sum")
        self.curr = decoder.decodeObjectForKey("curr") as! String
        self.discr = decoder.decodeObjectForKey("discr") as! String
        self.check = decoder.decodeObjectForKey("check") as! [CheckInfo]
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.type, forKey: "type")
        coder.encodeDouble(self.dateUnix, forKey: "dateUnix")
        coder.encodeInteger(self.sum, forKey: "sum")
        coder.encodeObject(self.curr, forKey: "curr")
        coder.encodeObject(self.discr, forKey: "discr")
        coder.encodeObject(self.check, forKey: "check")
    }
    
}