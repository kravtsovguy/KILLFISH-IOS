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
        
        App.servicesView = self
        
        items = ["Бронирование столов", "Заказ музыки"]
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insertIntoRootViewController(self)
        
        carbonTabSwipeNavigation.setDefaultStyle();
        
        self.style()
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func style() {
        
        //carbonTabSwipeNavigation.setTabExtraWidth(30)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width/2, forSegmentAtIndex: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width/2, forSegmentAtIndex: 1)
        
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        
        switch index {
        case 0:
            return self.storyboard!.instantiateViewControllerWithIdentifier("reserve")
        default:
            return self.storyboard!.instantiateViewControllerWithIdentifier("reserve")
        }
        
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAtIndex index: UInt) {
        NSLog("Did move at index: %ld", index)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_reserve_info" {
            let vc = segue.destinationViewController as! ReserveCancelViewController
            vc.item = sender as! ReserveInfo
        }
    }
    


}
