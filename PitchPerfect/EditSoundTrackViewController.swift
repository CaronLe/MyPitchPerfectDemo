//
//  EditSoundTrackViewController.swift
//  PitchPerfect
//
//  Created by Swift on 03/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import CoreData

class EditSoundTrackViewController: UIViewController, NSFetchedResultsControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: Properties
    var index: IndexPath?
    @IBOutlet weak var nameSoundTrack: UITextField!
    @IBOutlet weak var typeSoundTrack: UIPickerView!
    @IBOutlet weak var duration: UITextField!
    
    var typeArray = ["Slow", "Fast", "Chipmunk", "Vader", "Echo", "Reverb"]
    // Properties for fetching
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController = DataAcess.fetchData()
    
    // MARK: Actions
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add delegate for typeSoundTrack picker
        typeSoundTrack.delegate = self
        typeSoundTrack.dataSource = self
        
        
        // Code for fetch configuration
        let soundTrack = fetchedResultsController.object(at: index!) as! SoundTrack
        nameSoundTrack.text = soundTrack.name
        if let theType = soundTrack.type
        {
            let indexOfTypeOfInstance = typeArray.index(of: theType)
            typeSoundTrack.selectRow(indexOfTypeOfInstance!, inComponent: 0, animated: true)
        }
        duration.text = soundTrack.duration
        
    }
    
    
    @IBAction func update(_ sender: UIButton)
    {
        let soundTrack = fetchedResultsController.object(at: index!) as! SoundTrack
        soundTrack.name = nameSoundTrack.text
        soundTrack.type = typeArray[typeSoundTrack.selectedRow(inComponent: 0)]
        soundTrack.duration = duration.text
        DataAcess.saveContext()
        navigationController?.popViewController(animated: true)
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeArray[row]
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
