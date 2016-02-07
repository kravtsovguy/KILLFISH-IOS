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
    
    func setup(item: MusicInfo){
        
        titleView.text = item.title
        artistView.text = item.artist
        
        
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
