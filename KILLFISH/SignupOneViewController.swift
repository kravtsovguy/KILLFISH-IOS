//
//  SignupOneViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 02.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class SignupOneViewController: NavViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneView: TextBoxView!
    @IBOutlet weak var codeView: TextBoxView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var sendCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImg.image = UIImage(named: "EnterRegistrBackground")
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        //navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Undo, target: nil, action: nil)
        
        phoneView.textBox.delegate = self
        codeView.textBox.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        /*if textField == phoneView.textBox {
            textField.resignFirstResponder()
            
        }else{
            return false
        }*/
        
        //dismissKeyboard()
        return false
    }

}
