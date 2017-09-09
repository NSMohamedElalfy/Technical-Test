//
//  Task+CoreDataProperties.swift
//  TO-DO list app
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var done: Bool
    @NSManaged public var name: String?

}
