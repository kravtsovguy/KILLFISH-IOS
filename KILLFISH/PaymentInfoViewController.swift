//
//  PaymentInfoViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 06.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class PaymentInfoViewController: NavViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var discrView: UILabel!
    @IBOutlet weak var dateView: LabelView!
    @IBOutlet weak var sumView: LabelView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labels: UIView!
    
    var item: PaymentInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if item==nil { return }
        setup()
    }
    
    func setup(){

        title = "Чек \(item.id == 0 ? "" : String(item.id))"
        discrView.text = item.discr
        dateView.textView.text = "\(item.dayAndMonthAndYear) \(item.timeHM)"
        sumView.textView.text = "\(abs(item.sum/100)) \(App.currency[item.curr]!)"
        labels.hidden = item.id == 0
        tableView.hidden = item.id == 0
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.check.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("checkCell")! as! CheckViewCell
        
        cell.setup(item.check[indexPath.row])
        cell.accessoryType = UITableViewCellAccessoryType.None
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        cell.selectedBackgroundView = bgColorView
        return cell
    }

}
