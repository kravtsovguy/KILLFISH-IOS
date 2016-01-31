//
//  ViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 28.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NewsViewController: MasterNavViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(!logged){
            logged=true;
            self.performSegueWithIdentifier("goto_login", sender: self)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var logged = false;
    override func viewDidAppear(animated: Bool) {
        
   
    }

    
    @IBAction func nextTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("goto_next", sender: self)
    }

}

