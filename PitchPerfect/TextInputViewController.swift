//
//  TextInputViewController.swift
//  PitchPerfect
//
//  Created by Swift on 02/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import AVFoundation

class TextInputViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var textViewOfProspectiveSpeech: UITextView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var speechButton: UIButton!
       // Create sound system
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    // MARK: Action
    
    
    @IBAction func speakAccordingToTextButton(_ sender: UIButton)
    
    {
      synth.speak(myUtterance)
        
        stopButton.isEnabled = true
        speechButton.isEnabled = false
    }
    @IBAction func okayButton(_ sender: UIButton)
    {
        // Create directory Path
//        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//        let recordingName = "recordedVoice.wav"
//        let pathArray = [dirPath, recordingName]
//        let filePath = URL(string: pathArray.joined(separator: "/"))
       
        synth.stopSpeaking(at: .word)
        speechButton.isEnabled = true
        
        

    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Setup utterance.
        myUtterance = AVSpeechUtterance(string: textViewOfProspectiveSpeech.text)
        myUtterance.rate = 0.5
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
