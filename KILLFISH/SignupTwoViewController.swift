//
//  SignupTwoViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 03.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class SignupTwoViewController: NavViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameView: TextBoxView!
    @IBOutlet weak var dateView: TextBoxView!
    @IBOutlet weak var cardView: TextBoxView!
    @IBOutlet weak var cardSwitch: UISwitch!
    @IBOutlet weak var currSegment: UISegmentedControl!
    
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var cardLabel: UILabel!
    var preId = 0
    var num = ""
    
    let currI = [0:"RUR", 1:"BYR", 2:"KZT"]
    
    var tempImg: UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImg.image = UIImage(named: "EnterRegistrBackground")
        
        /*
        imgView.layer.borderWidth = 0
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.layer.masksToBounds = true
        */
        
        nameView.textBox.keyboardType = .Default
        cardView.textBox.keyboardType = .NumberPad

        
        nameView.textBox.delegate = self
        dateView.textBox.delegate = self
        cardView.textBox.delegate = self
        
        
        //imgView.downloadedFrom(link: "http://placehold.it/200x200")
        
        setDatePicker(dateView.textBox,dpicker: datePicker,act: "showSelectedDate")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        tempImg = nil
    }
    
    let datePicker = UIDatePicker()
    func setDatePicker(dtext:UITextField, dpicker: UIDatePicker, act: Selector){
        
        dpicker.datePickerMode = .Date
        //let pv = UIPickerView()
        dtext.inputView = dpicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        toolbar.tintColor = UIColor.whiteColor()
        //let doneBtn = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.Plain, target: self, action: "showSelectedDate")
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done , target: self, action: act)
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace , target: nil, action: nil)
        
        toolbar.setItems([space,doneBtn], animated: true)
        
        let bgColor = UIColor.grayColor().colorWithAlphaComponent(1)
        toolbar.setBackgroundImage(UIImage.initFromColor(bgColor),
            forToolbarPosition: UIBarPosition.Any,
            barMetrics: UIBarMetrics.Default)
        
        dtext.inputAccessoryView = toolbar
        
    }
    
    func showSelectedDate(){
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        dateView.textBox.text = f.stringFromDate(datePicker.date)
        dateView.textBox.resignFirstResponder()
    }
    
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        nameView.textBox.text = "Кравцов Матвей Евгеньевич"
        dateView.textBox.text = ""
        cardView.textBox.text = "1426843"
        currSegment.selectedSegmentIndex = 0
        cardSwitch.on = false
        
        if num == "" {
            cardLabel.hidden = true
            cardSwitch.hidden = true
        }else{
            cardLabel.hidden = false
            cardLabel.hidden = false
        }
        
        if(tempImg == nil){
            imgView.alpha = 0.5
            imgView.image = UIImage(named: "AvatarAdd")
        }else{
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signupPressed(sender: AnyObject) {
        
        
        let ok = checkValues { (err) -> Void in
            JLToast.makeText(err, duration: JLToastDelay.ShortDelay).show()
        }
        if !ok{
            return
        }
        
        //navigationController?.dismissViewControllerAnimated(true, completion: nil)
        signupBtn.enabled = false
        
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        let date = f.dateFromString(dateView.textBox.text!)
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date!)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        APICalls.registerThree(preId, name: nameView.textBox.text!, day: day, month: month, year: year, curr: currI[currSegment.selectedSegmentIndex]!, num: cardSwitch.on, owner: cardView.textBox.text!, onCompletion: { (ok) -> Void in
            if ok{
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }
            }) { (err) -> Void in
                self.signupBtn.enabled = true
                JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
        }
        
    }
    
    var picker:UIImagePickerController = UIImagePickerController()
    var popover:UIPopoverController!
    
    @IBAction func imageTapped(sender: AnyObject) {
        
        picker.navigationBar.tintColor = UIColor.blackColor()
        
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
            popover.presentPopoverFromRect(imgView.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
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
            popover.presentPopoverFromRect(imgView.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        //avatarView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        App.userPhotoSignin = Toucan(image: img!).resize(CGSize(width: 222, height: 222)).image
        App.userPhoto = App.userPhotoSignin
        
        tempImg = img!
        
        setupAvatarByImage(img!)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        print("picker cancel.")
    }

    
    func setupAvatarByImage(var img: UIImage){
        
        img = Toucan(image: img).resize(CGSize(width: 222, height: 222), fitMode: Toucan.Resize.FitMode.Crop).maskWithEllipse().image
        imgView.alpha = 1
        imgView.image = img
        
    }
    
    func checkValues(onError: (String)->Void)->Bool{
        var err = ""
        if nameView.textBox.text == ""{
            err = "Введите ФИО"
        }else
            if dateView.textBox.text == ""{
                err = "Введите дату рождения"
        }
        let ok = err == ""
        if !ok {
            onError(err)
        }
        return ok
    }

}
