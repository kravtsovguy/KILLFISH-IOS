//
//  PaymentsViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 06.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class PaymentsViewController: MasterNavViewController, CarbonTabSwipeNavigationDelegate {

    var items = NSArray()
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.paymentsView = self
        App.loadCachePayments()
        
        items = ["ВСЕ", "ЗАЧИСЛЕНИЯ", "РАСХОДЫ", "БОНУСЫ"]
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insertIntoRootViewController(self)
        
        carbonTabSwipeNavigation.setDefaultStyle();
        
        self.style()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        APICalls.getPayments { payments in
            
            App.payments = payments
            App.saveCachePayments()
            
            for payment in payments{
                if payment.id == 0{
                    continue
                }
                APICalls.getCheck(payment.id, onCompletion: { (check) -> Void in
                    payment.check = check
                    App.saveCachePayments()
                    //self.tableView.reloadData()
                })
                
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func style() {
        
        //carbonTabSwipeNavigation.setTabExtraWidth(30)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width/CGFloat(items.count)-15, forSegmentAtIndex: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width/CGFloat(items.count)+15, forSegmentAtIndex: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width/CGFloat(items.count), forSegmentAtIndex: 2)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width/CGFloat(items.count), forSegmentAtIndex: 3)
        
        
        
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        
        let vc =  self.storyboard!.instantiateViewControllerWithIdentifier("paymentsList") as! PaymentsListViewController
        
        switch index {
        case 0:
            vc.type = "all"
        case 1:
            vc.type = "income"
        case 2:
            vc.type = "writeoff"
        case 3:
            vc.type = "bonus"
        default:
            vc.type = "all"
        }
        
        return vc
        
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAtIndex index: UInt) {
        NSLog("Did move at index: %ld", index)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_payment_info" {
            let vc = segue.destinationViewController as! PaymentInfoViewController
            vc.item = sender as! PaymentInfo
        }
    }

}
