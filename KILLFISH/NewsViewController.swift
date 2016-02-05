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
    
    //static var logged = true;
    var items: [NewsInfo] = [] //= ["We", "Heart", "Swift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        /*APICalls.Login("79136653903", code: "89295") { (ok) -> Void in
            self.title="\(ok)"
            self.title="\(APICalls.id)+\(APICalls.authtoken)"
            
        }*/
        
        items = App.getCacheNews()
        
        APICalls.getNews { (news) -> Void in
            self.items = news
            self.tableView.reloadData()
            for newItem in news{
                APICalls.getNewsItem(newItem.id, onCompletion: { (newItemFull) -> Void in
                    newItem.text = newItemFull.text
                    App.setCacheNews(self.items)
                    self.tableView.reloadData()
                    //self.tableView.reloadData()
                })
            }
        }
            
        /*APICalls.RemindCode("79136653903") { (ok) -> Void in
            self.title="\(ok)"
        }*/
        /*
        let item = NewsInfo(title: "Вот это да!", dateUnix: 1392321600, text: "Лорем<br>Ипсум")
        items=[item,item,item,item]
        */
        
        App.loadCacheUser()
        if(!App.isLogged){
        //if true {
            //NewsViewController.logged=true;
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
        
        self.performSegueWithIdentifier("goto_news", sender: self.items[indexPath.row])
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("newsItem") as! NewsItemViewController
        vc.item = self.items[indexPath.row]//sender as! NewsInfo
        
        navigationController?.pushViewController(vc, animated: true)*/
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_news" {
            let vc = segue.destinationViewController as! NewsItemViewController
            vc.item = sender as! NewsInfo
        }
    }

}

