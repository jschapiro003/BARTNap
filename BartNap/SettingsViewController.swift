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
    var destSelected:String?
    
    @IBOutlet weak var toFavoritesPickerView: UIPickerView!
    
    @IBOutlet weak var fromFavoritesPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toFavoritesPickerView.delegate = self
        fromFavoritesPickerView.delegate = self
       
        // Do any additional setup after loading the view.
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
            println("Selected origin \(itemSelected)")
            
        } else if pickerView == toFavoritesPickerView {
            //defaults.setObject(itemSelected, forKey: "destSelected")
            self.destSelected = itemSelected
            println("Selected destination \(itemSelected)")
        }

    
    }
    
    @IBAction func saveAsFavorite(sender: AnyObject) {
        if let originSelected = self.originSelected?{
            println(originSelected)
            defaults.setObject(originSelected, forKey: "originSelected")
        }
        
        if let destinationSelected = self.destSelected?{
            println(destinationSelected)
            defaults.setObject(destinationSelected, forKey: "destinationSelected")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
