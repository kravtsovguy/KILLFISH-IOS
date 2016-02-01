//
//  NewsInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 01.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NewsInfo: NSObject {
    
    var title:String = "";
    var text:String="";
    var date:NSDate=NSDate();
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
    
    init(title:String,dateUnix:Double,text:String )
    {
        self.title=title;
        
        self.date=NSDate(timeIntervalSince1970: dateUnix);
        
        self.text=text;
    }

}