//
//  FriendsViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 08.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class FriendsViewController: MasterNavViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var items: [FriendInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.loadCacheFriends()
        items = App.friends
        
        
        let item = FriendInfo()
        item.name = "Кравцов Матвей Евгеньевич"
        item.type = "f1"
        items = [item,item,item]
        
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        APICalls.getFriends { (friends) -> Void in
            //self.items = friends
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("friendCell")! as! FriendViewCell
        
        cell.setup(items[indexPath.row])
        cell.accessoryType = UITableViewCellAccessoryType.None
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
