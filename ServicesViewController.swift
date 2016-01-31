//
//  ServicesViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 31.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class ServicesViewController: MasterNavViewController, CarbonTabSwipeNavigationDelegate {

    var items = NSArray()
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = "CarbonKit"
        items = ["Бронирование столов", "Заказ музыки"]
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insertIntoRootViewController(self)
        
        self.style()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func style() {
        carbonTabSwipeNavigation.setDefaultStyle();
        //let color: UIColor = UIColor(red: 24.0 / 255, green: 75.0 / 255, blue: 152.0 / 255, alpha: 1)
        //self.navigationController!.navigationBar.translucent = false
        //self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        //self.navigationController!.navigationBar.barTintColor = color
        //self.navigationController!.navigationBar.barStyle = .BlackTranslucent
        
        //carbonTabSwipeNavigation.setTabExtraWidth(30)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width/2, forSegmentAtIndex: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width/2, forSegmentAtIndex: 1)
        
        //carbonTabSwipeNavigation.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        
        /*let bgImageColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        carbonTabSwipeNavigation.toolbar.setBackgroundImage(UIImage.initFromColor(bgImageColor),
            forToolbarPosition: UIBarPosition.Any,
            barMetrics: UIBarMetrics.Default)
        carbonTabSwipeNavigation.toolbar.setShadowImage(UIImage(),forToolbarPosition: UIBarPosition.Any)
        carbonTabSwipeNavigation.toolbar.translucent = true*/
        
        //carbonTabSwipeNavigation.toolbar.backgroundColor = UIColor.clearColor()
        //carbonTabSwipeNavigation.toolbar.barStyle = UIBarStyle.Default
        
        
        //carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.redColor().colorWithAlphaComponent(0.2)
        
        /*
        carbonTabSwipeNavigation.setIndicatorColor(UIColor.yellowColor().colorWithAlphaComponent(1))
        
        carbonTabSwipeNavigation.setNormalColor(UIColor.whiteColor().colorWithAlphaComponent(0.8), font: UIFont(name: "Roboto-Light", size: 13)!)
        carbonTabSwipeNavigation.setSelectedColor(UIColor.whiteColor().colorWithAlphaComponent(0.8), font: UIFont(name: "Roboto-Light", size: 13)!)
*/
        
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        
        switch index {
        case 0:
            return self.storyboard!.instantiateViewControllerWithIdentifier("test")
        default:
            return self.storyboard!.instantiateViewControllerWithIdentifier("test")
        }
        
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAtIndex index: UInt) {
        NSLog("Did move at index: %ld", index)
    }
    
    func onePixelImageWithColor(color : UIColor) -> UIImage {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue
        let context = CGBitmapContextCreate(nil, 1, 1, 8, 0, colorSpace, bitmapInfo)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, CGRectMake(0, 0, 1, 1))
        let image = UIImage(CGImage: CGBitmapContextCreateImage(context)!)
        return image
    }


}
