//
//  ViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 28.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NewsViewController: MasterNavViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    static var logged = false;
    var items: [NewsInfo] = [] //= ["We", "Heart", "Swift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let item = NewsInfo(title: "Вот это да!", dateUnix: 1392321600, text: "Лорем<br>Ипсум")
        items=[item,item,item,item]
        
        if(!NewsViewController.logged){
            NewsViewController.logged=true;
            self.performSegueWithIdentifier("goto_login", sender: self)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
   
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("newsCell")! as! NewsTableViewCell
        
        cell.setup(items[indexPath.row])
        //cell.dataLabel.text="06.12"
        //cell.titleLabel.text="1..2..3..Погнали!"
        //cell.textLabel?.text = self.items[indexPath.row]
        //cell.tintColor = UIColor.redColor()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        //cell.accessoryView
        //cell.selectionStyle = .None
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        //bgColorView.layer.cornerRadius=10
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("goto_news", sender: items[indexPath.row])
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_news" {
            let vc = segue.destinationViewController as! NewsItemViewController
            vc.item = sender as! NewsInfo
        }
    }

}

