//
//  FriendInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 08.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class FriendInfo: NSObject, NSCoding{
    
    
    var id: Int = 0
    var name: String = ""
    var num: Int = 0
    var type: String = ""
    
    override init(){
        
    }
    
    init(json: NSDictionary){
        self.id = json["id"] as! Int
        self.name = json["fio"] as! String
        self.num = json["num"] as! Int
        self.type = json["type"] as! String
    }
    
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeIntegerForKey("id")
        self.name = decoder.decodeObjectForKey("name") as! String
        self.num = decoder.decodeIntegerForKey("num")
        self.type = decoder.decodeObjectForKey("type") as! String
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeInteger(self.num, forKey: "num")
        coder.encodeObject(self.type, forKey: "type")
    }
    
}