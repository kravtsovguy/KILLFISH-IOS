//
//  SignupTwoViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 03.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class SignupTwoViewController: NavViewController  {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImg.image = UIImage(named: "EnterRegistrBackground")
        
        imgView.layer.borderWidth = 0
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.layer.masksToBounds = true
        
        nameView.textBox.keyboardType = .Default
        cardView.textBox.keyboardType = .NumberPad

        
        nameView.textBox.delegate = self
        dateView.textBox.delegate = self
        cardView.textBox.delegate = self
        
        
        imgView.downloadedFrom(link: "http://placehold.it/200x200")
        
        setDatePicker()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    let datePicker = UIDatePicker()
    func setDatePicker(){
        
        datePicker.datePickerMode = .Date
        //let pv = UIPickerView()
        dateView.textBox.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        toolbar.tintColor = UIColor.whiteColor()
        //let doneBtn = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.Plain, target: self, action: "showSelectedDate")
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done , target: self, action: "showSelectedDate")
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace , target: nil, action: nil)
        
        toolbar.setItems([space,doneBtn], animated: true)
        
        let bgColor = UIColor.grayColor().colorWithAlphaComponent(1)
        toolbar.setBackgroundImage(UIImage.initFromColor(bgColor),
            forToolbarPosition: UIBarPosition.Any,
            barMetrics: UIBarMetrics.Default)
        
        dateView.textBox.inputAccessoryView = toolbar
        
    }
    
    func showSelectedDate(){
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        dateView.textBox.text = f.stringFromDate(datePicker.date)
        dateView.textBox.resignFirstResponder()
    }
    
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        nameView.textBox.text = ""
        dateView.textBox.text = ""
        cardView.textBox.text = ""
        
        if num == "" {
            cardLabel.hidden = true
            cardSwitch.hidden = true
        }else{
            cardLabel.hidden = false
            cardLabel.hidden = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signupPressed(sender: AnyObject) {
        
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
        
        APICalls.registerThree(preId, name: nameView.textBox.text!, day: day, month: month, year: year, curr: currI[currSegment.selectedSegmentIndex]!, num: cardSwitch.selected, owner: cardView.textBox.text!, onCompletion: { (ok) -> Void in
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }) { (err) -> Void in
            self.signupBtn.enabled = true
        }
        
    }

}
