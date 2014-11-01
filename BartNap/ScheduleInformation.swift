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

    init(legTrainHeadStation: String?, legDestination: String?, legTransfercode: String?){

        self.legTrainHeadStation = legTrainHeadStation
        self.legDestination = legDestination
        self.legTransfercode = legTransfercode
    }
   
}
