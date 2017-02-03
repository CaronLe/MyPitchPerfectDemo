//
//  AddSoundTrackViewController.swift
//  PitchPerfect
//
//  Created by Swift on 02/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import CoreData

class AddSoundTrackViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var nameSoundTrack: UITextField!
    @IBOutlet weak var typeSoundTrack: UITextField!
    @IBOutlet weak var duration: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Actions
    @IBAction func saveSoundTrackInformation(_ sender: UIButton)
    {
        let entityDescription = NSEntityDescription.entity(forEntityName: "SoundTrack", in: context)
        let soundTrack = SoundTrack(entity: entityDescription!, insertInto: context)
        soundTrack.name = nameSoundTrack.text
        soundTrack.type = typeSoundTrack.text
        soundTrack.duration = duration.text
        
                do
                {
                    try context.save()
                    print("saved successfully!")
                    navigationController?.popViewController(animated: true)
                }
                catch let error as NSError {
                    print("Could not save \(error)")
                    
                }
                

    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

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
