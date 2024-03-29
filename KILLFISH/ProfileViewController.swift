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
    @IBOutlet weak var cardTypeView: TextBoxView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.loadCacheUser()
        App.loadCachePhoto()
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
        let rectMenu = CGRect(x: 0, y: 0, width: 20, height: 20)
        let butMenu = UIButton(frame: rectMenu)
        butMenu.setBackgroundImage(imgMenu, forState: .Normal)
        butMenu.addTarget(self, action: "logout", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: butMenu);
    }
    
    func logout(){
        
        let alertController = UIAlertController(title: "Выйти из аккаунта?", message:
            "", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Выйти", style: UIAlertActionStyle.Destructive,handler: { (action: UIAlertAction!) in
            
            //App.menu.selectItem(0)
            //App.menu.items[0].performSegueWithIdentifier("goto_login", sender: self)
           
            //self.performSegueWithIdentifier("goto_logout", sender: self)
            
            
            APICalls.logout({ (ok) -> Void in
                 self.performSegueWithIdentifier("goto_logout", sender: self)
                }) { (err) -> Void in
                JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
            }

        }))
        
        alertController.addAction(UIAlertAction(title: "Нет", style: UIAlertActionStyle.Cancel,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if(App.user.name == ""){
            
            nameView.text = ""
            phoneView.text = ""
            moneyView.text = ""
            cardView.text = ""
            
            avatarView.alpha = 0.5
            avatarView.image = UIImage(named: "Default photo")
        }
        
        //setupUser()
        
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
        cardTypeView.text = "Тип карты: "+App.cardType[App.user.card_type]!;
        
        if App.userPhoto == nil{
            setupAvatarByURL(App.user.photo)
        }else{
            let data1 = UIImagePNGRepresentation(App.userPhoto)
            let data2 = UIImagePNGRepresentation(UIImage.initFromColor(UIColor.whiteColor()))
            if data1!.isEqualToData(data2!) {
                setupAvatarByURL(App.user.photo)
            }else{
                setupAvatarByImage(App.userPhoto)
            }
        }
    }
    
    var picker:UIImagePickerController = UIImagePickerController()
    var popover:UIPopoverController!
    
    @IBAction func imageTapped(sender: AnyObject) {
        
        picker.navigationBar.tintColor = UIColor.blackColor()
        picker.navigationBar.barTintColor = UIColor.whiteColor()
        //picker.navigationBar.backgroundColor = UIColor.whiteColor()
        picker.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        picker.navigationBar.translucent = false
        
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
        
        App.userPhoto = nimg
            
        APICalls.uploadPhoto(nimg, onCompletion: { (url) -> Void in
            
            }) { (err) -> Void in
                
        }
        
        setupAvatarByImage(img!)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        print("picker cancel.")
    }
    
    func setupAvatarByURL(url: String){
        
        if url == ""{
            
            avatarView.alpha = 0.5
            avatarView.image = UIImage(named: "Default photo")
            
            return
        }
        
        App.loadImage(url){ (img) ->Void in
            App.userPhoto = img
            App.saveCachePhoto()
            
            self.setupAvatarByImage(img)
        }
    }
    
    func setupAvatarByImage(var img: UIImage){
        
        img = Toucan(image: img).resize(CGSize(width: 222, height: 222), fitMode: Toucan.Resize.FitMode.Crop).maskWithEllipse().image
        avatarView.alpha = 1
        avatarView.image = img
        
    }


    @IBAction func moneyTapped(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goto_pay", sender: self)
        
    }
    @IBAction func cardTapped(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Тип карты", message: App.cardType[App.user.card_type], preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
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
