//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Swift on 24/01/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var message: String!
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    let recordedSoundTrack = RecordedSoundTrack()
    
    enum ButtonType: Int
    {
       case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Actions
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
        switch(ButtonType(rawValue: sender.tag)!)
        {
        case .slow:
            playSound(rate:  0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
       
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
        recordedSoundTrack.duration = "15s"
        recordedSoundTrack.type = "Slow"
        
        performSegue(withIdentifier: "saveAudioToBeSoundTrack", sender: recordedSoundTrack)
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveAudioToBeSoundTrack"
        {
            let addSoundTrackViewController = segue.destination as! AddSoundTrackViewController
            let recordedSoundTrack = sender as! RecordedSoundTrack
            addSoundTrackViewController.recordedSoundTrack = recordedSoundTrack
        }
    }
    

}
