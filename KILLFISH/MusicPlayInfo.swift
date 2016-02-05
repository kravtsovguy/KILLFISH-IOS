//
//  MusicPlayInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 05.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class MusicPlayInfo{
    
    var music: MusicInfo!
    var dateUnix: Double = 0
    
    var date:NSDate{
        return NSDate(timeIntervalSince1970: dateUnix)
    }
    var timeHM:String{
        let f = NSDateFormatter()
        f.dateFormat = "hh:mm"
        return f.stringFromDate(date)
    }
    
    init(json: NSDictionary){
        self.music = MusicInfo(json: json)
        self.dateUnix = json["dt"] as! Double
    }
    
}
