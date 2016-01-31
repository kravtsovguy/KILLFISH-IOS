//
//  TabNavExt.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 31.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

extension CarbonTabSwipeNavigation {

    func setDefaultStyle()
    {
        setIndicatorColor(UIColor.yellowColor().colorWithAlphaComponent(1))
        
        setNormalColor(UIColor.whiteColor().colorWithAlphaComponent(0.8), font: UIFont(name: "Roboto-Light", size: 13)!)
        setSelectedColor(UIColor.whiteColor().colorWithAlphaComponent(0.8), font: UIFont(name: "Roboto-Light", size: 13)!)
    }

}
