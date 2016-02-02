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
        
        
        avatarView.layer.borderWidth = 0
        avatarView.layer.cornerRadius = avatarView.frame.height/2
        avatarView.layer.masksToBounds = true
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        setupUser()
        APICalls.getData { (ok) -> Void in
            self.setupUser()
        }
    }
    
    func setupUser()
    {
        nameView.text = App.user.name
        phoneView.text = App.user.phone
        moneyView.text = "\(App.user.balance/100) руб."
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
