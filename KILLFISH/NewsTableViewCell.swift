//
//  NewsTableViewCell.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 31.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var newsIco: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textNLabel: UILabel!
    
    func setup(item:NewsInfo) {
        dataLabel.text = item.dayAndMonth
        titleLabel.text = item.title
        textNLabel.text = item.textPage
    }
    

}
