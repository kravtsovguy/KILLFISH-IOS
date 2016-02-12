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
    
    @IBOutlet weak var viewContent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.servicesView = self
        
        setupItems()
        
        items = ["Заказ музыки", "Бронирование столов"]
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insertIntoRootViewController(self)
        
        //carbonTabSwipeNavigation.view.frame.size = CGSize(width: 10, height: 10)
        
        carbonTabSwipeNavigation.setDefaultStyle();
        
        self.style()
        
    }
    
    let itemsStr = ["music","reserve"]
    var itemsVC: [UIViewController] = []
    
    func setupItems(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        for item in itemsStr{
            let vc = storyboard.instantiateViewControllerWithIdentifier(item)
            //vc.view.sizeToFit()
            //vc.view.frame.size.height -= 100
            itemsVC.append(vc)
            
        }
    }
    
    
    override func viewWillAppear(animated:Bool) {
        //super.viewWillAppear(animated)
        
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
            return itemsVC[0]
        case 1:
            return itemsVC[1]
        default:
            return itemsVC[0]
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
