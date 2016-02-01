//
//  APICalls.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 01.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class APICalls: NSObject {
    
    static var id: Int!
    static var authtoken: String!
    static var isLogged: Bool! {
        return id != 0 && authtoken != ""
    }
    
    
    enum Action:String {
        case UserLogin = "user.login_POST_NO"
        case UserLoginCode = "user.login.code_POST_NO"
        case UserLogout = "user.logout_POST_YES"
        case UserRegistration = "user.registration_POST_NO"
        case UserRegistrationCode = "user.registration.code_POST_NO"
        case UserRegistrationForm = "user.registration.form_POST_NO"
        case News = "news_GET_NO"
        case UserData = "user.data_GET_YES"
    }
    
    static func Login(num:String, code:String,onCompletion: (Bool)->Void){
        callApi(.UserLogin, parameters: ["num":num,"code":code]) { (json) -> Void in
            let ok = json["ok"] as! Bool
            if ok {
                id = json["id"] as! Int
                authtoken = json["auth"] as! String
            }
            onCompletion(ok)
            
        }
        
    }
    
    static func RemindCode(num:String,onCompletion: (Bool)->Void){
        callApi(.UserLoginCode, parameters: ["num":num]) { (json) -> Void in
            onCompletion(json["ok"] as! Bool)
        }
    }
    
    static func getNews(onCompletion: (Bool)->Void){
        callApi(.News, parameters: ["page":1]) { (json) -> Void in
            onCompletion(json["ok"] as! Bool)
        }
    }
    
    static func getData(onCompletion: (Bool)->Void){
        callApi(.UserData, parameters: NSDictionary()) { (json) -> Void in
            onCompletion(json["ok"] as! Bool)
        }
    }
    
    
    static func callApi(actionEnum:Action, parameters:NSDictionary, onCompletion: (NSDictionary) -> Void){
        
        //post = ["num": "7777777", "code": "55555"]
        
        let act: String = actionEnum.rawValue
        let action = act.componentsSeparatedByString("_")
        
        //let dict = NSMutableDictionary(dictionary: parameters)
        //dict["action"]=action[0]
        //var dict: Dictionary<String,String> = parameters as! Dictionary<String, String>
        //parameters["action"] = action[0]
        
        var postStr:String = "action=\(action[0])"
        
        if(action[2]=="YES"){
            postStr+="&id=\(id)"
            postStr+="&authtoken=\(authtoken)"
        }
        
        for (key, value) in parameters {
            postStr+="&\(key)=\(value)"
        }
        
        var url: String = "https://killfish.ru/app/"
        if(action[1]=="GET"){
            url+="?\(postStr)"
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = action[1]//"POST"
            
        if action[1]=="POST"{
                
            let postString = postStr//"code=89295&num=79136653903&action=user.login"
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
                print("error calling GET on /posts/1")
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
                //result = ["ok":"false"]
                print("error parsing response from POST on /posts")
                return
            }
            
            onCompletion(result)
            
        }
        task.resume()
        
    }

}