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
    
  let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
  var totalTime = 0
  var secondsPassed = 0 //1초마다 +1씩 될 변수
  
  var player: AVAudioPlayer!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var timerProgress: UIProgressView!
  
  var timer = Timer()
  
  /*
  let softTime = 5
  let mediumTime = 7
  let hardTime = 12
   */

  @IBAction func hardnessSelected(_ sender: UIButton) {
    let hardness = sender.currentTitle!
    totalTime = eggTimes[hardness]!

    timer.invalidate()
    timerProgress.progress = 0.0
    secondsPassed = 0
    titleLabel.text = hardness
  
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    
   
   
  }
  
  @objc func updateCounter() {
    if secondsPassed < totalTime {
 
      secondsPassed += 1
      timerProgress.progress = Float(secondsPassed) / Float(totalTime)
      
    } else {
      timer.invalidate()
      titleLabel.text = "🥚 done!!"
      
      //사운드
      let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
      player = try! AVAudioPlayer(contentsOf: url!)
      player.play()
    }
  }
  
}
