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
    
    var tripData:ScheduleInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            
            self.stationsArray = BARTClient.sharedInstance.getStations()
            self.tripData = BARTClient.sharedInstance.getScheduleInfo("DBRK",dest:"ROCK")
            
            
           
            
            
        });
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("hello world")
        
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