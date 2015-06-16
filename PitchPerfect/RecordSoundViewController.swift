//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Sascha A. Carlin on 14.06.15.
//  Copyright (c) 2015 Sascha A. Carlin. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var lbRecording: UILabel!

    @IBOutlet weak var btnStopRecording: UIButton!
    @IBOutlet weak var btnStartRecording: UIButton!

    var stateRecoding: Bool = false
    var audioRecorder: AVAudioRecorder!
	var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
		super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.btnStopRecording.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordAudio(sender: UIButton) {

		self.stateRecoding = !self.stateRecoding
        
        if self.stateRecoding {
            self.lbRecording.hidden = false
            self.btnStopRecording.hidden = false
            self.btnStartRecording.enabled=false
        } else {
            self.lbRecording.hidden = true
        }
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let recordingName = "pitchperfect.waw"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
        
    }
	
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
			let recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            self.lbRecording.hidden = true
            self.btnStopRecording.hidden = true
            self.btnStartRecording.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio
            playSoundVC.receivedAudio = data
            
        }
    }
   
    @IBAction func recordAudioStop(sender: UIButton) {
        println("in recordAudioStop!")
        self.lbRecording.hidden = true
        self.btnStopRecording.hidden = true
        self.btnStartRecording.enabled = true

        self.stateRecoding = false
        
        audioRecorder.stop()
        var session = AVAudioSession.sharedInstance()
        session.setActive(false, error: nil)
        
    }
}

