//
//  ViewController.swift
//  PodiumTimer
//
//  Created by Jerry haaser on 11/10/20.
//  Copyright © 2020 Jerry haaser. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var individualTimerLabel: UILabel!
    @IBOutlet weak var groupTimerLabel: UILabel!
    
    var individualTime = 10
    var groupTime = 300
    var timer: Timer!
    var isActive = false
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        individualTimerLabel.text = "\(formatTimeLabels(time: TimeInterval(individualTime)))"

        groupTimerLabel.text = "\(formatTimeLabels(time: TimeInterval(groupTime)))"
        
    }
    
    func formatTimeLabels(time: TimeInterval) -> String {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i", minutes, seconds)
        
    }
    
    func startIndividualTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateIndividualTimer), userInfo: nil, repeats: true)
    }
    
    func startGroupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateGroupTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateIndividualTimer() {
        if individualTime > 0 {
            individualTime -= 1
        } else {
            timer.invalidate()
            individualTime = 180
            isActive = true
            soundTrigger()
            individualTimerLabel.textColor = .red
            
        }
        individualTimerLabel.text = "\(formatTimeLabels(time: TimeInterval(individualTime)))"
    }
    
    func resetIndividualTimer() {
        timer.invalidate()
        individualTimerLabel.textColor = .black
        isActive = false
        player?.pause()
    }
    
    @objc func updateGroupTimer() {
        if groupTime > 0 {
            groupTime -= 1
        } else {
            timer.invalidate()
            groupTime = 300
            isActive = true
            soundTrigger()
        }
        groupTimerLabel.text = "\(formatTimeLabels(time: TimeInterval(groupTime)))"
    }
    
    func resetGroupTimer() {
        timer.invalidate()
        groupTimerLabel.textColor = .black
        isActive = false
        player?.pause()
    }
    
    func soundTrigger() {
        if isActive == true {
            playSound()
        } else {
            //player?.pause()
        }
    }
    
    func playSound() {
        let path = Bundle.main.path(forResource: "Tiny Frog-SoundBible.com-1771194786.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = 100
            player?.play()
        } catch {
            print("Whoopsies")
        }
    }
    
    
    
    @IBAction func iStartButtonPressed(_ sender: Any) {
        startIndividualTimer()
    }
    @IBAction func iResetButtonPressed(_ sender: Any) {
        resetIndividualTimer()
    }
    @IBAction func gStartButtonPressed(_ sender: Any) {
        startGroupTimer()
    }
    @IBAction func gResetButtonPressed(_ sender: Any) {
        resetGroupTimer()
    }
    


}

