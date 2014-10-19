
//
//  ViewController.swift
//  SwiftXMLParsingDemo
//

import UIKit

class ViewController: UIViewController,NSXMLParserDelegate {
    
    var strXMLData:String = ""
    var currentElement:String = ""
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url:String="http://api.androidhive.info/pizza/?format=xml"
        var urlToSend = NSURL(string: "http://api.bart.gov/api/sched.aspx?cmd=arrive&orig=ASHB&dest=CIVC&date=now&key=QALV-U3SB-I56Q-DT35&b=2&a=2&l=1")
        // Parse the XML
        var parser:NSXMLParser = NSXMLParser(contentsOfURL: urlToSend)!
        parser.delegate = self
        
        var success:Bool = parser.parse()
        
        if success {
            println("parse success!")
         
        } else {
            println("parse failure!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        //println("Element's name is \(elementName)")
        //println("Element's attributes are \(attributeDict)")
        if (elementName == "trip" || elementName == "leg"){
                println("trip: \(attributeDict)")
            
        }
        
    }

    func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        NSLog("failure error: %@", parseError)
    }
}


