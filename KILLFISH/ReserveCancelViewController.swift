//
//  ReserveCancelViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 05.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class ReserveCancelViewController: NavViewController {
    @IBOutlet weak var barView: TextBoxView!
    @IBOutlet weak var dateView: TextBoxView!
    @IBOutlet weak var numView: TextBoxView!
    @IBOutlet weak var statusView: LabelView!
    @IBOutlet weak var sumView: LabelView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var item: ReserveInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRightItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        barView.textBox.text = ""
        dateView.textBox.text = ""
        numView.textBox.text = ""
        statusView.text = ""
        sumView.text = ""
        
        if item==nil { return }
        setup()
    }
    
    func cancel(){
        
        cancelPressed(self)
        
    }
    
    func setupRightItem()
    {
        let imgMenu = UIImage(named: "Cancel")!.alpha(0.5)
        let rectMenu = CGRect(x: 0, y: 0, width: 15, height: 15)
        let butMenu = UIButton(frame: rectMenu)
        butMenu.setBackgroundImage(imgMenu, forState: .Normal)
        butMenu.addTarget(self, action: "cancel", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: butMenu);
    }
    
    func setup(){
        barView.textBox.text = item.bar
        dateView.textBox.text = "\(item.dayAndMonthAndYear) \(item.timeHM)"
        numView.textBox.text = "\(item.count) человек"
        if 1<item.count && item.count<5{
            numView.textBox.text=numView.textBox.text!+"а"
        }
        cancelBtn.hidden = true//!item.cancelable

        navigationItem.rightBarButtonItem?.customView?.hidden = !item.cancelable
        
        sumView.text = "\(item.sum/100) \(App.curr)"
        
        if item.status == 0{
            statusView.text = "бронь активна"
        }
        if item.status == 1{
            statusView.text = "бронь отменена"
        }
        if item.status == 2{
            statusView.text = "бронь выполнена"
        }
        if item.status == 5{
            statusView.text = "в работе"
        }
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.cancelBtn.enabled = false
        
        APICalls.cancelReserve(item.id, onCompletion: { (ok) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            }) { (err) -> Void in
                self.cancelBtn.enabled=true
                JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
        }
    }
}
