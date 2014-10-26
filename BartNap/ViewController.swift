//
//  ViewController.swift
//  SwiftXMLParsingDemo
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {
    
    var strXMLData:String = ""
    var currentElement:String = ""
    var passData:Bool=false
    var passName:Bool=false
    
    
    
    let parser:NSXMLParser? = NSXMLParser(contentsOfURL: NSURL(string:"http://api.bart.gov/api/stn.aspx?cmd=stns&key=QALV-U3SB-I56Q-DT35" ))
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
        
        
        /*var url:String="http://api.bart.gov/api/route.aspx?cmd=routes&key=MW9S-E7SL-26DU-VV8V"*/
        var url:String="http://api.bart.gov/api/stn.aspx?cmd=stns&key=QALV-U3SB-I56Q-DT35"
        var urlToSend: NSURL = NSURL(string: url)
        // Parse the XML
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            var parser = NSXMLParser(contentsOfURL: urlToSend)
            parser.delegate = self
        
            var success:Bool = parser.parse()
        
            if success {
                println("parse success!")
            
                println(self.strXMLData)
            
            //lblNameData.text=strXMLData
            
            } else {
                println("parse failure!")
            }
        })
        
        
        /*if let xmlParser:NSXMLParser = self.parser? {
            
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
        println("no longer in the background")*/
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
/*    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
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
        
        
    }*/
    
    func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        NSLog("failure error: %@", parseError)
    }
    
    
    func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI: String!, qualifiedName : String!, attributes attributeDict: NSDictionary!) {
        currentElement=elementName;
        if(elementName=="station" || elementName=="name" || elementName=="abbr" || elementName=="gtfs_latitude" || elementName=="gtfs_longitude")
        {
            if(elementName=="station"){
                passName=true;
            }
            passData=true;
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        currentElement="";
        if(elementName=="station" || elementName=="name" || elementName=="abbr" || elementName=="gtfs_latitude" || elementName=="gtfs_longitude")
        {
            if(elementName=="station"){
                passName=false;
            }
            passData=false;
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if(passName){
            strXMLData=strXMLData+"\n\n"+string
        }
        
        if(passData)
        {
            println(string)
        }
    }
    
}