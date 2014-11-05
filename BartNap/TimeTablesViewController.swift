//
//  TimeTablesViewController.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 11/3/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class TimeTablesViewController: UIViewController {

    let url = "http://www.bart.gov/schedules/bystation"
    
    @IBOutlet weak var timeTablesWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        timeTablesWebView.loadRequest(request)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
