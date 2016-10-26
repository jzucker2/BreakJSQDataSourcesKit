//
//  TestObject+CoreDataClass.swift
//  BreakJSQ
//
//  Created by Jordan Zucker on 10/25/16.
//  Copyright © 2016 Stanera. All rights reserved.
//

import Foundation
import CoreData

@objc(TestObject)
public class TestObject: NSManagedObject {
    
    public convenience init(title: String, context moc: NSManagedObjectContext) {
        self.init(context: moc)
        self.title = title
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = NSDate()
    }

}
