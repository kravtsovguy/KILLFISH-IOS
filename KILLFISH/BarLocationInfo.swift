//
//  BarLocationInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 09.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class BarLocationInfo {
    
    var id: Int = 0
    var name: String = ""
    var lat: Double = 0
    var lon: Double = 0
    var distance: Double = 0
    var time: String = ""
    var start: Int = 0
    var end: Int = 0
    var diff: Int = 0
    
    init(json: NSDictionary){
        self.id = json["id"] as! Int
        self.name = json["title"] as! String
        self.lat = json["lat"] as! Double
        self.lon = json["lon"] as! Double
        self.distance = json["distance"] as! Double
        self.time = json["time"] as! String
        self.start = Int(json["start"] as! String)!
        self.end = Int(json["end"] as! String)!
        self.diff = json["diff"] as! Int
    }
    
    /*
    required init(coder decoder: NSCoder) {
        
        self.id = decoder.decodeIntegerForKey("id")
        self.name = decoder.decodeObjectForKey("name") as! String
        self.lat = decoder.decodeDoubleForKey("lat")
        self.lon = decoder.decodeDoubleForKey("lon")
        self.distance = decoder.decodeDoubleForKey("distance")
        self.time = decoder.decodeObjectForKey("time") as! String
        self.start = decoder.decodeIntegerForKey("start")
        self.end = decoder.decodeIntegerForKey("end")
        self.diff = decoder.decodeIntegerForKey("diff")
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeDouble(self.lat, forKey: "lat")
        coder.encodeDouble(self.lon, forKey: "lon")
        coder.encodeDouble(self.distance, forKey: "distance")
        coder.encodeObject(self.time, forKey: "time")
        coder.encodeInteger(self.start, forKey: "start")
        coder.encodeInteger(self.end, forKey: "end")
        coder.encodeInteger(self.diff, forKey: "diff")
    }
*/
    
}