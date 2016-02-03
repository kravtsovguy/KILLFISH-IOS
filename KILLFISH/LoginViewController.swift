//
//  LoginViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 31.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class LoginViewController: NavViewController {

    @IBOutlet weak var numView: TextBoxView!
    @IBOutlet weak var codeView: TextBoxView!
    
    @IBOutlet weak var loginBtn: UIButton!
    var textBoxes: [UITextField]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        numView.textBox.delegate = self
        codeView.textBox.delegate = self
        textBoxes = [numView.textBox,codeView.textBox]
        
        numView.textBox.keyboardType = .PhonePad
        codeView.textBox.keyboardType = .NumberPad
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignupPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("goto_signup", sender: self)
    }

    @IBAction func loginPressed(sender: UIButton) {
        
        loginBtn.enabled=false
        
        APICalls.login(App.getCorrectPhone(numView.textBox.text!), code: codeView.textBox.text!, onCompletion: { (ok) -> Void in
            if ok {
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                //self.dismissViewControllerAnimated(true, completion: nil)
            }
            }, onError: { (err) in
                self.loginBtn.enabled=true
                JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
        })
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        //numView.textBox.text = ""
        //codeView.textBox.text = ""
        
        self.loginBtn.enabled = true
        
    }
    
    
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        numView.textBox.resignFirstResponder()
        codeView.textBox.resignFirstResponder()
        view.endEditing(true)
    }
    */
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //let nextTage=textField.tag+1;
        // Try to find next responder
        //let nextResponder=textField.superview?.viewWithTag(nextTage) as UIResponder!
        let ind = textBoxes.indexOf(textField)!
        
        if (ind < textBoxes.count-1){
            // Found next responder, so set it.
            textBoxes[ind+1].becomeFirstResponder()
        }
        else
        {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        
        //dismissKeyboard()
        return false
    }
    /*
    var kbHeight: CGFloat!
    
    var kVisible = false
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if kVisible {return}
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height/2
                self.animateTextField(true)
            }
        }
        kVisible=true
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
        kVisible=false
    }
    
    func animateTextField(up: Bool) {
        let movement = (up ? -kbHeight : kbHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
