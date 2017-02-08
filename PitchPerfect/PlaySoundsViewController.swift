//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Swift on 24/01/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {
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
    
    // Effect
    var newAudio: AVAudioFile!
    var audioPlayer: AVAudioPlayer!
    
 
    let recordedSoundTrack = RecordedSoundTrack()
    // Properties of recorded sound track that will be sent to create new SoundTrack with information View
    var type: String!
    
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
            type = "Slow"
            //To do: save a new file after change the effect of the original file
            recordedSoundTrack.url = audioFile.url
  
        case .fast:
            playSound(rate: 1.5)
            type = "Fast"
            recordedSoundTrack.url = audioFile.url
            
        case .chipmunk:
            playSound(pitch: 1000)
            type = "Chipmunk"
            recordedSoundTrack.url = audioFile.url
            
        case .vader:
            playSound(pitch: -1000)
            type = "Vader"
            recordedSoundTrack.url = audioFile.url
            
        case .echo:
            playSound(echo: true)
            type = "Echo"
            recordedSoundTrack.url = audioFile.url
            
            
        case .reverb:
            playSound(reverb: true)
            type = "Reverb"
            recordedSoundTrack.url = audioFile.url
            
        }
        configureUI(.playing)
       
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
        
        recordedSoundTrack.type = type
        // Duration:
        let player = try! AVAudioPlayer(contentsOf: recordedAudioURL)
        recordedSoundTrack.duration = stringFromTimeInterval(interval: player.duration)
        
        performSegue(withIdentifier: "saveAudioToBeSoundTrack", sender: self)
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Pass URL to the instance that will be sent to Add new Sound track View controller later
       
        
        
        
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
            addSoundTrackViewController.recordedSoundTrack = recordedSoundTrack
            
        }
    }
    

}
