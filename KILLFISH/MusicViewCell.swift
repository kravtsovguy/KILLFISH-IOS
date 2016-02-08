//
//  MusicViewCell.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 07.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class MusicViewCell: UITableViewCell {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var artistView: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func setup(item: MusicInfo){
        
        titleView.text = item.title
        artistView.text = item.artist
        
        if item.lastBuy == 0 {
            imgView.image = UIImage(named: "Buy")
            return
        }
        var time: Double = NSDate().timeIntervalSince1970 - item.lastBuy
        time /= 60
        if time <= 20{
            imgView.image = UIImage(named: "Check")
        }
    }

    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
