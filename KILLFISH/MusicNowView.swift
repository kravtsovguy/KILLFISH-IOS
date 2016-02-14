//
//  MusicNowView.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 13.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class MusicNowView: UIView {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var artistView: UILabel!
    @IBOutlet weak var statusView: UILabel!
    
    var bar: BarLocationInfo?
    
    func setup(item: MusicPlayInfo?, bar: BarLocationInfo?){
        
        if item == nil{
            self.titleView.text = ""
            self.artistView.text = ""
            self.statusView.text = "Не надейдено близжайших баров"
        }else{
            self.titleView.text = item!.music.title
            self.artistView.text = item!.music.artist
            self.statusView.text = "Сейчас играет"
        }
        
        self.bar = bar
        
        
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        if bar == nil{
            return
        }
        
        let alertController = UIAlertController(title: "Текущая песня", message: "Бар: \(bar!.name)\nРасстояние: \(bar!.distance) м", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        App.musicView.presentViewController(alertController, animated: true, completion: nil)
        
    }

}
