//
//  ProfileViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 30.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class ProfileViewController: MasterNavViewController {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameView: TextBoxView!
    @IBOutlet weak var phoneView: TextBoxView!
    @IBOutlet weak var moneyView: TextBoxView!
    @IBOutlet weak var cardView: TextBoxView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.loadCacheUser()
        setupUser()
        
        setupRightItem()
        
        avatarView.layer.borderWidth = 0
        avatarView.layer.cornerRadius = avatarView.frame.height/2
        avatarView.layer.masksToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupRightItem()
    {
        let imgMenu = UIImage(named: "Exit")!.alpha(0.5)
        let rectMenu = CGRect(x: 0, y: 0, width: 15, height: 15)
        let butMenu = UIButton(frame: rectMenu)
        butMenu.setBackgroundImage(imgMenu, forState: .Normal)
        butMenu.addTarget(self, action: "logout", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: butMenu);
    }
    
    func logout(){
        
        let alertController = UIAlertController(title: "", message:
            "Выйти из аккаунта?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Выйти", style: UIAlertActionStyle.Destructive,handler: { (action: UIAlertAction!) in
            
            App.menu.selectItem(0)
            App.menu.items[0].performSegueWithIdentifier("goto_login", sender: self)
            
            /*
            APICalls.logout({ (ok) -> Void in
                
                }) { (err) -> Void in
                JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
            }
            */
        }))
        
        alertController.addAction(UIAlertAction(title: "Нет", style: UIAlertActionStyle.Cancel,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        nameView.text = ""
        phoneView.text = ""
        moneyView.text = ""
        cardView.text = ""
        
        APICalls.getData { (ok) -> Void in
            self.setupUser()
        }
    }
    
    func setupUser()
    {
        nameView.text = App.user.name
        phoneView.text = App.user.phone
        moneyView.text = "\(App.user.balance/100) \(App.curr)"
        cardView.text = App.user.card
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
