//
//  allDoneViewController.swift
//  BartNap
//
//  Created by Isabel Yepes on 3/11/14.
//  Copyright (c) 2014 Jonathan Schapiro. All rights reserved.
//

import UIKit
import AVFoundation

class allDoneViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()

    @IBAction func stopAlarmButton(sender: AnyObject) {
        if audioPlayer.playing {
            audioPlayer.stop()
        }
    }
    
    @IBAction func dismissModalButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playAlarmSound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func playAlarmSound() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("233645__zanox__alarm-clock-digital", ofType: "wav")!)
        println(alertSound)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
}
