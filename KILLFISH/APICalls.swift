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
    
    
    enum Action:String {
        case UserLogin = "user.login_POST"
        case UserLoginCode = "user.login.code_POST"
        case UserLogout = "user.logout_POST"
        case UserRegistration = "user.registration_POST"
        case UserRegistrationCode = "user.registration.code_POST"
        case UserRegistrationForm = "user.registration.form_POST"
        case News = "news_GET"
        case UserData = "user.data_GET"
    }
    
    func callApi(action:Action, post:NSDictionary, onCompletion: (NSDictionary) -> Void)->Void{
        
        
        
        do{
                    
        let request = NSMutableURLRequest(URL: NSURL(string: "https://killfish.ru/app/")!)
        request.HTTPMethod = "POST"
        //let postString = "code=55554&num=7777777&action=user.login"
        //request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let jsonPost = try NSJSONSerialization.dataWithJSONObject(post, options: [])
        request.HTTPBody = jsonPost
        
        //let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //let session = NSURLSession(configuration: config)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            /*guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }*/
            
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
            
        }catch{
        }
        
        /*let url : String = "http://killfish.ru/api?action=news&num=79999696599&code=11111"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{  (response, data, error) in
        
        do{
        let jsonResult: NSDictionary! = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
        
        
        if (jsonResult != nil) {
        self.title = "\(jsonResult.count)"
        // process jsonResult
        } else {
        // couldn't load JSON, look at error
        }
        
        }catch{
        }
        })*/
        
    }

}
