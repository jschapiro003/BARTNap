//
//  RemainingNapTimeViewController.swift
//  BartNap
//
//  Created by Isabel Yepes on 2/11/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit



class RemainingNapTimeViewController: UIViewController, SendNapParams, MZTimerLabelDelegate {


    @IBOutlet weak var destinationStationLabel: UILabel!

    @IBOutlet weak var counterLabel: UILabel!
    
    var orig:String?
    var dest:String?
    var legStopStation:String?
    var stopStationLongName:String?
    var minutes:Int?
    var transferAlert:Bool?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.destinationStationLabel.text = self.stopStationLongName
        
        var mycountdownTimer = MZTimerLabel(label: counterLabel, andTimerType: MZTimerLabelTypeTimer)
        
        mycountdownTimer.timeLabel.textColor = UIColor.blueColor()
        mycountdownTimer.setCountDownTime(Double(minutes!))
        mycountdownTimer.delegate = self
        mycountdownTimer.start()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.destinationStationLabel.text = self.stopStationLongName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func timerLabel(timerLabel: AnyObject!, finshedCountDownTimerWithTime countTime: NSTimeInterval){
        performSegueWithIdentifier("openAllDone", sender: self)
        
    }
    
    func passNapData(origin: String, destination: String, napTime: Int, stopStation: String, stopStationName: String, transfer: Bool) {
        self.orig = origin
        self.dest = destination
        self.minutes = napTime
        self.legStopStation = stopStation
        self.stopStationLongName = stopStationName
        self.transferAlert = transfer
    }
}
