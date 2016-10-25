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
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = NSDate()
    }

}
