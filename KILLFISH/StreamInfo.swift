//
//  StreamInfo.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 09.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation

class StreamInfo{
    
    var fullstream: String = ""
    var stream: String = ""
    var comm: String = ""
    
    
    init(json: NSDictionary){
        self.fullstream = json["fullstream"] as! String
        self.stream = json["stream"] as! String
        self.comm = json["comm"] as! String
    }
    
}