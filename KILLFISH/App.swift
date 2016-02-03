//
//  App.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 02.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class App{
    static let store = NSUserDefaults.standardUserDefaults()
    static var user = User(id: 0,authtoken: "")
    static var isLogged: Bool! {
        return user.id != 0 && user.authtoken != ""
    }
    
    static func getData(obj:NSCoding)->NSData{
        let data = NSKeyedArchiver.archivedDataWithRootObject(obj)
        return data
    }
    
    static func getObj(data:NSData)->AnyObject?{
        let obj = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        return obj
    }
    
    static func setCacheNews(news:[NewsInfo]){
        store.setObject(getData(news), forKey: "news")
    }
    
    static func getCacheNews()->[NewsInfo]{
        if let data = store.dataForKey("news"){
            let news:[NewsInfo] = getObj(data) as! [NewsInfo]
            return news
        }else{
            return [NewsInfo]()
        }
    }
    
    static func saveCacheUser(){
        store.setObject(getData(user), forKey: "user")
    }
    
    static func loadCacheUser(){
        if let data = store.dataForKey("user"){
            user = getObj(data) as! User
        }else{
            user = User(id: 0, authtoken: "")
        }
    }
    
    static func getCorrectPhone(phone:String)->String{
        if(phone.characters.count == 0) {
            return phone
        }
        var str = Array(phone.characters)
        if str[0]=="+"{
            str.removeAtIndex(0)
        }
        if str[0]=="8"{
            str[0]="7"
        }
        return String(str)
    }
    
}