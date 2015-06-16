//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Sascha A. Carlin on 15.06.15.
//  Copyright (c) 2015 Sascha A. Carlin. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var receivedAudio = RecordedAudio()
    
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
    
	func playAudio(pitch: Float = 0, rate: Float = 1) {
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changeEffect = AVAudioUnitTimePitch()
        changeEffect.pitch = pitch
		changeEffect.rate = rate
        audioEngine.attachNode(changeEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeEffect, format: nil)
        audioEngine.connect(changeEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func slowSound(sender: UIButton) {
		playAudio(rate: 0.5)
    }

    @IBAction func fastSound(sender: UIButton) {
		playAudio(rate: 2)
    }
    
    @IBAction func stopSound(sender: UIButton) {
        println("in stopSound!")
        
        audioEngine.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
		playAudio(pitch: 1000)
    }
    
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
		playAudio(pitch: -1000)
    }

}
