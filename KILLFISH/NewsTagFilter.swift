//
//  NewsTagFilter.swift
//  KillClass
//
//  Created by Alexander Ponomarev on 01.02.16.
//  Copyright © 2016 Alexander Ponomarev. All rights reserved.
//

import Foundation

class NewsTagFilter
{
    enum Filter: Int{
        case Birth = 0
        case Card
        case Drink
        case Food
        case Other
    }
    
    static func identifyTopicOfText(var text: NSString) -> Filter {
        do{
            var counts : [Int] = [0, 0, 0, 0, 1]
            let data = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("SuperAlgorythm", ofType: "json")!)!
            let wordBase = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:[String]]
            var result : NSRange
            for key in wordBase.keys {
                for word in wordBase[key]! {
                    repeat {
                        result = text.rangeOfString(word, options : NSStringCompareOptions.CaseInsensitiveSearch)
                        if result.location != NSNotFound {
                            text = text.stringByReplacingCharactersInRange(result, withString: "")
                            counts[Int(key)!]++
                        }
                    } while result.location != NSNotFound
                }
            }
            
            
            //Повышенный коэф для слов Праздника
            counts[0] *= 3
            
            //Повышенный коэф для Остальных слов
            if counts[4] != 1
            {
                counts[4] *= 3
            }
            
            return Filter.init(rawValue: counts.indexOf(counts.maxElement()!)!)!
        }catch{
            return Filter.Other
        }
    }
    
}