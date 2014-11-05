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
    
    //View Outlets
    @IBOutlet weak var fromPickerView: UIPickerView!
   
    @IBOutlet weak var toPickerView: UIPickerView!
    
    @IBOutlet weak var minutesTextField: UITextField!
    
    @IBAction func minutestyped(sender: AnyObject) {
        //Pending creation of validation of time
    }
    
    @IBAction func startPressed(sender: AnyObject) {
        
    }
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
                //println("station name:\(sn)")
            }
        if let sa = station.abbreviation?{
                //println("station abbreviation \(sa)")
            }
        
        }
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
            //Assing next view controller in segue
            self.RemainingNapTimeVC = segue.destinationViewController as? RemainingNapTimeViewController

            //Give default values if user don't touch picker view
            if originSelected == nil {
                originSelected = stationsArray[0].abbreviation
            }
            if destSelected == nil {
                destSelected = stationsArray[0].abbreviation
            }
            
           
            
            
            //schedules parsing
            self.legsArray = BARTClient.sharedInstance.getScheduleInfo(originSelected!, dest: destSelected!)
            
            
            

            //This is the time selected
            println("minutes previous \(self.minutesTextField.text)")
            
            
            //implicitly unwrapped legMaxTrip! could cause crash?
            var calculatedNapTime = self.legsArray[0].legMaxTrip! - 60*self.minutesTextField.text.toInt()!
           
            
            println("Leg Max Trip: \(self.legsArray[0].legMaxTrip!/60)")
            println("Nap time \(calculatedNapTime)")
            
            //set alert if there is a transfer before destination selected
            var thereIsTransfer:Bool = true
            if self.legsArray[0].legTransfercode == "" {thereIsTransfer=false}
            
            //Get station destination full name
            var destinationName:String = ""
            for station in stationsArray{
                if self.legsArray[0].legDestination == station.abbreviation?{
                    destinationName = station.name!
                }
            }
            
            self.RemainingNapTimeVC?.passNapData(originSelected!, destination: destSelected!, napTime: calculatedNapTime, stopStation: self.legsArray[0].legDestination!, stopStationName: destinationName, transfer: thereIsTransfer)

        }
    }
}


//if the nap time is < 0 


