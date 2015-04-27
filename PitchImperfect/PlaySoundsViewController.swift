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
    
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playAudioWithEffects(rate: Float = 1.0, pitch: Float = 1.0) {
        audioEngine.stop()
        audioEngine.reset()
        
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
        playAudioWithEffects(rate: 0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        println("Playing sound sped up")
        playAudioWithEffects(rate: 2.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        println("Playing sound with chipmunk effect")
        playAudioWithEffects(pitch: 1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        println("Playing sound with Darth Vader effect")
        playAudioWithEffects(pitch: -1000)
    }
    
    @IBAction func stopAudioPlaying(sender: UIButton) {
        println("Stopping playback")
        audioEngine.stop()
        audioEngine.reset()
    }

}
