//
//  CityInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 04.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class CityInfo: NSObject, NSCoding {
    
    var id: Int = 0
    var name: String = ""
    var diff:Int = 0
    var bars: [BarInfo] = []
    
    init(json: NSDictionary){
        self.id = json["cityid"] as! Int
        self.name = json["city"] as! String
        self.diff = json["diff"] as! Int
    }
    
    required init(coder decoder: NSCoder) {
        
        self.id = decoder.decodeIntegerForKey("id")
        self.name = decoder.decodeObjectForKey("name") as! String
        self.diff = decoder.decodeIntegerForKey("diff")
        self.bars = decoder.decodeObjectForKey("bars") as! [BarInfo]
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeInteger(self.diff, forKey: "diff")
        coder.encodeObject(self.bars, forKey: "bars")
    }
    
}