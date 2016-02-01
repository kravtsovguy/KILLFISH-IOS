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
    @IBOutlet weak var webView: UIWebView!
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
        setup(item)
    }
    
    func setup(item: NewsInfo) {
        title =  item.dayAndMonthAndYear
        titleLabel.text = item.title
        webView.loadHTMLString(item.text, baseURL: nil)
    }

}
