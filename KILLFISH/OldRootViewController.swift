//
//  RootViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 30.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class OldRootViewController: UIViewController {
    
    func setNavTitle(title:String){
        (navigationItem.titleView as! UILabel).text = title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.clearColor()
        //title = "Home"
        let imgMenu = UIImage(named: "Menu")!.alpha(0.5)
        
        let rectMenu = CGRect(x: 0, y: 0, width: 15, height: 15)
        let butMenu = UIButton(frame: rectMenu)
        
        butMenu.setBackgroundImage(imgMenu, forState: .Normal)
        
        
        butMenu.addTarget(self, action: "presentLeftMenuViewController", forControlEvents: .TouchUpInside)
        
        
        let viewMenu = UIImageView(image: imgMenu)
        viewMenu.frame = rectMenu
        viewMenu.alpha=0.5
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: butMenu);
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: imgMenu, style: .Plain, target: self, action: "presentLeftMenuViewController")
        
        let navLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20));
        //navLabel.backgroundColor = UIColor
        navLabel.textColor = UIColor.whiteColor();
        navLabel.font = UIFont(name: "Roboto-Light", size: 15)
        navLabel.textAlignment = NSTextAlignment.Center;
        navLabel.text = "Custom";
        navLabel.center.x-=100
        navigationItem.titleView = navLabel;
        
        //navigationController!.navigationBar.barTintColor = UIColor(red: 1, green: 0.5, blue: 1, alpha: 0.05);
        //navigationController!.navigationBar.translucent = true
        
        /*navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
        
        let bounds = self.navigationController?.navigationBar.bounds as CGRect!
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]*/
        
        
        //TopView.backgroundColor = UIColor.clearColor();
        
        //self.navigationController?.navigationBar.addSubview(visualEffectView)
        //TopView.addSubview(visualEffectView)
        
        //TopView.addSubview(visualEffectView);
        //TopView.backgroundColor = UIColor.clearColor();
        //TopView.sendSubviewToBack(visualEffectView);

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
