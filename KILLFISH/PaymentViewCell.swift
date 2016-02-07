//
//  PaymentViewCell.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 06.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class PaymentViewCell: UITableViewCell {
    
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func setup(item: PaymentInfo){
        
        dateView.text = item.dayAndMonth
        var str = ""
        if item.type == "writeoff"{
            str="-"
            imgView.image = UIImage(named: "FoodGen")
        }
        if item.type == "income"{
            str="+"
            imgView.image = UIImage(named: "Card")
        }
        if item.type == "bonus"{
            str="+"
            imgView.image = UIImage(named: "Star")
        }
        titleView.text = "\(str)\(abs(item.sum/100)) \(App.currency[item.curr]!)"
        textView.text = item.discr
        
    }
}
