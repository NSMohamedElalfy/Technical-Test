//
//  DoneTasksCoordinator.swift
//  TO-DO list app
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DoneTasksCoorinator : Coordinator {
  
  let presenter : UINavigationController
  let doneTaskViewController : GenericTableViewController<Task,UITableViewCell>
  
  init(presenter : UINavigationController , managedObjectContext: NSManagedObjectContext) {
    self.presenter = presenter
    self.presenter.tabBarItem = UITabBarItem(title: "Done", image: UIImage(named:"doneTabIcon"), tag: 1)
    self.doneTaskViewController = GenericTableViewController(items: [], configureCell: { (cell, task) in
      cell.textLabel?.text = task.name
      
    })
    
    self.doneTaskViewController.loadData = {
      
      do {
        let tasks = try managedObjectContext.fetch(Task.fetchRequest()) as! [Task]
        self.doneTaskViewController.items = tasks.filter{$0.done == true}
      } catch {
        print("Couldn't Fetch Data")
      }
    }
    
  }
  
  func start() {
    self.presenter.pushViewController(doneTaskViewController, animated: false)
  }
  
  
}
