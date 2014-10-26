//
//  ViewController.swift
//  SwiftXMLParsingDemo
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {
    
    let parser = NSXMLParser(contentsOfURL: NSURL(string:"http://api.bart.gov/api/stn.aspx?cmd=stns&key=QALV-U3SB-I56Q-DT35" ))
    var parseSuccess:Bool = true
    var stations = Array<Station>()
    
    //station variables to check an XML Elements value
    var stationName:Bool?
    var stationAbbreviation:Bool?
    var stationLatitude:Bool?
    var stationLongitude:Bool?
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        // we will allow users to enter there origin and destination based on a list of stations 
        //there answers will give the requirements for a call to the schedule info API
        //we will pass these values along next view controller, where timer calculations will be done
        
        
        
        if let xmlParser = parser?{

            xmlParser.delegate = self

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                
                    self.parseSuccess = xmlParser.parse()
                    for station in self.stations{
                        if let sn = station.name?{
                            println("station name:\(sn)")
                        }
                        if let sa = station.abbreviation?{
                            println("station abbreviation \(sa)")
                        }

                    }
                
                })
        }
        println("no longer in the background")
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
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
                // println("Name:\(string)")
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