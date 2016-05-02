//
//  PayViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 12.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

class PayViewController: NavViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        //super.viewWillAppear(animated)
        
        let url = NSURL (string: "https://paymentgateway.ru/pgw/?project=10387&nickname=7777777\(App.user.id)")
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
        
       
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let currentURL : NSString = (webView.request?.URL!.absoluteString)!
        if currentURL == "http://killfish.ru/succod.php" || currentURL == "http://killfish.ru/fail.php"{
            navigationController?.popViewControllerAnimated(true)
        }
    }

}
