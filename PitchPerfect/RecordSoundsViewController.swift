//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Swift on 23/01/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import AVFoundation
import Speech


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate
{
    //MARK: properties
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    // Variable of Speech Regonizer
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))

    
    var audioRecorder: AVAudioRecorder!
    // MARK: IBActions
    @IBAction func recordAudio(_ sender: UIButton)
    {
        print("record button was pressed")
        recordingLabel.text = "Recording in Progress"
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        
        // Create directory Path
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: UIButton)
    {
        print("stop record button was pressed")
        recordingLabel.text = "Tap to record"
        stopButton.isEnabled = false
        recordButton.isEnabled = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
   
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        print("Okay")
        if flag
        {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else
        {
            print("recording was not sucessful")
        }
    }
    
    // MARK: Prepare for seque
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"
        {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // MARK: override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request Authorization
      
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopButton.isEnabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

