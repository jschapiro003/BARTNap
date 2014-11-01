//
//  Station.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/21/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class Station: NSObject {
    
    let endPoint:String = "http://api.bart.gov/api/stn.aspx?cmd=stns&key="+APIKey
    //properties of a station
    var name: String?
    var abbreviation: String?
    var latitude: String?
    var longitude: String?
    
    //variables used to grab the value of an element in XML
    
    
    var nameFound:Bool?
    var abbreviationFound:Bool?
    var latitudeFound:Bool?
    var longitudeFound:Bool?
    
    init(name: String?, abbreviation: String?, latitude: String?, longitude: String?){
        
        self.name = name
        self.abbreviation = abbreviation
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    func newStation(nameFound:Bool?, abbreviationFound: Bool?, latitudeFound: Bool?, longitudeFound: Bool?, elementName: String){
        
        
    }
}
