//
//  NextViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 31.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    func setNavTitle(title:String){
        (navigationItem.titleView as! UILabel).text = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        
        let navLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20));
        //navLabel.backgroundColor = UIColor
        navLabel.textColor = UIColor.whiteColor();
        navLabel.font = UIFont(name: "Roboto-Light", size: 15)
        navLabel.textAlignment = NSTextAlignment.Center;
        navLabel.text = "Custom";
        navLabel.center.x-=100
        navigationItem.titleView = navLabel;
        
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
        
        setNavTitle("Окно");
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
