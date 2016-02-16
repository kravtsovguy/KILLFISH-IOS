//
//  User.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 02.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding{
    
 
    var id: Int = 0
    var authtoken: String = ""
    
    var balance: Int = 0
    var name: String = ""
    var phone: String = ""
    var card: String = ""
    var card_type: Int = 0
    var curr:String = "RUR"
    var photo:String = ""
    var percent: [Int] = [Int](count: 3, repeatedValue: 0)
    var lastBarId: Int = 0
    
    init(id:Int, authtoken:String){
        self.id = id
        self.authtoken = authtoken
    }
    
    func updateInfo(json:NSDictionary){
        /*if let _fio = json["fio"]{
            name = _fio as! String
        }*/
        name = json["fio"] as! String
        phone = json["mphone"] as! String
        card = json["num"] as! String
        curr = json["curr"] as! String
        if json["balance"]?.count>0{
            balance = json["balance"]![0]["sum"] as! Int
        }
        card_type = Int(json["card_type"] as! String)!
        percent[0] = Int(json["procent"]!["1"] as! String)!
        percent[1] = Int(json["procent"]!["2"] as! String)!
        percent[2] = Int(json["procent"]!["3"] as! String)!
        lastBarId = json["lastbar_id"] as! Int
    }
    
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeIntegerForKey("id")
        self.authtoken = decoder.decodeObjectForKey("authtoken") as! String
        self.name = decoder.decodeObjectForKey("name")as! String
        self.balance = decoder.decodeIntegerForKey("balance")
        self.phone = decoder.decodeObjectForKey("phone") as! String
        self.card = decoder.decodeObjectForKey("card") as! String
        self.card_type = decoder.decodeIntegerForKey("card_type")
        self.curr = decoder.decodeObjectForKey("curr")as! String
        if let obj = decoder.decodeObjectForKey("photo") {
            self.photo = obj as! String
        }
        if let obj = decoder.decodeObjectForKey("percent") {
            self.percent = obj as! [Int]
        }
        if let obj = decoder.decodeObjectForKey("lastBarId") {
            self.lastBarId = obj as! Int
        }
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.authtoken, forKey: "authtoken")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeInteger(self.balance, forKey: "balance")
        coder.encodeObject(self.phone, forKey: "phone")
        coder.encodeObject(self.card, forKey: "card")
        coder.encodeInteger(self.card_type, forKey: "card_type")
        coder.encodeObject(self.curr, forKey: "curr")
        coder.encodeObject(self.photo, forKey: "photo")
        coder.encodeObject(self.percent, forKey: "percent")
        coder.encodeInteger(self.lastBarId, forKey: "lastBarId")
    }
    
}