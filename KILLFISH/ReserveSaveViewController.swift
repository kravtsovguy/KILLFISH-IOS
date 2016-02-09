//
//  ReserveSaveViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 05.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class ReserveSaveViewController: NavViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var cityView: TextBoxView!
    @IBOutlet weak var barView: TextBoxView!
    @IBOutlet weak var dateView: TextBoxView!
    @IBOutlet weak var numView: TextBoxView!
    @IBOutlet weak var timeView: TextBoxView!
    @IBOutlet weak var discrView: TextBoxView!
    @IBOutlet weak var vipView: UISwitch!
    @IBOutlet weak var sumView: LabelView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var fswitchView: FlatSwitchView!
    
    var pickerBarView = UIPickerView()
    var pickerCityView = UIPickerView()
    let pickerNumView = UIPickerView()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    var date = NSDate(timeIntervalSince1970: 0)
    var currCityId = -1
    var currBarId = -1
    var num = 0
    
    var sum = 0
    var vip = false
    
    var numArr = [String]()
    
    override func viewWillAppear(animated: Bool) {
        //super.viewWillAppear(animated)
        
        cityView.textBox.text = ""
        barView.textBox.text = ""
        dateView.textBox.text = ""
        numView.textBox.text = ""
        discrView.textBox.text = ""
        sumView.text = ""
        
        setupLastBar()
    }
    
    func setupLastBar(){
        
        if(App.user.lastBarId == 0){
            return
        }
        
        for var i=0; i<App.cities.count; i+=1{
            for var j=0; j<App.cities[i].bars.count; j+=1{
                if App.cities[i].bars[j].id == App.user.lastBarId{
                    currCityId = i
                    cityView.textBox.text = App.cities[currCityId].name
                    
                    currBarId = j
                    barView.textBox.text = getFullBarName(currCityId, bid: currBarId)
                }
            }
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for var i = 1 ; i<=100; i+=1 {
            numArr.append("\(i) человек")
            if 1<i && i<5{
                numArr[i-1]+="а"
            }
        }
        
        fswitchView.switched = vipChanged
        
        
        cityView.textBox.delegate = self
        barView.textBox.delegate = self
        dateView.textBox.delegate = self
        timeView.textBox.delegate = self
        numView.textBox.delegate = self
        discrView.textBox.delegate = self
        
        datePicker.date = NSDate(timeIntervalSince1970: 0)
        datePicker.datePickerMode = .DateAndTime
        timePicker.datePickerMode = .Time
        
        pickerCityView.delegate = self
        pickerCityView.dataSource = self
        
        pickerBarView.delegate = self
        pickerBarView.dataSource = self
        
        pickerNumView.delegate = self
        pickerNumView.dataSource = self
        
        //let oneHourBack = myDate.dateByAddingTimeInterval(-3600)
        
        datePicker.minimumDate = NSDate()
        
        datePicker.maximumDate = NSCalendar.currentCalendar().dateByAddingUnit(
            NSCalendarUnit.Day,
            value: +14,
            toDate: NSDate(),
            options: NSCalendarOptions.WrapComponents)
        
        
        
        
        setPicker(dateView.textBox, dpicker: datePicker, act: "showSelectedDate")
        //setPicker(timeView.textBox, dpicker: timePicker, act: "showSelectedTime")
        setPicker(cityView.textBox, dpicker: pickerCityView, act: "showSelectedCity")
        setPicker(barView.textBox, dpicker: pickerBarView, act: "showSelectedBar")
        setPicker(numView.textBox, dpicker: pickerNumView, act: "showSelectedNum")

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerCityView{
            return App.cities.count
        }
        if pickerView == pickerBarView{
            if currCityId != -1{
                return App.cities[currCityId].bars.count
            }else{
                return 0
            }
        }
        if pickerView == pickerNumView{
            return numArr.count
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerCityView{
            return App.cities[row].name
        }
        if pickerView == pickerBarView{
            if currCityId != -1{
                return getFullBarName(currCityId, bid: row)
            }else{
                return ""
            }
        }
        if pickerView == pickerNumView{
            return numArr[row]
        }
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       /* if pickerView == pickerCityView{
            currCityId = row
            cityView.textBox.resignFirstResponder()
        }else if pickerView == pickerBarView{
            currBarId = row
            barView.textBox.resignFirstResponder()
        }*/
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPicker(dtext:UITextField, dpicker: UIView, act: Selector){
    
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
        dateView.textBox.resignFirstResponder()
        date = datePicker.date
        checkDate()
    }
    /*
    func showSelectedTime(){
        let f = NSDateFormatter()
        f.dateFormat = "HH:mm"
        timeView.textBox.text = f.stringFromDate(timePicker.date)
        timeView.textBox.resignFirstResponder()
    }
    */
    func showSelectedCity(){
        cityView.textBox.resignFirstResponder()
        
        let row = pickerCityView.selectedRowInComponent(0)
        
        if row != currCityId{
            currBarId = -1
            barView.textBox.text = ""
        }
        
        currCityId = row
        cityView.textBox.text = App.cities[row].name
    }
    
    func getFullBarName(cid:Int, bid:Int)->String{
        let start = App.cities[cid].bars[bid].start
        let end = App.cities[cid].bars[bid].end
        let name = App.cities[cid].bars[bid].name
        return "\(name) (\(start):00 - \(end+1):00)"
    }
    
    func showSelectedBar(){
        barView.textBox.resignFirstResponder()
        
        if currCityId == -1{
            return
        }
        
        let row = pickerBarView.selectedRowInComponent(0)
        
        if row != currBarId {
        }
        
        currBarId = row
        barView.textBox.text = getFullBarName(currCityId, bid: row)
        
        checkDate()
        
    }
    
    func showSelectedNum(){
        let row = pickerNumView.selectedRowInComponent(0)
        num = row+1
        numView.textBox.text = numArr[row]
        numView.textBox.resignFirstResponder()
        
        recalcSum()
    }
    
    func recalcSum(){
        if num == 0 {
            return
        }
        if vip{
            sum = ReserveInfo.priceVIP / 100 * (((num-1) / (ReserveInfo.kVIP)) + 1)
        }else{
            sum = ReserveInfo.priceNormal / 100 * (((num-1) / (ReserveInfo.kNormal)) + 1)
        }
        sumView.text = "\(sum) \(App.curr)"
    }

    @IBAction func saveReserve(sender: AnyObject) {
        self.saveBtn.enabled = false
        
        let ok = checkValues { (err) -> Void in
            self.saveBtn.enabled = true
            JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
        }
        if !ok{
            return
        }
        APICalls.saveReserve(vip, barid: App.cities[currCityId].bars[currBarId].id, dt: date.timeIntervalSince1970, num: num, discr: discrView.textBox.text!, onCompletion: { (bronid) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }) { (err) -> Void in
                self.saveBtn.enabled=true
                JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
        }
        
    }
    
    func checkValues(onError: (String)->Void)->Bool{
        var err = ""
        if currCityId == -1{
            err = "Выберите город"
        }else
        if currBarId == -1{
            err = "Выберите бар"
        }else
        if date.timeIntervalSince1970 == 0{
            err = "Выберите дату"
        }else
        if num==0{
            err = "Введите число гостей"
        }
        let ok = err == ""
        if !ok {
            onError(err)
        }
        return ok
    }
    
    func checkDate(){
        if currCityId != -1 && currBarId != -1{
            
            let start = App.cities[currCityId].bars[currBarId].start
            let end = App.cities[currCityId].bars[currBarId].end
            
            let f = NSDateFormatter()
            f.dateFormat = "HH"
            let h = Int(f.stringFromDate(date))
            if start <= h && h <= 24 || 0<=h && h<=end {
                
            }else{
                
                date = NSCalendar.currentCalendar().dateByAddingUnit(
                    NSCalendarUnit.Hour,
                    value: start-h!,
                    toDate: date,
                    options: NSCalendarOptions.WrapComponents)!
                
            }
        }
        
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy HH:mm"
        
        dateView.textBox.text = f.stringFromDate(date)
        
    }
    
    @IBAction func vipChanged(sender: AnyObject) {
        vip = fswitchView.isRight//vipView.on
        recalcSum()
    }

}
