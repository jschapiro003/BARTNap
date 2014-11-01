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
    
    
    var origin:String?
    var destination:String?
    var leg:String?
    var trip:String?

    init(origin: String?, destination: String?, leg: String?){
        
        self.origin = origin
        self.destination = destination
        self.leg = leg
        
    }
    
    func newSchedule(legFound:Bool?, elementName: String){
        
    }
   
}
