//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var progressBar: UIProgressView!

    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12];

    var remainingSeconds:Int = 0;
    var initialTimer:Int = 0

    var timer = Timer()
    
    var audioPlayer : AVPlayer!

    @IBAction func hardnessClicked(_ sender: UIButton) {
        timer.invalidate();
        let hardness = sender.currentTitle!
        remainingSeconds = eggTimes[hardness]!
        initialTimer = remainingSeconds
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if(remainingSeconds > 0) {
            print(remainingSeconds)
            progressBar.progress = Float(initialTimer - remainingSeconds)/Float(initialTimer)
            remainingSeconds-=1
        } else if remainingSeconds == 0{
            progressBar.progress = 1.0
            timer.invalidate();
            titleLabel.text = "Done"
            initiateAlaram()
        }
    }
    
    func initiateAlaram(){
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
            print("error to get the mp3 file")
            return
        }

        do {
            audioPlayer = AVPlayer(url: url)
        }
        audioPlayer?.play()
    }
    
}
