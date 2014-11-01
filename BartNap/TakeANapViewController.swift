//
//  TakeANapViewController.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/30/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

var stationsArray = Array<Station>()
var originSelected:String?
var destSelected:String?

class TakeANapViewController: UIViewController, UIPickerViewDelegate, SendDataDelegate{

    //Variable to get legs of the trip
    var legsArray = Array<ScheduleInformation>()
    
    @IBOutlet weak var fromPickerView: UIPickerView!
   
    @IBOutlet weak var toPickerView: UIPickerView!
    
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
    
        for station in stationsArray{
            if let sn = station.name?{
                println("station name:\(sn)")
            }
        if let sa = station.abbreviation?{
                println("station abbreviation \(sa)")
            }
        
        }
    }

    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stationsArray.count
        //return 12
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return stationsArray[row].name
        //return "fila \(row)"
    }
    
    //Gets the stations selected in pickerviews
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var itemSelected = stationsArray[row].abbreviation
        if pickerView == fromPickerView {
            originSelected = itemSelected
            println("Selected origin \(itemSelected)")
        } else if pickerView == toPickerView {
            destSelected = itemSelected
            println("Selected destination \(itemSelected)")
        }
    }
    
    //Get legs according selected stations
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "openNapCounter" {

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                
                //schedules parsing
                self.legsArray = BARTClient.sharedInstance.getScheduleInfo(originSelected!, dest: destSelected!)
                
            });
            
        }
    }
}





