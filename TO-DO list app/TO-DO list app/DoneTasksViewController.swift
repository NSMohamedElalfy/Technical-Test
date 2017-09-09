//
//  DoneTasksViewController.swift
//  TO-DO list app
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import UIKit
import CoreData

class DoneTasksViewController: UITableViewController {

  var tasks : [Task] = [] {
    didSet{
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem
    tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: "Cell")

  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tableView.setEditing(false, animated: false)
    self.isEditing = false
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    do {
      let _tasks = try managedContext.fetch(Task.fetchRequest()) as! [Task]
      self.tasks = _tasks.filter{$0.done == true}.reversed()
    } catch {
      print("Couldn't Fetch Data")
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.tasks.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // Configure the cell...
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let task = self.tasks[indexPath.row]
    
    cell.textLabel?.text = task.name
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let item = self.tasks[indexPath.row]
    item.done = false
    appDelegate.saveContext()
    
    self.tasks.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    
    tableView.deselectRow(at: indexPath, animated: true)
    
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
      // delete item at indexPath
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      
      let item = self.tasks[indexPath.row]
      managedContext.delete(item)
      appDelegate.saveContext()
      
      self.tasks.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      
    }
    
    
    delete.backgroundColor = UIColor(red: 233/255, green: 39/255, blue: 0/255, alpha: 1.0)
    
    return [delete]
    
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
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
