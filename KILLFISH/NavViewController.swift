//
//  NavViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 31.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NavViewController: UIViewController, UITextFieldDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //title = "Something"
        setupBackground()
        //setupTopView()
    }
    
    var backImg: UIImageView!
    
    func setupBackground()
    {
        let img = UIImageView(image: UIImage(named: "MainBackground"));
        img.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        //img.layer.zPosition = -1;
        view.addSubview(img)
        view.sendSubviewToBack(img)
        
        let lc = NSLayoutConstraint(item: img, attribute:
            .Leading, relatedBy: .Equal, toItem: view,
            attribute: .Leading, multiplier: 1.0,
            constant: 0)
        
        let rc = NSLayoutConstraint(item: img, attribute:
            .Trailing, relatedBy: .Equal, toItem: view,
            attribute: .Trailing, multiplier: 1.0,
            constant: 0)
        
        let tc = NSLayoutConstraint(item: img, attribute:
            .Top, relatedBy: .Equal, toItem: view,
            attribute: .Top, multiplier: 1.0,
            constant: 0)
        
        let bc = NSLayoutConstraint(item: img, attribute:
            .Bottom, relatedBy: .Equal, toItem: view,
            attribute: .Bottom, multiplier: 1.0,
            constant: 0)
        
        NSLayoutConstraint.activateConstraints([lc,rc,tc,bc])
        
        backImg = img
        
    }
    
    func setupTopView()
    {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 64));
        topView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2);
        view.addSubview(topView)
        
        let lc = NSLayoutConstraint(item: topView, attribute:
            .LeadingMargin, relatedBy: .Equal, toItem: view,
            attribute: .LeadingMargin, multiplier: 1.0,
            constant: 0)
        
        let rc = NSLayoutConstraint(item: topView, attribute:
            .TrailingMargin, relatedBy: .Equal, toItem: view,
            attribute: .TrailingMargin, multiplier: 1.0,
            constant: 0)
        
        let tc = NSLayoutConstraint(item: topView, attribute:
            .TopMargin, relatedBy: .Equal, toItem: view,
            attribute: .TopMargin, multiplier: 1.0,
            constant: 0)
        
        let hc = NSLayoutConstraint(item: topView, attribute:
            .Height, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0,
            constant: 64)
        
        NSLayoutConstraint.activateConstraints([lc,rc,tc,hc])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
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
        
        //self.navigationController?.setNavigationBarHidden(up, animated: true)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }

}
