//
//  ScheduleInformation.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/26/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class ScheduleInformation: NSObject {
    
    
    //Get legs of trip form origin to destination
    
    var legTrainHeadStation:String?
    var legDestination:String?
    var legTransfercode:String?

    init(legTrainHeadStation: String?, legDestination: String?, legTransfercode: String?){

        self.legTrainHeadStation = legTrainHeadStation
        self.legDestination = legDestination
        self.legTransfercode = legTransfercode
    }
   
}
