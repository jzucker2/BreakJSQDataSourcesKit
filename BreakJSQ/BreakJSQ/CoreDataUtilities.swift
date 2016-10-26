//
//  CoreDataUtilities.swift
//  BreakJSQ
//
//  Created by Jordan Zucker on 10/26/16.
//  Copyright © 2016 Stanera. All rights reserved.
//

import UIKit
import CoreData

extension TestObject {
    static func saveObject(title: String) {
        UIApplication.shared.persistentContainer.performBackgroundTask({ (context) in
            let _ = TestObject(title: title, context: context)
            do {
                try context.save()
                print(#function)
            } catch {
                fatalError(error.localizedDescription)
            }
        })
    }
}
