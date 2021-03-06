//
//  HomeViewController.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/29/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

protocol SendDataDelegate{
    
    func passStationsArray(array: Array<Station>)
    
}

class HomeViewController: UIViewController {
    
    
    //delegate to send the stations array to the UIPickerView of the TakeANapViewController :)
    var delegate:SendDataDelegate? = nil
    
    
    var stationsArray = Array<Station>()
    
    //Variable to get legs of the trip for testing, can be removed later
    var legsArray = Array<ScheduleInformation>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var progressHud = MBProgressHUD(view: self.view)
        self.view.addSubview(progressHud)
        progressHud.labelText = "Loading"
        progressHud.show(true);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            
            self.stationsArray = BARTClient.sharedInstance.getStations()            
        });
        
        progressHud.hide(true)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTakeANap"{
            delegate = segue.destinationViewController as TakeANapViewController
            
            delegate?.passStationsArray(stationsArray)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}