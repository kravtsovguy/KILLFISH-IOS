//
//  ProfileViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 30.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class ProfileViewController: MasterNavViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
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
        
        /*
        avatarView.layer.borderWidth = 0
        avatarView.layer.cornerRadius = avatarView.frame.height/2
        avatarView.layer.masksToBounds = true
        */
        
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
            
            //App.menu.selectItem(0)
            //App.menu.items[0].performSegueWithIdentifier("goto_login", sender: self)
            self.performSegueWithIdentifier("goto_logout", sender: self)
            
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
        
        setupUser()
        
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
        setupAvatarByURL(App.user.photo)
    }
    
    var picker:UIImagePickerController = UIImagePickerController()
    var popover:UIPopoverController!
    
    @IBAction func imageTapped(sender: AnyObject) {
        
        let alert:UIAlertController=UIAlertController(title: "Выберите аватар", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Галлерея", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel)
            {
                UIAlertAction in
        }
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            popover=UIPopoverController(contentViewController: alert)
            popover.presentPopoverFromRect(avatarView.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(picker, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    func openGallary()
    {
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else
        {
            popover=UIPopoverController(contentViewController: picker)
            popover.presentPopoverFromRect(avatarView.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        //avatarView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let nimg = Toucan(image: img!).resize(CGSize(width: 222, height: 222)).image
            
        APICalls.uploadPhoto(nimg, onCompletion: { (url) -> Void in
            
            }) { (err) -> Void in
                
        }
        
        setupAvatarByImage(img!)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
    }
    
    func setupAvatarByURL(url: String){
        
        if url == ""{
            
            avatarView.alpha = 0.5
            avatarView.image = UIImage(named: "Default photo")
            
            return
        }
        App.loadImage(url){ (img) ->Void in
            self.setupAvatarByImage(img)
        }
    }
    
    func setupAvatarByImage(var img: UIImage){
        
        img = Toucan(image: img).resize(CGSize(width: 222, height: 222), fitMode: Toucan.Resize.FitMode.Crop).maskWithEllipse().image
        avatarView.alpha = 1
        avatarView.image = img
        
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
