//
//  PlaySoundsViewController.swift
//  PitchImperfect
//
//  Created by Michael Rubinstein on 4/23/15.
//  Copyright (c) 2015 Hyloware. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var switchRestartPlaybacks: UISwitch!
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playAudio(rate: Float) {
        if switchRestartPlaybacks.on {
            audioPlayer.currentTime = 0.0
        }
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioVariableRate(rate: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeRateEffect = AVAudioUnitTimePitch()
        changeRateEffect.rate = rate
        audioEngine.attachNode(changeRateEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeRateEffect, format: nil)
        audioEngine.connect(changeRateEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func playAudioMaster(rate: Float = 1.0, pitch: Float = 1.0) {
        audioPlayer.stop()
        audioEngine.stop()
//        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeAudioEffect = AVAudioUnitTimePitch()
        changeAudioEffect.rate = rate
        changeAudioEffect.pitch = pitch
        audioEngine.attachNode(changeAudioEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeAudioEffect, format: nil)
        audioEngine.connect(changeAudioEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        println("Playing sound slowed down")
        playAudioMaster(rate: 0.5)
//        playAudio(0.5)
//        playAudioVariableRate(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        println("Playing sound sped up")
        playAudioMaster(rate: 2.5)
//        playAudio(2.0)
//        playAudioVariableRate(3.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        println("Playing sound with chipmunk effect")
        playAudioMaster(pitch: 1000)
//        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        println("Playing sound with Darth Vader effect")
        playAudioMaster(pitch: -1000)
//        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopAudioPlaying(sender: UIButton) {
        println("Stopping playback")
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
