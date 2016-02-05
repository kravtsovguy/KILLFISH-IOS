//
//  APICalls.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 01.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class APICalls: NSObject {
    
    /*static var id: Int!
    static var authtoken: String!
    static var isLogged: Bool! {
        return id != 0 && authtoken != ""
    }*/
    
    
    enum Action:String {
        case UserLogin = "user.login_POST_NO"
        case UserLoginCode = "user.login.code_POST_NO"
        case UserLogout = "user.logout_POST_YES"
        case UserRegistration = "user.registration_POST_NO"
        case UserRegistrationCode = "user.registration.code_POST_NO"
        case UserRegistrationForm = "user.registration.form_POST_NO"
        case News = "news_GET_YES"
        case UserData = "user.data_GET_YES"
        case UserRegistrationSMS = "user.registration.sms_POST_NO"
        case UserReserveList = "user.reserve.list_GET_YES"
        case UserReserveBars = "user.reserve.bars_GET_YES"
        case UserReserveSave = "user.reserve.save_POST_YES"
        case UserReserveCancel = "user.reserve.cancel_POST_YES"
        case RadioCatalog = "radio.catalog_GET_YES"
        case RadioPlaylist = "radio.playlist_GET_YES"
    }
    
    static func login(num:String, code:String,onCompletion: (Bool)->Void, onError: (String)->Void){
        callApi(.UserLogin, parameters: ["num":num,"code":code]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                App.user = User(id: json["id"] as! Int, authtoken: json["auth"] as! String);
                App.user.photo = json["photo"] as! String
                getData({_ in })
            }else{
                onError(json["err"] as! String)
            }
            onCompletion(ok)
            
        }
        
    }
    
    static func remindCode(num:String,onCompletion: (Bool)->Void){
        callApi(.UserLoginCode, parameters: ["num":num]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            onCompletion(ok)
        }
    }
    
    static func getNews(onCompletion: ([NewsInfo])->Void){
        callApi(.News, parameters: ["page":1]) { (json) -> Void in
            var news: [NewsInfo] = []
            let newsD = json["news"] as! [NSDictionary]
            for newsItem in newsD{
                news.append(NewsInfo(json: newsItem))
            }
            onCompletion(news)
        }
    }
    
    /*static func loadNews(newsPre:[NewsInfo], onCompletion: ([NewsInfo])->Void){
        
        getNewsItem(newsItemPre.id) { (ni) -> Void in
            
        }
        
    }
    
    static func loadNewsItem(newsItemPre:NewsInfo, onCompletion: (NewsInfo)->Void){
        
    }
    
    
    static func getNewsPreload(onCompletion: ([NewsInfo])->Void){
        callApi(.News, parameters: ["page":1]) { (json) -> Void in
            var news: [NewsInfo] = []
            let newsD = json["news"] as! [NSDictionary]
            for newsItem in newsD{
                news.append(NewsInfo(json: newsItem))
            }
            onCompletion(news)
        }
    }*/
    
    static func getNewsItem(id:Int,onCompletion: (NewsInfo)->Void){
        callApi(.News, parameters: ["newsid":id]) { (json) -> Void in
            let ni = NewsInfo(json: json)
            onCompletion(ni)
        }
    }
    
    static func getData(onCompletion: (Bool)->Void){
        callApi(.UserData, parameters: NSDictionary()) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                App.user.updateInfo(json)
                App.saveCacheUser()
            }
            onCompletion(ok)
        }
    }
    
    static func registerOne(phone:String, onCompletion: (Int,String,String)->Void, onError:(String)->Void){
        callApi(.UserRegistration, parameters: ["mphone":phone]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                let id = json["id"] as! Int
                let next = json["next"] as! String
                var num = ""
                if let _num = json["num"]{
                    num = _num as! String
                }
                onCompletion(id,next,num)
            }else{
                onError(json["err"] as! String)
            }
            
        }
    }
    
    static func registerTwo(id:Int, code:Int, onCompletion: (Int,String,String)->Void, onError:(String)->Void){
        callApi(.UserRegistrationCode, parameters: ["id":id,"code":code]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                let id = json["id"] as! Int
                let next = json["next"] as! String
                var num = ""
                if let _num = json["num"]{
                    num = _num as! String
                }
                onCompletion(id,next,num)
            }else{
                onError(json["err"] as! String)
            }
            
        }
    }
    
    
    static func registerThree(id:Int, name:String, day:Int, month:Int, year:Int, curr:String, num:Bool, owner: String, onCompletion: (Bool)->Void, onError:(String)->Void){
        let bnum: Int = num ? 1 : 0
        callApi(.UserRegistrationForm, parameters: ["id":id,"name":name,"day":day,"month":month,"year":year,"curr":curr,"num":bnum,"owner":owner]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                App.user = User(id: json["id"] as! Int, authtoken: json["auth"] as! String);
                getData({_ in })
            }else{
                onError(json["err"] as! String)
            }
            onCompletion(ok)
            
        }
    }
    
    static func getBars(onCompletion: ([CityInfo])->Void){
        
        callApi(.UserReserveBars, parameters: NSDictionary()) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                var cities: [CityInfo] = []
                ReserveInfo.initPrices(json)
                let units = json["units"] as! [NSDictionary]
                for unit in units{
                    let cityI = CityInfo(json: unit)
                    let bars = unit["bars"] as! [NSDictionary]
                    for bar in bars{
                        let barI = BarInfo(json: bar)
                        cityI.bars.append(barI)
                    }
                    cities.append(cityI)
                }
                App.cities = cities
                App.saveCacheBars()
                onCompletion(cities)
            }
        }
        
    }
    
    static func getReserves(onCompletion: ([ReserveInfo])->Void){
        
        callApi(.UserReserveList, parameters: NSDictionary()) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                var reserves: [ReserveInfo] = []
                let units = json["units"] as! [NSDictionary]
                for unit in units{
                    let reserveI = ReserveInfo(json: unit)
                    reserves.append(reserveI)
                }
                App.reserves = reserves
                App.saveCacheReserves()
                onCompletion(reserves)
            }
        }
        
    }
    
    static func saveReserve(vip:Bool,barid:Int,dt:Double,num:Int,discr:String, onCompletion: (Int)->Void, onError: (String)->Void){
        let vipI = vip ? 1 : 0
        callApi(.UserReserveSave, parameters: ["vip":vipI,"barid":barid,"dt":dt,"num":num,"opis":discr]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                onCompletion(json["bronid"] as! Int)
            }else{
                onError(json["err"] as! String)
            }
        }
    }
    
    static func cancelReserve(bronid:Int, onCompletion: (Bool)->Void, onError: (String)->Void){
        
        callApi(.UserReserveCancel, parameters: ["bronid":bronid]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                
            }else{
                onError(json["err"] as! String)
            }
            
            onCompletion(ok)
        }
    }
    
    static func getMusic(onCompletion: ([MusicInfo])->Void){
        //max 2027
        callApi(.RadioCatalog, parameters: ["letter":"all","page":1,"num_on_page":2500]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                var music: [MusicInfo] = []
                let units = json["units"] as! [NSDictionary]
                for unit in units{
                    let musicI = MusicInfo(json: unit)
                    music.append(musicI)
                }
                App.music = music
                App.saveCacheMusic()
                onCompletion(music)
            }
        }
        
    }
    
    static func getMusicPlay(onCompletion: ([MusicPlayInfo])->Void){
        //max 2027
        callApi(.RadioPlaylist, parameters: ["stream":"listen3","num":10]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                var music: [MusicPlayInfo] = []
                let units = json["units"] as! [NSDictionary]
                for unit in units{
                    let musicPI = MusicPlayInfo(json: unit)
                    music.append(musicPI)
                }
                App.musicPlay = music
                onCompletion(music)
            }
        }
    }
    
    static func callApi(actionEnum:Action, parameters:NSDictionary, onCompletion: (NSDictionary) -> Void){
        
        let act: String = actionEnum.rawValue
        let action = act.componentsSeparatedByString("_")
        
        var postStr:String = "action=\(action[0])"
        
        if(action[2]=="YES"){
            postStr+="&id=\(App.user.id)"
            postStr+="&authtoken=\(App.user.authtoken)"
        }
        
        for (key, value) in parameters {
            postStr+="&\(key)=\(value)"
        }
        
        var url: String = "https://killfish.ru/app/"
        if action[1]=="GET" {
            url+="?\(postStr)"
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = action[1]
            
        if action[1]=="POST" {
                
            let postString = postStr
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
        }
        //let jsonPost = try NSJSONSerialization.dataWithJSONObject(dict, options: [])
        //request.HTTPBody = jsonPost
        print("KEK")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET or POST")
                print(error)
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            let result: NSDictionary
            do {
                result = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("error parsing response")
                return
            }
            dispatch_async(dispatch_get_main_queue(),{
                onCompletion(result)
            } )
            
            
        }
        task.resume()
        
    }

}
