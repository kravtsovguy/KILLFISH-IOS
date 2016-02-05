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
    @IBOutlet weak var sumView: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var pickerBarView = UIPickerView()
    var pickerCityView = UIPickerView()
    let pickerNumView = UIPickerView()
    let pickerTimeView = UIPickerView()
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    var date = NSDate(timeIntervalSince1970: 0)
    var currCityId = -1
    var currBarId = -1
    var num = 0
    
    var sum = 0
    var vip = false
    
    var numArr = [String]()
    var hours = -1
    var minutes = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for var i = 1 ; i<=100; i+=1 {
            numArr.append("\(i) человек")
        }
        
        sumView.text = ""
        
        cityView.textBox.delegate = self
        barView.textBox.delegate = self
        dateView.textBox.delegate = self
        timeView.textBox.delegate = self
        numView.textBox.delegate = self
        discrView.textBox.delegate = self
        
        datePicker.date = NSDate(timeIntervalSince1970: 0)
        datePicker.datePickerMode = .Date
        timePicker.datePickerMode = .Time
        
        pickerCityView.delegate = self
        pickerCityView.dataSource = self
        
        pickerBarView.delegate = self
        pickerBarView.dataSource = self
        
        pickerNumView.delegate = self
        pickerNumView.dataSource = self
        
        pickerTimeView.delegate = self
        pickerTimeView.dataSource = self
        
        setPicker(dateView.textBox, dpicker: datePicker, act: "showSelectedDate")
        //setPicker(timeView.textBox, dpicker: timePicker, act: "showSelectedTime")
        setPicker(timeView.textBox, dpicker: pickerTimeView, act: "showSelectedCorrectTime")
        setPicker(cityView.textBox, dpicker: pickerCityView, act: "showSelectedCity")
        setPicker(barView.textBox, dpicker: pickerBarView, act: "showSelectedBar")
        setPicker(numView.textBox, dpicker: pickerNumView, act: "showSelectedNum")
        
        
        // Do any additional setup after loading the view.
    }
    
    var arr = [Int]()
    func setupTime(){
        if currCityId != -1 && currBarId != -1{
            let start = App.cities[currCityId].bars[currBarId].start
            let end = App.cities[currCityId].bars[currBarId].end
            var arr = [Int]()
            for var i=start ; i != end ; i+=1{
                if i==24{
                    i=0
                }
                arr.append(i)
            }
            self.arr = arr
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == pickerTimeView{
            return 2
        }
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
        if pickerView == pickerTimeView{
            if component == 0{
                return arr.count
            }else{
                if arr.count != 0{
                    return 60
                }else {
                    0
                }
            }

        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerCityView{
            return App.cities[row].name
        }
        if pickerView == pickerBarView{
            if currCityId != -1{
                return App.cities[currCityId].bars[row].name
            }else{
                return ""
            }
        }
        if pickerView == pickerNumView{
            return numArr[row]
        }
        if pickerView == pickerTimeView{
            if component == 0{
                if arr.count != 0{
                    return "\(arr[row])"
                }else{
                    return ""
                }
                /*if currCityId != -1 && currBarId != -1{
                    return "\(arr[row])"
                }else {
                    return ""
                }*/
            }else{
                return "\(row)"
            }
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
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func setPicker(dtext:UITextField, dpicker: UIView, act: Selector){
        
        //dpicker.datePickerMode = .Date
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
        date = datePicker.date
        dateView.textBox.text = f.stringFromDate(datePicker.date)
        dateView.textBox.resignFirstResponder()
    }
    
    func showSelectedTime(){
        let f = NSDateFormatter()
        f.dateFormat = "HH:mm"
        timeView.textBox.text = f.stringFromDate(timePicker.date)
        timeView.textBox.resignFirstResponder()
    }
    
    func showSelectedCorrectTime(){
        timeView.textBox.resignFirstResponder()
        
        if currCityId == -1 || currBarId == -1{
            return
        }
        let row0 = pickerTimeView.selectedRowInComponent(0)
        let row1 = pickerTimeView.selectedRowInComponent(1)
        
        hours = arr[row0]
        minutes = row1
        
        timeView.textBox.text = "\(arr[row0]):\(row1)"
        
    }
    
    func showSelectedCity(){
        let row = pickerCityView.selectedRowInComponent(0)
        
        if row != currCityId{
            currBarId = -1
            barView.textBox.text = ""
            arr = [Int]()
            hours = -1
            minutes = -1
            timeView.textBox.text = ""
        }
        
        currCityId = row
        cityView.textBox.text = App.cities[row].name
        cityView.textBox.resignFirstResponder()
    }
    func showSelectedBar(){
        barView.textBox.resignFirstResponder()
        
        if currCityId == -1{
            return
        }
        
        let row = pickerBarView.selectedRowInComponent(0)
        
        if row != currBarId {
            arr = [Int]()
            hours = -1
            minutes = -1
            timeView.textBox.text = ""
        }
        
        currBarId = row
        if currCityId != -1{
            barView.textBox.text = App.cities[currCityId].bars[row].name
        }
        setupTime()
        
    }
    
    func showSelectedNum(){
        let row = pickerNumView.selectedRowInComponent(0)
        num = row+1
        numView.textBox.text = numArr[row]
        numView.textBox.resignFirstResponder()
        
        recalcSum()
    }
    
    func recalcSum(){
        if vip{
            sum = ReserveInfo.priceVIP / 100 * (((num-1) / (ReserveInfo.kVIP)) + 1)
        }else{
            sum = ReserveInfo.priceNormal / 100 * (((num-1) / (ReserveInfo.kNormal)) + 1)
        }
        sumView.text = "\(sum) \(App.curr)"
    }

    @IBAction func saveReserve(sender: AnyObject) {
        self.saveBtn.enabled = false
        
        checkValues { (err) -> Void in
            self.saveBtn.enabled = true
            JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
            return
        }
        
        let seconds = Double(hours * 60 * 60 + minutes * 60)
        let fdate = date.dateByAddingTimeInterval(seconds)
        
        /*let f = NSDateFormatter()
        f.dateFormat = "dd.MM.yyyy HH:mm"
        let dstr = f.stringFromDate(fdate)

        print(dstr)*/
        
        APICalls.saveReserve(vip, barid: App.cities[currCityId].bars[currBarId].id, dt: fdate.timeIntervalSince1970, num: num, discr: discrView.textBox.text!, onCompletion: { (bronid) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }) { (err) -> Void in
                self.saveBtn.enabled=true
                JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
        }
        
    }
    
    func checkValues(onError: (String)->Void)->Bool{
        var err = ""
        if num==0{
            err = "Введите число гостей"
        }
        if currCityId == -1{
            err = "Выберите город"
        }
        if currBarId == -1{
            err = "Выберите бар"
        }
        if date.timeIntervalSince1970 == 0{
            err = "Выберите дату"
        }
        
        if hours == -1 || minutes == -1 {
            err = "Выберите время"
        }
        
        let ok = err == ""
        if !ok {
            onError(err)
        }
        return ok
    }
    
    @IBAction func vipChanged(sender: AnyObject) {
        vip = vipView.on
        recalcSum()
    }

}
