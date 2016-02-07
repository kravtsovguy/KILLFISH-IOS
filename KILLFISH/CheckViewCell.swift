//
//  CheckViewCell.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 07.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class CheckViewCell: UITableViewCell {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var numView: UILabel!
    @IBOutlet weak var sumView: UILabel!
    
    
    func setup(item: CheckInfo){
        
        titleView.text = item.title
        priceView.text = "\(item.price/100)"
        numView.text = "\(item.num)"
        sumView.text = "\(item.price/100*item.num)"
    }
    
    /*override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    }*/
    
    /*override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
    }*/
    
}
