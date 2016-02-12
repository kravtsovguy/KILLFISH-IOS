//
//  NewsInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 01.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NewsInfo: NSObject, NSCoding {
    
    var id:Int=0
    var title:String = ""
    var text:String=""
    var dateUnix:Double=0
    var date:NSDate{
        return NSDate(timeIntervalSince1970: dateUnix)
    }
    var ico: UIImage{
        let f = NewsTagFilter.identifyTopicOfText(textPage)
        var str = "Star"
        switch f{
        case .Birth:
            str = "Present"
            break
        case .Card:
            str = "Card"
            break
        case .Drink:
            str = "Wine"
            break
        case .Food:
            str = "Food"
            break
        case .Other:
            str = "Star"
            break
        }
        return UIImage(named: str)!
    }
    var dayAndMonth:String{
        /*//Here I’m creating the calendar instance that we will operate with:
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        //Now asking the calendar what day are we in today’s date:
        let currentDayInt = (calendar?.component(NSCalendarUnit.Day, fromDate: NSDate()))!
        
        //Now asking the calendar what month are we in today’s date:
        let currentMonthInt = (calendar?.component(NSCalendarUnit.Month, fromDate: NSDate()))!
        
        
        //Now asking the calendar what year are we in today’s date:
        //let currentYearInt = (calendar?.component(NSCalendarUnit.Year, fromDate: NSDate()))!*/
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM"
        
        return f.stringFromDate(date)
    }
    
    var dayAndMonthAndYear:String{
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        return f.stringFromDate(date)
    }
    
    var imageUrl:String{
        get{
            var imgUrl = "http://killfish.ru"
            let r = text.rangeOfString("src=\"")
            if r==nil{
                return "http://placehold.it/350x150"
            }
            for var i=r!.endIndex; i<=text.endIndex; i = i.advancedBy(1)
            {
                if(text[i]=="\""){
                    break
                }
                imgUrl+=String(text[i])
            }
            return imgUrl
        }
    }
    
    var textPage:String{
        get{
        //return text.stringByReplacingOccurrencesOfString("\"/", withString: "\"http://killfish.ru/")
        var result = ""
        var can = true
        let str = text.stringByReplacingOccurrencesOfString("<br>", withString: "\n")
        for ch in str.characters{
            if(ch=="<"){
                can=false
            }
            
            if(can){
                result+=String(ch)
            }
            
            if(ch==">"){
                can=true
            }
        }
        return result
        }
    }
    
    
    
    convenience init(json:NSDictionary){
        self.init(title: json["title"] as! String, dateUnix: json["dt"] as! Double)
        
        if (json.objectForKey("text") != nil){
            self.text = json["text"] as! String
        }
        if (json.objectForKey("id") != nil){
            self.id = json["id"] as! Int
        }
    }
    
    init(title:String,dateUnix:Double){
        self.title=title;
        
        self.dateUnix = dateUnix;
    }
    
    convenience init(title:String,dateUnix:Double,text:String )
    {
        self.init(title: title,dateUnix: dateUnix)
        
        self.text=text
        
    }
    
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObjectForKey("title") as! String
        self.text = decoder.decodeObjectForKey("text")as! String
        self.id = decoder.decodeIntegerForKey("id")
        self.dateUnix = decoder.decodeDoubleForKey("dateUnix")
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeObject(self.text, forKey: "text")
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeDouble(self.dateUnix, forKey: "dateUnix")
    }

}
