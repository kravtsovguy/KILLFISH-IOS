//
//  MusicInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 05.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class MusicInfo: NSObject, NSCoding{
    
    var id: Int = 0
    var artist: String = ""
    var title: String = ""
    var length: Int = 0
    var lastBuy: Double = 0
    
    init(json: NSDictionary){
        if let item = json["idsong"]{
            self.id = item as! Int
        }
        self.artist = json["artist"] as! String
        self.title = json["title"] as! String
        self.length = json["length"] as! Int
    }
    
    required init(coder decoder: NSCoder) {
        
        self.id = decoder.decodeIntegerForKey("id")
        self.artist = decoder.decodeObjectForKey("artist") as! String
        self.title = decoder.decodeObjectForKey("title") as! String
        self.length = decoder.decodeIntegerForKey("length")
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.artist, forKey: "artist")
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeInteger(self.length, forKey: "length")
    }
    
    
}