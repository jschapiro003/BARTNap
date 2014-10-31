//
//  BARTClient.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/18/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class BARTClient: NSObject, NSXMLParserDelegate {
    
    
    
    var parser:NSXMLParser?
    var parseSuccess:Bool = true
    var stations = Array<Station>()
    
    //station variables to check an XML Elements value
    var stationName:Bool?
    var stationAbbreviation:Bool?
    var stationLatitude:Bool?
    var stationLongitude:Bool?
    
    class var sharedInstance: BARTClient {
        struct Static{
            static let instance =  BARTClient()
        }
        return Static.instance
    }
    
    
    
    func getStations()->Array<Station>{
        
       
        parser = NSXMLParser(contentsOfURL: NSURL(string:"http://api.bart.gov/api/stn.aspx?cmd=stns&key=QALV-U3SB-I56Q-DT35" ))!
        println(parser)
        if let xmlParser = parser?{
            xmlParser.delegate = self
            xmlParser.parse()
        }
        
        
        return stations
        
    }
    
    func getScheduleInfo(){
        
        parser = NSXMLParser(contentsOfURL: NSURL(string: "http://api.bart.gov/api/route.aspx?cmd=routes&key=MW9S-E7SL-26DU-VV8V"))!
        
    }
    
    
    func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI: String!, qualifiedName : String!, attributes attributeDict: NSDictionary!) {
        
        
        
        //check to see if the staion name element exists
        self.stationName = (elementName == "name")
        
        //check to see if station abbreviation exists
        self.stationAbbreviation = (elementName == "abbr")
        
        //check to see if gtfs latitude exists
        self.stationLatitude = (elementName == "gtfs_latitude")
        
        //check to see if gtfs longitude exists
        self.stationLongitude = (elementName == "gtfs_longitude")
        
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        //temporary variables to hold the current value of a station property
        var currentStationName:String?
        var currentAbbreviationName:String?
        var currentLatitudeName:String?
        var currentLongitudeName:String?
        
        //grab each station
        if let stationFound = self.stationName?{
            if(stationFound){
                //println("Name:\(string)")
                currentStationName = string
            }
        }
        
        //grab each station abbreviation
        if let abbreviationFound = self.stationAbbreviation?{
            if (abbreviationFound){
                //println("Abbrv: \(string)")
                currentAbbreviationName = string
            }
        }
        
        //grab each station latitude
        if let latitudeFound = self.stationLatitude?{
            if (latitudeFound){
                //println("latitude: \(string)")
                currentLatitudeName = string
            }
        }
        
        //grab each station longitude
        if let longitudeFound = self.stationLongitude{
            if (longitudeFound){
                //println("longitude: \(string)")
                currentLongitudeName = string
            }
        }
        
        //create new station and populate it
        
        var station:Station = Station(name: currentStationName, abbreviation: currentAbbreviationName, latitude: currentLatitudeName, longitude: currentLongitudeName)
        
        // add that station to the stations array
        stations.append(station)
        
        
    }
    
    func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        NSLog("failure error: %@", parseError)
    }
    
    
    
}