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
    @IBOutlet weak var timeTableWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        timeTableWebView.loadRequest(request)
        // Do any additional setup after loading the view.
        
        self.view = self.timeTableWebView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
