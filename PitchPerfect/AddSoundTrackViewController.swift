//
//  AddSoundTrackViewController.swift
//  PitchPerfect
//
//  Created by Swift on 02/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class AddSoundTrackViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var nameSoundTrack: UITextField!
    @IBOutlet weak var typeSoundTrack: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var progressBar: UISlider!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recordedSoundTrack: RecordedSoundTrack?
    var player: AVAudioPlayer!
    var timer: Timer!
  
    
    // MARK: Actions
    
    // Set up progress bar
    func getCurrentTimeAsString() -> String {
        var seconds = 0
        var minutes = 0
        if let time = player?.currentTime {
            seconds = Int(time) % 60
            minutes = (Int(time) / 60) % 60
        }
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
    func getProgress()->Float{
        var theCurrentTime = 0.0
        var theCurrentDuration = 0.0
        if let currentTime = player?.currentTime, let duration = player?.duration {
            theCurrentTime = currentTime
            theCurrentDuration = duration
        }
        return Float(theCurrentTime / theCurrentDuration)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateViewsWithTimer(theTimer:)), userInfo: nil, repeats: true)
    }
    
    func updateViewsWithTimer(theTimer: Timer){
        updateViews()
    }
    
    func updateViews(){
        
            progressBar.value = self.getProgress()
        
    }
    
    // Aleart to user that they have not entered name of the new soundtrack
    func noticeAboutMissedNameEnter()
    {
        let nameFieldMissedAleart = UIAlertController(title: "Missing Name SoundTrack", message: "Please enter your new SoundTrack's name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        nameFieldMissedAleart.addAction(okAction)
        self.present(nameFieldMissedAleart, animated: true, completion: nil)
 
    }
    
    @IBAction func saveSoundTrackInformation(_ sender: UIButton)
    {
   
        
        if (nameSoundTrack.text?.isEmpty)!
        {
            noticeAboutMissedNameEnter()
        }
        
        else
        {
            let entityDescription = NSEntityDescription.entity(forEntityName: "SoundTrack", in: context)
            let soundTrack = SoundTrack(entity: entityDescription!, insertInto: context)
           
            soundTrack.name = nameSoundTrack!.text
            soundTrack.type = typeSoundTrack!.text
            soundTrack.duration = duration.text
            
                    do
                    {
                        try context.save()
                        print("saved successfully!")
                        self.navigationController?.popViewController(animated: true)
                    }
                    catch let error as NSError {
                        print("Could not save \(error)")
                        
                    }
                
        }
    }
    
    
    @IBAction func playAudio(_ sender: UIButton)
    {
        player.play()
        startTimer()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        typeSoundTrack.text = recordedSoundTrack?.type
        duration.text = recordedSoundTrack?.duration
        do {
            try player = AVAudioPlayer(contentsOf: (recordedSoundTrack?.url)!)
            player.prepareToPlay()
        } catch let error as NSError {
            print(error)
        }
        progressBar.value = 0.0
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Add SoundTrack's information"
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
