//
//  TestObject+CoreDataProperties.swift
//  BreakJSQ
//
//  Created by Jordan Zucker on 10/25/16.
//  Copyright © 2016 Stanera. All rights reserved.
//

import Foundation
import CoreData


extension TestObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestObject> {
        return NSFetchRequest<TestObject>(entityName: "TestObject");
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var title: String?

}
