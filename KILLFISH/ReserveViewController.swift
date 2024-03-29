//
//  ReserveViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 04.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//


import UIKit

class ReserveViewController: MasterNavViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonReserve: UIButton!
    @IBOutlet weak var bottomC: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !App.ios9{
            //bottomC.constant += 100
        }
        view.layoutIfNeeded()
        
        view.backgroundColor = UIColor.clearColor()
        
        App.loadCacheBars()
        App.loadCacheReserves()
        items = App.reserves
        
        let item = ReserveInfo(bar: "главный бар", dateUnix: 1392321600, count: 12)
        item.sum = 50000
        item.status = 2
        item.cancelable = true
        //items = [item,item,item]
        
        setupInfoBtn("Информация", msg: "В случае, если Вы бронируете столы на компанию, размер которой превышает 25 человек, необходимо заранее связаться с администратором бара по телефону и устно подтвердить бронь.")
        
        APICalls.getBars {_ in }
    }
    
    override func viewWillAppear(animated: Bool) {
        //super.viewWillAppear(animated)

        view.layoutIfNeeded()
        
        APICalls.getReserves { reserves in
            self.items = reserves
            self.tableView.reloadData()
        }
    }
    
    var items: [ReserveInfo] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("reserveCell")! as! ReserveTableViewCell
        
        cell.setup(items[indexPath.row])
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("goto_reserve_info", sender: self.items[indexPath.row])
    }
    @IBAction func addReserve(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goto_reserve_add", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_reserve_info" {
            let vc = segue.destinationViewController as! ReserveCancelViewController
            vc.item = sender as! ReserveInfo
        }
    }
    

}
