//
//  OnlineSoundTrackTableViewController.swift
//  PitchPerfect
//
//  Created by Swift on 08/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class OnlineSoundTrackTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController = DataAcess.fetchData()
    var recordArray = [RecordedSoundTrack]()
    
    // MARK: Actions
    // For json processing
    func parseJSON()
    {
        let path : String = Bundle.main.path(forResource: "onlineSoundTrackJsonFile", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path)
        let readableJSON = JSON(data: jsonData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        let numberOfRecordFromJSON = readableJSON["SoundTrack"].count
        
        for recordIndex in 1...numberOfRecordFromJSON
        {
            var soundTrackKey = "Record"
            soundTrackKey += "\(recordIndex)"
            let nameFromJson = readableJSON["SoundTrack", soundTrackKey, "Name"].string as String!
            let typeFromJson = readableJSON["SoundTrack", soundTrackKey, "Type"].string as String!
            let durationFromJson = readableJSON["SoundTrack", soundTrackKey, "Duration"].string as String!
            let typeImageFromJson = readableJSON["SoundTrack", soundTrackKey, "TypeImage"].string as String!

            
            
            let recordedSoundTrack = RecordedSoundTrack()
            recordedSoundTrack.name = nameFromJson
            recordedSoundTrack.type = typeFromJson
            recordedSoundTrack.duration = durationFromJson
            recordedSoundTrack.typeImage = typeImageFromJson
            
            recordArray.append(recordedSoundTrack)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        parseJSON()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCount = fetchedResultsController.sections?.count else {
            return 0
        }
        return sectionCount
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return recordArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundTrackCell", for: indexPath) as! SoundTrackTableViewCell
         let soundTrackForEachCell = recordArray[indexPath.row]
      
        cell.nameSoundTrack.text = soundTrackForEachCell.name
        cell.typeofSoundTrack.text = soundTrackForEachCell.type
        cell.duration.text = soundTrackForEachCell.duration
        
        switch soundTrackForEachCell.typeImage {
        case "SlowImage":
            cell.typeImage.image = #imageLiteral(resourceName: "Slow")
        case "FastImage":
            cell.typeImage.image = #imageLiteral(resourceName: "Fast")
        case "ChipmunkImage":
            cell.typeImage.image = #imageLiteral(resourceName: "HighPitch")
        case "VaderImage":
            cell.typeImage.image = #imageLiteral(resourceName: "LowPitch")
        case "EchoImage":
            cell.typeImage.image = #imageLiteral(resourceName: "Echo")
        case "ReverbImage":
            cell.typeImage.image = #imageLiteral(resourceName: "Reverb")
   
        default:
            break
        }
        
        
        return cell
    }
    // MARK: Function of NSFetchControllerResult's delegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type
        {
        case .insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type
        {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        default: break
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let soundTrack = fetchedResultsController.object(at: indexPath) as! SoundTrack
            context.delete(soundTrack)
            DataAcess.saveContext()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "editSoundTrack"
        {
            let editSoundTrackViewController = segue.destination as! EditSoundTrackViewController
            let indexNeededToUpdate = sender as! IndexPath
            editSoundTrackViewController.index = indexNeededToUpdate
        }
        
    }

}
