//
//  BarInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 04.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class BarInfo: NSObject, NSCoding{
    
    var id: Int = 0
    var name: String = ""
    var start: Int = 0
    var end: Int = 0
    
    init(json: NSDictionary){
        self.id = json["barid"] as! Int
        self.name = json["bar"] as! String
        self.start = json["start"] as! Int
        self.end = json["end"] as! Int
    }
    
    required init(coder decoder: NSCoder) {
        
        self.id = decoder.decodeIntegerForKey("id")
        self.name = decoder.decodeObjectForKey("name") as! String
        self.start = decoder.decodeIntegerForKey("start")
        self.end = decoder.decodeIntegerForKey("end")
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeInteger(self.start, forKey: "start")
        coder.encodeInteger(self.end, forKey: "end")
    }
}