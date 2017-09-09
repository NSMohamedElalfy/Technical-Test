//
//  ApplicationCoordinator.swift
//  TO-DO list app
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ApplicationCoordinator: Coordinator {
  let window: UIWindow
  
  let pendingTasksCoordinator : PendingTasksCoorinator
  let doneTasksCoordinator : DoneTasksCoorinator
  let managedObjectContext: NSManagedObjectContext
  
  var rootViewController : UITabBarController!
  
  
  init(window : UIWindow , managedObjectContext: NSManagedObjectContext) {
    self.window = window
    self.managedObjectContext = managedObjectContext
    self.pendingTasksCoordinator = PendingTasksCoorinator(presenter: UINavigationController() , managedObjectContext : self.managedObjectContext)
    self.doneTasksCoordinator = DoneTasksCoorinator(presenter: UINavigationController() , managedObjectContext : self.managedObjectContext)
    
    self.rootViewController = UITabBarController()
    
    rootViewController.viewControllers  = [pendingTasksCoordinator.presenter,doneTasksCoordinator.presenter]
  }
  
  func start() {
    guard let root = self.rootViewController else {return}
    window.rootViewController = root
    pendingTasksCoordinator.start()
    doneTasksCoordinator.start()
    window.makeKeyAndVisible()
  }
  
}
