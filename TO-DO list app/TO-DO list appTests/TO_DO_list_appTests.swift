//
//  TO_DO_list_appTests.swift
//  TO-DO list appTests
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import XCTest
import CoreData
@testable import TO_DO_list_app

class TO_DO_list_appTests: XCTestCase {
  
  
  var appDelegate : AppDelegate?
  var managedObjectContext: NSManagedObjectContext?
  
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      managedObjectContext = appDelegate.persistentContainer.viewContext
      
      
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
      
      self.managedObjectContext = nil
    }
  
  
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      // testing create pending Task
      let newPendingTask = Task(context: self.managedObjectContext!)
      newPendingTask.name = "Test Pending Task"
      newPendingTask.done = false
      
      self.appDelegate?.saveContext()
      
      XCTAssertFalse(newPendingTask.done, "should have been Pending Task")
      
      
      // testing create completed Task
      
      let newDoneTask = Task(context: self.managedObjectContext!)
      newDoneTask.name = "Test Done Task"
      newDoneTask.done = true
      
      self.appDelegate?.saveContext()
      
      XCTAssertTrue(newDoneTask.done, "should have been Completed Task")
      
      
      // testing fetch pending tasks
      do {
        let tasks = (try managedObjectContext!.fetch(Task.fetchRequest()) as! [Task]).filter{$0.done == false}.reversed()
        tasks.forEach{ XCTAssertFalse($0.done, "should have been Pending Tasks List")}
      } catch {
        print("Couldn't Fetch Data")
      }
      
      // testing fetch Completed tasks
      do {
        let tasks = (try managedObjectContext!.fetch(Task.fetchRequest()) as! [Task]).filter{$0.done == true}.reversed()
        tasks.forEach{ XCTAssertTrue($0.done, "should have been Completed Tasks List")}
      } catch {
        print("Couldn't Fetch Data")
      }

      
      // testing update done value for spacific Task
      // fetch pending tasks
      do {
        let tasks = (try managedObjectContext!.fetch(Task.fetchRequest()) as! [Task]).filter{$0.done == false}.reversed()
        if let testTask = tasks.first {
          // test it is already pending task
          XCTAssertFalse(testTask.done, "should have been Pending Task")
          testTask.done = true
          self.appDelegate?.saveContext()
          // test it changed to Completed task
          XCTAssertTrue(testTask.done, "should have been Completed Task")
        }else{
          // test if there is no item in Tasks Array
          XCTAssertNil(tasks.first, "there is no pending tasks")
        }
        
      } catch {
        print("Couldn't Fetch Data")
      }
      
      
      // testing update done value for spacific Task
      // fetch Done tasks
      do {
        let tasks = (try managedObjectContext!.fetch(Task.fetchRequest()) as! [Task]).filter{$0.done == true}.reversed()
        if let testTask = tasks.first {
          // test it is already pending task
          XCTAssertTrue(testTask.done, "should have been Completed Task")
          testTask.done = false
          self.appDelegate?.saveContext()
          // test it changed to pending task
          XCTAssertFalse(testTask.done, "should have been Pending Task")
        }else{
          // test if there is no item in Tasks Array
          XCTAssertNil(tasks.first, "there is no pending tasks")
        }
        
      } catch {
        print("Couldn't Fetch Data")
      }
      
      
      
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
