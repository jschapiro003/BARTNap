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
var minSelected:String?

protocol SendNapParams{
    
    func passNapData(origin: String, destination: String, napTime: Int, stopStation: String, stopStationName: String, transfer: Bool)
    
}


class TakeANapViewController: UIViewController, UIPickerViewDelegate, SendDataDelegate{

    //Variable to get legs of the trip
    var legsArray = Array<ScheduleInformation>()
    //Instantiate next View Controller
    var RemainingNapTimeVC: RemainingNapTimeViewController? = nil
    //Nap calculations
    var calculatedNapTimeManual:Int = 300
    var thereIsTransfer:Bool = true
    var destinationName:String = ""
    //Vars for user defaults view
    var settingsViewController:SettingsViewController?
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

    
    //View Outlets
    @IBOutlet weak var fromPickerView: UIPickerView!
   
    @IBOutlet weak var toPickerView: UIPickerView!
    
    @IBOutlet weak var minutesTextField: UITextField!
    
    @IBAction func minutestyped(sender: AnyObject) {
        //Validation done in start button
    }
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBAction func startPressedManual(sender: AnyObject) {
        
        //Give default values if user don't touch picker view
        if originSelected == nil {
            originSelected = stationsArray[0].abbreviation
        }
        if destSelected == nil {
            destSelected = stationsArray[0].abbreviation
        }
        
        //schedules parsing
        self.legsArray = BARTClient.sharedInstance.getScheduleInfo(originSelected!, dest: destSelected!)
        
        if minutesTextField.text.toInt() < 2 {
            //Minutes prior station no less than 5.
            warningLabel.text = "Minimun prior time is 2 minutes"
        } else {
            if !self.legsArray.isEmpty {
                //If there are legs, use first one
                calculatedNapTimeManual = self.legsArray[0].legMaxTrip! - 60*self.minutesTextField.text.toInt()!
                //set alert if there is a transfer before destination selected
                if self.legsArray[0].legTransfercode == "" {
                    thereIsTransfer=false
                } else {
                    thereIsTransfer=true
                }
                //Get station destination full name
                for station in stationsArray{
                    if self.legsArray[0].legDestination == station.abbreviation?{
                        destinationName = station.name!
                    }
                }
                if calculatedNapTimeManual > 300 {
                    println("Go to Nap: \(calculatedNapTimeManual) seconds")
                    
                    //Check OK, open counter
                    performSegueWithIdentifier("openNapCounterManual", sender: self)
                } else {
                    var transferAlert:String = ""
                    if thereIsTransfer {
                        transferAlert = "your transfer in "
                    }
                    warningLabel.text = "Travel to "+transferAlert+"\(destinationName) is shorter than 7 minutes. Not enough for a 5 minutes Nap"
                }
            } else {
                //If there are no legs, warn user.
                warningLabel.text = "Trip can't be calculated"
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Empty warnings
        warningLabel.text = ""
        
        // Load favorite trip
        if let tripOrigin = defaults.objectForKey("originSelected") as? String{
            println("saved origin:\(tripOrigin)")
            originSelected = tripOrigin
            if let rowOriginSelected = defaults.objectForKey("rowOriginSelected") as? Int {
                fromPickerView.selectRow(rowOriginSelected, inComponent: 0, animated: false)
            }
        }
        if let tripDestination = defaults.objectForKey("destinationSelected") as? String{
            println("saved destination: \(tripDestination)")
            destSelected = tripDestination
            if let rowDestSelected = defaults.objectForKey("rowDestSelected") as? Int {
                toPickerView.selectRow(rowDestSelected, inComponent: 0, animated: false)
            }
        }
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func passStationsArray(array: Array<Station>) {
        stationsArray = array
    
        /*//List stations
        for station in stationsArray{
            if let sn = station.name?{
                println("station name:\(sn)")
            }
        if let sa = station.abbreviation?{
                println("station abbreviation \(sa)")
            }
        
        }*/
    }

    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stationsArray.count
      
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return stationsArray[row].name
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Reset previous warnings
        warningLabel.text = ""
        //Gets the stations selected in pickerviews
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
        
        //Prepare for counter
        if segue.identifier == "openNapCounterManual" {
            //Assing next view controller in segue
            RemainingNapTimeVC = segue.destinationViewController as? RemainingNapTimeViewController
            //Pass params to protocol
            RemainingNapTimeVC?.passNapData(originSelected!, destination: destSelected!, napTime: calculatedNapTimeManual, stopStation: self.legsArray[0].legDestination!, stopStationName: destinationName, transfer: thereIsTransfer)
            
        }
        
        if segue.identifier == "showFavorites"{
            
            self.settingsViewController = segue.destinationViewController as? SettingsViewController
            settingsViewController?.stationsArray = stationsArray
           
        }
    }
    
    
}



