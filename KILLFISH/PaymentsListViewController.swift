//
//  PaymentsListViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 06.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class PaymentsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var type = "all"
    var items: [PaymentInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        
        //let item = PaymentInfo(type: "income", dateUnix: <#T##Double#>, sum: 10000, curr: "RUR")
        //items = [item,item,item]
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        items = App.payments.filter({ (pi) -> Bool in
            if type == "all"{
                return true
            }else{
                return pi.type == type
            }
        })
        tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("paymentCell")! as! PaymentViewCell
        
        cell.setup(items[indexPath.row])
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        App.paymentsView.performSegueWithIdentifier("goto_payment_info", sender: self.items[indexPath.row])
    }

}
