//
//  ViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 28.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NewsViewController: MasterNavViewController {

    
    static var logged = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

    
    @IBAction func nextTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("goto_next", sender: self)
    }

}

