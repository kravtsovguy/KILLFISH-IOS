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
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    var pickerBarView = UIPickerView()
    var pickerCityView = UIPickerView()
    let pickerNumView = UIPickerView()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    var date = NSDate()
    var currCityId = -1
    var currBarId = -1
    var num = 0
    
    var sum = 0
    var vip = false
    
    var numArr: [(str:String,num:Int)] = []
    
    override func viewWillAppear(animated: Bool) {
        //super.viewWillAppear(animated)
        
        //setupBackButton()
        
        cityView.textBox.text = ""
        barView.textBox.text = ""
        dateView.textBox.text = ""
        numView.textBox.text = ""
        discrView.textBox.text = ""
        sumView.text = ""
        saveBtn.enabled = true
        
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
        
        for var i = 4 ; i<=40; i+=4 {
            var letter = ""
            if 1<i && i<5{
                letter = "а"
            }
            numArr.append(("\(i) человек\(letter)",i))
        }
        
        fswitchView.switched = vipChanged
        
        
        cityView.textBox.delegate = self
        barView.textBox.delegate = self
        dateView.textBox.delegate = self
        timeView.textBox.delegate = self
        numView.textBox.delegate = self
        discrView.textBox.delegate = self
        
        datePicker.date = NSDate()
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
            return numArr[row].str
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
        num = numArr[row].num
        numView.textBox.text = numArr[row].str
        numView.textBox.resignFirstResponder()
        
        recalcSum()
    }
    
    func recalcSum(){
        if num == 0 {
            return
        }
        if vip{
            sum = ReserveInfo.priceVIP / 100 //* (((num-1) / (ReserveInfo.kVIP)) + 1)
        }else{
            sum = (ReserveInfo.priceNormal / 100)*(ReserveInfo.kNormal) * (((num-1) / (ReserveInfo.kNormal)) + 1)
        }
        sumView.text = "\(sum) \(App.curr)"
    }

    @IBAction func saveReserve(sender: AnyObject) {
        
        
        let ok = checkValues { (err) -> Void in
            JLToast.makeText(err, duration: JLToastDelay.ShortDelay).show()
        }
        if !ok{
            return
        }
        
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy HH:mm"
        let sdate = f.stringFromDate(date)
        
        let svip = vip ? "VIP" : "Обычный"
        
        let alertController = UIAlertController(title: "Бронирование", message:
            "Город - \(App.cities[currCityId].name)\nБар - \(App.cities[currCityId].bars[currBarId].name)\nКоличество человек - \(num)\nДата - \(sdate)\nТип брони - \(svip)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Забронировать", style: UIAlertActionStyle.Default,handler: { (action: UIAlertAction!) in
            self.saveReserveDo()
        }))
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel,handler: { (action: UIAlertAction!) in
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    func saveReserveDo(){
        self.saveBtn.enabled = false
        
        APICalls.saveReserve(vip, barid: App.cities[currCityId].bars[currBarId].id, dt: date.timeIntervalSince1970, num: num, discr: discrView.textBox.text!, onCompletion: { (bronid) -> Void in
            JLToast.makeText("Успешно!", duration: JLToastDelay.ShortDelay).show()
            self.navigationController?.popViewControllerAnimated(true)
            //self.dismissViewControllerAnimated(true, completion: nil)
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
            
            //let start = App.cities[currCityId].bars[currBarId].start
            //let end = App.cities[currCityId].bars[currBarId].end
            /*
            let f = NSDateFormatter()
            f.dateFormat = "HH"
            let h = Int(f.stringFromDate(date))
*/
            /*
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Hour], fromDate: date)
            let h = components.hour
            
            if start <= h && h <= 24 || 0<=h && h<=end {
                
            }else{
                
                date = NSCalendar.currentCalendar().dateByAddingUnit(
                    NSCalendarUnit.Hour,
                    value: start-h,
                    toDate: date,
                    options: NSCalendarOptions.WrapComponents)!
                
            }
*/
        }
        
        let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy HH:mm"
        
        dateView.textBox.text = f.stringFromDate(date)
        
    }
    
    @IBAction func segmentChanged(sender: AnyObject) {
        vip = segmentView.selectedSegmentIndex == 1
        recalcSum()
    }
    @IBAction func vipChanged(sender: AnyObject) {
        vip = fswitchView.isRight//vipView.on
        recalcSum()
    }
    @IBAction func rulesPressed(sender: AnyObject) {

        self.performSegueWithIdentifier("goto_reserve_rules", sender: self)
        //UIApplication.sharedApplication().openURL(NSURL(string: "https://killfish.ru/my/reserve.html")!)
        
    }

}
