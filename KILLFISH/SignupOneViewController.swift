//
//  SignupOneViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 02.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class SignupOneViewController: NavViewController {

    @IBOutlet weak var phoneView: TextBoxView!
    @IBOutlet weak var codeView: TextBoxView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var sendCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImg.image = UIImage(named: "EnterRegistrBackground")
        
        phoneView.textBox.keyboardType = .PhonePad
        codeView.textBox.keyboardType = .NumberPad
        
        //navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Undo, target: nil, action: nil)
        
        phoneView.textBox.delegate = self
        codeView.textBox.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func sendCodePressed(sender: AnyObject) {
    }
    
    var preId = 0
    var num = ""
    
    var two = false
    @IBAction func nextPressed(sender: AnyObject) {
        
        nextButton.enabled = false
        if two == false{
            
            //self.codeView.hidden = false
            //self.sendCode.hidden = false
            let mphone = phoneView.textBox.text!.stringByReplacingOccurrencesOfString("+", withString: "")
            APICalls.registerOne(mphone, onCompletion: { (id, next, num) -> Void in
                self.preId = id
                self.num = num
                
                if next=="code"{
                    self.codeView.hidden = false
                    self.sendCode.hidden = false
                    self.phoneView.textBox.enabled = false
                    self.nextButton.enabled = true
                }else{
                    self.toSignupTwo()
                }
                
                }, onError: { err in
                    self.nextButton.enabled = true
            })
            two=true
        }else{
            APICalls.registerTwo(preId, code: Int(codeView.text)!, onCompletion: { (id, next, num) -> Void in
                
                self.preId = id
                self.num = num
                self.toSignupTwo()
                
                }, onError: { err in
                    self.nextButton.enabled = true
            })
            
        }
        
    }
    
    func toSignupTwo()
    {
        self.performSegueWithIdentifier("goto_signup_two", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_signup_two" {
            let vc = segue.destinationViewController as! SignupTwoViewController
            vc.preId = preId
            vc.num = num
        }
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        //phoneView.textBox.text = ""
        //codeView.textBox.text = ""
        
    }
    
    override func viewDidDisappear(animated:Bool) {
        super.viewDidDisappear(animated)
        
        //phoneView.textBox.text = ""
        //codeView.textBox.text = ""
        
        self.codeView.hidden = true
        self.sendCode.hidden = true
        self.phoneView.textBox.enabled = true
        self.nextButton.enabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return false
    }*/

}
