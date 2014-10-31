//
//  TakeANapViewController.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/30/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class TakeANapViewController: UIViewController, SendDataDelegate{

    var stationsArray = Array <Station>()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func passStationsArray(array: Array<Station>) {
        stationsArray = array
    
        for station in self.stationsArray{
            if let sn = station.name?{
                println("station name:\(sn)")
            }
        if let sa = station.abbreviation?{
                println("station abbreviation \(sa)")
            }
        
        }
    }

    
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


