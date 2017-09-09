//
//  PendingTasksCoordinator.swift
//  TO-DO list app
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class PendingTasksCoorinator : Coordinator {
  
  let presenter : UINavigationController
  let pendingTaskViewController : GenericTableViewController<Task,UITableViewCell>
  
  init(presenter : UINavigationController , managedObjectContext: NSManagedObjectContext) {
    self.presenter = presenter
    self.presenter.tabBarItem = UITabBarItem(title: "Pending", image: UIImage(named:"pendingTabIcon"), tag: 0)
    
   self.pendingTaskViewController = GenericTableViewController(items: [], configureCell: { (cell, task) in
    cell.textLabel?.text = task.name
   })
    
    self.pendingTaskViewController.loadData = {
      
      do {
        let tasks = try managedObjectContext.fetch(Task.fetchRequest()) as! [Task]
        self.pendingTaskViewController.items = tasks.filter{$0.done == false}  //.reversed()
      } catch {
        print("Couldn't Fetch Data")
      }
    }
    
    let addNewTaskButton = UIClosureBarButton(barButtonSystemItem: .add)
    addNewTaskButton.didTouchUpInside = { closureButton in
      print("new")
      
      let entity =
        NSEntityDescription.entity(forEntityName: "Task",
                                   in: managedObjectContext)!
      
      let task1 = Task(entity: entity,
                                   insertInto: managedObjectContext)
      
      // 3
      task1.name = "Task4"
      task1.done = false
      
      
      // 4
      do {
        try managedObjectContext.save()
        self.pendingTaskViewController.loadData()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
      
    }
    self.pendingTaskViewController.navigationItem.rightBarButtonItem = addNewTaskButton
  }
  
  func start() {
    self.presenter.pushViewController(pendingTaskViewController, animated: false)
  }
  
  
}
