//
//  SoundTrackTableViewController.swift
//  PitchPerfect
//
//  Created by Swift on 02/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import CoreData

class SoundTrackTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: Properites
//    var names = ["Chanh", "Long"]
//    var type = ["Near", "Far"]
//    var duration = ["15s", "20s"]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!

    // MARK: Actions
    
    @IBAction func addSoundTrack(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "addSoundTrack", sender: nil)
//        // create alertcontroller
//        let alert = UIAlertController(title: "Add Movie", message: nil, preferredStyle: .alert)
//        
//        // add textfield to alert
//        alert.addTextField { (movieName) -> Void in
//            movieName.placeholder = "Enter Movie Name"
//        }
//        
//        // the add action for the textfield
//        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
//            // TODO: Implement
//            // 1
//            let entity = NSEntityDescription.entity(forEntityName: "SoundTrack", in: self.context)
//            // 2
//            let soundTrack = SoundTrack(entity:entity!, insertInto: self.context)
//            // 3
//            let textField = alert.textFields?.first
//            soundTrack.name = textField?.text
//            // 4
//            do {
//                try self.context.save()
//            } catch let error as NSError {
//                print("Error saving movie \(error.localizedDescription)")
//            }
//        }
//        
//        // the cancel action for the textfield
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        
//        // add the actions to the alert
//        alert.addAction(cancelAction)
//        alert.addAction(addAction)
//        
//        // present the alert
//        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SoundTrack")
        let fetchSort = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [fetchSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        //3
        do {
            try fetchedResultsController.performFetch()
            
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }

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
        guard let sectionData = fetchedResultsController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundTrackCell", for: indexPath) as! SoundTrackTableViewCell
        let soundTrack = fetchedResultsController.object(at: indexPath) as! SoundTrack
        cell.nameSoundTrack.text = soundTrack.name
        cell.typeofSoundTrack.text = soundTrack.type
        cell.duration.text = soundTrack.duration

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
            do
            {
                try context.save()
            } catch let error as NSError{
                print("Error saving context after delete: \(error.localizedDescription)")
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
