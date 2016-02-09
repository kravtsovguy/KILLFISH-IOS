//
//  NewsItemViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 01.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class NewsItemViewController: NavViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var item:NewsInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        titleLabel.text = "Новость"
        textView.text = "Текст"
        
        if item==nil { return }
        setup(item)
    }
    
    func setup(item: NewsInfo) {
        title =  item.dayAndMonthAndYear
        titleLabel.text = item.title
        textView.text = item.textPage
        //imageView.image = UIImage()
        imageView.downloadedFrom(link: item.imageUrl)
        //textView.userInteractionEnabled = true
        //imageView.fromURL(item.imageUrl)
        //webView.loadHTMLString(item.textWeb, baseURL: nil)
    }

}
