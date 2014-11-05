//
//  SettingsViewController.swift
//  BartNap
//
//  Created by Jonathan Schapiro on 11/4/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIPickerViewDelegate {

    var stationsArray = Array<Station>()
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var originSelected:String?
    var rowOriginSelected:Int = 0
    var destSelected:String?
    var rowDestSelected:Int = 0
    
    @IBOutlet weak var toFavoritesPickerView: UIPickerView!
    
    @IBOutlet weak var fromFavoritesPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toFavoritesPickerView.delegate = self
        fromFavoritesPickerView.delegate = self
       
        // Load favorite trip
        if let tripOrigin = defaults.objectForKey("originSelected") as? String{
            println("saved origin:\(tripOrigin)")
            if let rowOriginSelected = defaults.objectForKey("rowOriginSelected") as? Int {
                fromFavoritesPickerView.selectRow(rowOriginSelected, inComponent: 0, animated: false)
                self.rowOriginSelected = rowOriginSelected
                self.originSelected = stationsArray[rowOriginSelected].abbreviation
            }
        }
        
        if let tripDestination = defaults.objectForKey("destinationSelected") as? String{
            println("saved destination: \(tripDestination)")
            if let rowDestSelected = defaults.objectForKey("rowDestSelected") as? Int {
                toFavoritesPickerView.selectRow(rowDestSelected, inComponent: 0, animated: false)
                self.rowDestSelected = rowDestSelected
                self.destSelected = stationsArray[rowDestSelected].abbreviation
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
   
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stationsArray.count
        
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return stationsArray[row].name
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var itemSelected = stationsArray[row].abbreviation
        if pickerView == fromFavoritesPickerView {
            //defaults.setObject(itemSelected, forKey: "originSelected")
            self.originSelected = itemSelected
            self.rowOriginSelected = row
            println("Selected origin \(itemSelected)")
            
        } else if pickerView == toFavoritesPickerView {
            //defaults.setObject(itemSelected, forKey: "destSelected")
            self.destSelected = itemSelected
            self.rowDestSelected = row
            println("Selected destination \(itemSelected)")
        }
    }
    
    /*func selectRow(row: Int, inComponent component: Int, animated: Bool) {
    
    }*/
    
    @IBAction func saveAsFavorite(sender: AnyObject) {
        
        //Give default values if user don't touch picker view
        if self.originSelected == nil {
            self.originSelected = stationsArray[0].abbreviation
            self.rowOriginSelected = 0
        }
        if self.destSelected == nil {
            self.destSelected = stationsArray[0].abbreviation
            self.rowDestSelected = 0
        }
        
        if let originSelected = self.originSelected?{
            println(originSelected)
            defaults.setObject(originSelected, forKey: "originSelected")
            defaults.setObject(self.rowOriginSelected, forKey: "rowOriginSelected")
        }
        
        if let destinationSelected = self.destSelected?{
            println(destinationSelected)
            defaults.setObject(destinationSelected, forKey: "destinationSelected")
            defaults.setObject(self.rowDestSelected, forKey: "rowDestSelected")
        }
        
    }

}
