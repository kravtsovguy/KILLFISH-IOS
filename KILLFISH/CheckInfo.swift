//
//  CheckInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 06.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class CheckInfo:NSObject, NSCoding {
    
    var title: String = ""
    var num: Int = 0
    var price: Int = 0
    
    
    init(json: NSDictionary){
        self.title = json["title"] as! String
        self.num = json["num"] as! Int
        self.price = json["price"] as! Int
    }
    
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObjectForKey("title") as! String
        self.num = decoder.decodeIntegerForKey("num")
        self.price = decoder.decodeIntegerForKey("price")
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeInteger(self.num, forKey: "num")
        coder.encodeInteger(self.price, forKey: "price")
    }
    
}