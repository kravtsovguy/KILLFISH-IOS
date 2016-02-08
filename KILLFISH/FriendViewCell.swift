//
//  FriendViewCell.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 08.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class FriendViewCell: UITableViewCell {
    
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var levelView: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func setup(item: FriendInfo){
        
        nameView.text = item.name
        switch item.type{
        case "f1":
            levelView.text = "1 уровень"
            break
        case "f2":
            levelView.text = "2 уровень"
            break
        case "f3":
            levelView.text = "3 уровень"
            break
        default:
            break
        }
        
    }
    
}
