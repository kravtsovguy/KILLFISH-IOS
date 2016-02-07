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
    
    static var servicesView: ServicesViewController!
    static var paymentsView: PaymentsViewController!
    
    static var currency = ["RUR":"₽","BYR":"BYR","KZT":"₸"]
    static var curr: String {
        return currency[user.curr]!
    }
    
    static var cities: [CityInfo] = []
    static var reserves: [ReserveInfo] = []
    static var news: [NewsInfo] = []
    static var music: [MusicInfo] = []
    static var musicPlay: [MusicPlayInfo] = []
    static var payments: [PaymentInfo] = []
    
    static func getData(obj:NSCoding)->NSData{
        let data = NSKeyedArchiver.archivedDataWithRootObject(obj)
        return data
    }
    
    static func getObj(data:NSData)->AnyObject?{
        let obj = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        return obj
    }
    
    static func setCacheNews(news:[NewsInfo]){
        self.news = news
        store.setObject(getData(news), forKey: "news")
    }
    
    static func getCacheNews()->[NewsInfo]{
        if let data = store.dataForKey("news"){
            let news:[NewsInfo] = getObj(data) as! [NewsInfo]
            self.news = news
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
    
    static func saveCacheReserves(){
        store.setObject(getData(reserves), forKey: "reserves")
    }
    
    static func loadCacheReserves(){
        if let data = store.dataForKey("reserves"){
            reserves = getObj(data) as! [ReserveInfo]
        }
    }
    
    static func saveCacheBars(){
        
        store.setObject(getData(ReserveInfo.kNormal), forKey: "kNormal")
        store.setObject(getData(ReserveInfo.kVIP), forKey: "kVIP")
        
        store.setObject(getData(ReserveInfo.priceNormal), forKey: "priceNormal")
        store.setObject(getData(ReserveInfo.priceVIP), forKey: "priceVIP")
        
        store.setObject(getData(cities), forKey: "cities")
    }
    
    
    static func loadCacheBars(){
        
        if let data = store.dataForKey("kNormal"){
            ReserveInfo.kNormal = getObj(data) as! Int
        }
        
        if let data = store.dataForKey("kVIP"){
            ReserveInfo.kVIP = getObj(data) as! Int
        }
        
        if let data = store.dataForKey("priceNormal"){
            ReserveInfo.priceNormal = getObj(data) as! Int
        }

        if let data = store.dataForKey("priceVIP"){
            ReserveInfo.priceVIP = getObj(data) as! Int
        }
        
        if let data = store.dataForKey("cities"){
            cities = getObj(data) as! [CityInfo]
        }
    }
    
    static func saveCacheMusic(){
        store.setObject(getData(music), forKey: "music")
    }
    
    static func loadCacheMusic(){
        if let data = store.dataForKey("music"){
            music = getObj(data) as! [MusicInfo]
        }
    }
    
    static func saveCachePayments(){
        store.setObject(getData(payments), forKey: "payments")
    }
    
    static func loadCachePayments(){
        if let data = store.dataForKey("payments"){
            payments = getObj(data) as! [PaymentInfo]
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
    
    /*static func getCorrectFIO(phone:String)->String{
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
    }*/
    
}