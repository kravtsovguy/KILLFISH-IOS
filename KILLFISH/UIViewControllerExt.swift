//
//  UIViewControllerExt.swift
//  KILLFISH
//
//  Created by Matvey Kravtsov on 26.06.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}