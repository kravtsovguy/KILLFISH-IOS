//
//  BarAnnotation.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 09.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation
import MapKit

class BarAnnotation:NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var diff: Int?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
}
