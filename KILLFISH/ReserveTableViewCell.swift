//
//  ReserveTableViewCell.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 04.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class ReserveTableViewCell: UITableViewCell {

    
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textNLabel: UILabel!
    
    func setup(item: ReserveInfo) {
        dataLabel.text = item.dayAndMonth
        timeLabel.text = item.timeHM
        
        textNLabel.text = item.bar
        
        var str = ""
        if item.status == 0{
            str = "активно"
        }
        if item.status == 1{
            str = "отменено"
        }
        if item.status == 2{
            str = "выполнено"
        }
        if item.status == 5{
            str = "в работе"
        }
        titleLabel.text = "\(item.count) человек"+" (\(str))"
        
    }
    

}
