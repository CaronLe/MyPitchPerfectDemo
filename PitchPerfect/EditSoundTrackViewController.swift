//
//  EditSoundTrackViewController.swift
//  PitchPerfect
//
//  Created by Swift on 03/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import CoreData

class EditSoundTrackViewController: UIViewController, NSFetchedResultsControllerDelegate {
    // MARK: Properties
    var index: IndexPath?
    @IBOutlet weak var nameSoundTrack: UITextField!
    @IBOutlet weak var typeSoundTrack: UITextField!
    @IBOutlet weak var duration: UITextField!
    // Properties for fetching
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController = DataAcess.fetchData()
    
    // MARK: Actions
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Code for fetch configuration
        let soundTrack = fetchedResultsController.object(at: index!) as! SoundTrack
        nameSoundTrack.text = soundTrack.name
        typeSoundTrack.text = soundTrack.type
        duration.text = soundTrack.duration
        
    }
    
    
    @IBAction func update(_ sender: UIButton)
    {
        let soundTrack = fetchedResultsController.object(at: index!) as! SoundTrack
        soundTrack.name = nameSoundTrack.text
        soundTrack.type = typeSoundTrack.text
        soundTrack.duration = duration.text
        DataAcess.saveContext()
        navigationController?.popViewController(animated: true)
       
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
