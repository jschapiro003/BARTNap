//
//  ScheduleInformation.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/26/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class ScheduleInformation: NSObject {
    
    
    //Legs of a trip
    
    //End destination of the train, needed in ETD to know what train take into account from the whole list
    var legTrainHeadStation:String?
    //End destination of the leg, if there is a transfer it is a different station than legTrainHeadStation
    var legDestination:String?
    //If empty there are no transfers, otherwise is not the last leg.
    var legTransfercode:String?
    //Start time
    var legDestTimeMin:String?
    //Start day
    var legDestTimeDate:String?
    //End day
    var legMaxTrip:Int?
    
    init(legTrainHeadStation: String?, legDestination: String?, legTransfercode: String?){

        self.legTrainHeadStation = legTrainHeadStation
        self.legDestination = legDestination
        self.legTransfercode = legTransfercode
    }

    init(legTrainHeadStation: String?, legDestination: String?, legTransfercode: String?, legDestTimeMin: String?, legDestTimeDate: String?){
        
        //Default values trip can't be shorter than 2 minutes
        self.legMaxTrip = 2
        
        self.legTrainHeadStation = legTrainHeadStation
        self.legDestination = legDestination
        self.legTransfercode = legTransfercode
        self.legDestTimeMin = legDestTimeMin
        self.legDestTimeDate = legDestTimeDate
        
        //Set date and time formats
        //11/02/2014
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        //12:36 AM
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm a"
        //11/02/2014 12:36 AM
        let completeFormatter = NSDateFormatter()
        completeFormatter.dateFormat = "MM/dd/yyyy h:mm a"
        
        let nowDate:NSDate = NSDate()
        let destDate:NSDate = completeFormatter.dateFromString(legDestTimeDate!+" "+legDestTimeMin!)!

        var maxTripTime = destDate.timeIntervalSinceDate(nowDate)
        self.legMaxTrip = Int(maxTripTime / 60.0)
        
        println("interval \(legMaxTrip)")
    }
    
}
