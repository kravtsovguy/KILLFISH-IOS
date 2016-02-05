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
        titleLabel.text = "\(item.count) человек"
        textNLabel.text = item.bar
    }
    

}
