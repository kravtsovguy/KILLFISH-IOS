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
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    func setup(item: ReserveInfo) {
        dataLabel.text = item.dayAndMonth
        timeLabel.text = item.timeHM
        
        textNLabel.text = item.bar
        
        var str = ""
        var imgName = "ApprovedBook"
        if item.status == 0{
            str = "активно"
            imgName = "InProcessBook"
        }
        if item.status == 1{
            str = "отменено"
            imgName = "CanceledBook"
        }
        if item.status == 2{
            str = "выполнено"
            imgName = "ApprovedBook"
        }
        if item.status == 5{
            str = "в работе"
            imgName = "InProcessBook"
        }
        titleLabel.text = "\(item.count) чел"
        statusLabel.text = str
        statusImage.image = UIImage(named: imgName)
        
    }
    

}
