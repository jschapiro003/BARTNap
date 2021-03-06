//
//  BARTClient.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 10/18/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

//defines the same key for all urls
var APIKey: String = "QALV-U3SB-I56Q-DT35"

class BARTClient: NSObject, NSXMLParserDelegate {
    
    
    
    var parser:NSXMLParser?
    var parseSuccess:Bool = true
    var stations = Array<Station>()
    
    //station variables to check an XML Elements value
    var stationName:Bool?
    var stationAbbreviation:Bool?
    var stationLatitude:Bool?
    var stationLongitude:Bool?
    
    //parsing flow conrol
    var currentElement:String = ""
    var passData:Bool=false
    var passObject:Bool=false
    var parsingStations:Bool=false
    var parsingSchedules:Bool=false
    var parsingETD:Bool=false
    
    //trip items existence and params
    var origin: String?
    var dest: String?
    var legFound:Bool?=false
    var legDestination: String?
    var legTrainHeadStation: String?
    var legTransfercode: String?
    var legDestTimeMin:String?
    var legDestTimeDate:String?
    var tripData:ScheduleInformation?
    var legs = Array<ScheduleInformation>()
    
    //temporary variables to hold the current value of a station property
    var currentStationName:String?
    var currentAbbreviationName:String?
    var currentLatitudeName:String?
    var currentLongitudeName:String?
    
    class var sharedInstance: BARTClient {
        struct Static{
            static let instance =  BARTClient()
        }
        return Static.instance
    }
    
    
    
    func getStations()->Array<Station>{
       
        parser = NSXMLParser(contentsOfURL: NSURL(string:"http://api.bart.gov/api/stn.aspx?cmd=stns&key="+APIKey ))!
        println(parser)
        if let xmlParser = parser?{
            xmlParser.delegate = self
            xmlParser.parse()
        }
        
        return stations
        
    }
    
    /*Gets array of legs of schedule according given origin and destination stations abbr
    each element of array has
    var legTrainHeadStation:String?
    var legDestination:String?
    var legTransfercode:String?
    */
    func getScheduleInfo( origin: String!, dest: String!)->Array<ScheduleInformation>{
        
        //Empty legs
        legs = Array<ScheduleInformation>()
        
        self.origin = origin
        self.dest = dest
        //takes only one route before (b=1&a=0), it assumes that passenger is already on train, so the actual train is the last one
        /* Information about API response
        bikeflag: 1 = bikes allowed. 0 = no bikes allowed. transfercode: blank = no transfer, N = normal transfer, T = timed transfer, connecting trains will wait up to five minutes for transferring passengers. S = scheduled transfer, connecting trains will not wait for transferring passengers if there is a delay.*/
        var url: String = "http://api.bart.gov/api/sched.aspx?cmd=depart&orig="+origin+"&dest="+dest+"&date=now&key="+APIKey+"&b=1&a=0"
        println(url)
        parser = NSXMLParser(contentsOfURL: NSURL(string: url))!
        
        println(parser)
        if let xmlParser = parser?{
            xmlParser.delegate = self
            xmlParser.parse()
        }
        
        return legs
    }
    
    
    func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI: String!, qualifiedName : String!, attributes attributeDict: NSDictionary!) {
        
        
        currentElement=elementName;
        
    //Parsing stations
        if(elementName=="stations" || elementName=="station" || elementName=="name" || elementName=="abbr" || elementName=="gtfs_latitude" || elementName=="gtfs_longitude")
        {
            //Establish the parsing in process
            if(elementName=="stations"){
                parsingStations=true
            }
            
            if(elementName=="station" && parsingStations){
                passObject=true
            }
            passData=true
            //check to see if the staion name element exists
            self.stationName = (elementName == "name")
        
            //check to see if station abbreviation exists
            self.stationAbbreviation = (elementName == "abbr")
        
            //check to see if gtfs latitude exists
            self.stationLatitude = (elementName == "gtfs_latitude")
        
            //check to see if gtfs longitude exists
            self.stationLongitude = (elementName == "gtfs_longitude")
            }
        
    //Parsing schedules
        if(elementName=="schedule" || elementName=="trip"  || elementName=="leg")
        {
            //Establish the parsing in process
            if(elementName=="schedule"){
                parsingSchedules=true
            }
            //Start collecting legs, there is a trip
            if(elementName=="trip" && parsingSchedules){
                passObject=true
            }
            passData=true
            //get attributes of the leg, this one doesn't work with foundCharacters func
            if(elementName=="leg" && parsingSchedules){
                legFound=true
                legDestination = attributeDict["destination"] as String?
                legTrainHeadStation = attributeDict["trainHeadStation"] as String?
                legTransfercode = attributeDict["transfercode"] as String?
                legDestTimeMin = attributeDict["destTimeMin"] as String?
                legDestTimeDate = attributeDict["destTimeDate"] as String?
                println("Leg destination \(legDestination)"+" trainhead \(legTrainHeadStation)"+" transfercode \(legTransfercode) destTime \(legDestTimeMin)")
            }
        }
    }

func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
    currentElement="";
    
    //ended for parsing stations
    if(elementName=="stations" || elementName=="station" || elementName=="name" || elementName=="abbr" || elementName=="gtfs_latitude" || elementName=="gtfs_longitude")
    {
        if(elementName=="station" && parsingStations){
            passObject=false
            //create new station and populate it
            var station:Station = Station(name: currentStationName, abbreviation: currentAbbreviationName, latitude: currentLatitudeName, longitude: currentLongitudeName)
            // add that station to the stations array
            stations.append(station)
        }
        passData=false
        //Parsing stations ended
        if(elementName=="stations"){
            parsingStations=false
        }
    }
    
    //ended for parsing Schedules
    if(elementName=="schedule" || elementName=="trip"  || elementName=="leg")
    {
        if(elementName=="leg" && parsingSchedules){
            passObject=false
            //create new leg and populate it
            var leg:ScheduleInformation = ScheduleInformation(legTrainHeadStation: legTrainHeadStation, legDestination: legDestination, legTransfercode: legTransfercode, legDestTimeMin: legDestTimeMin, legDestTimeDate: legDestTimeDate)
            // add that leg to the legs array
            legs.append(leg)
        }
        passData=false
        //Parsing Schedules ended
        if(elementName=="schedule"){
            parsingSchedules=false
        }
    }
    
}


    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if(passObject){
            
            if (parsingStations) {
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
            }
        }
        
    }
    
    func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        NSLog("failure error: %@", parseError)
    }
    
    
    
}