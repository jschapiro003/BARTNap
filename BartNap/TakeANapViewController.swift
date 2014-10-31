//
//  TakeANapViewController.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/30/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

var stationsArray = Array<Station>()

class TakeANapViewController: UIViewController, UIPickerViewDelegate, SendDataDelegate{

   
    
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
    
}





