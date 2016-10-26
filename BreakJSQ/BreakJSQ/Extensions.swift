//
//  Extensions.swift
//  BreakJSQ
//
//  Created by Jordan Zucker on 10/26/16.
//  Copyright © 2016 Stanera. All rights reserved.
//

import UIKit
import CoreData

extension UIApplication {
    var persistentContainer: NSPersistentContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return appDelegate.persistentContainer
    }
}

extension UIView {
    
    static func reuseIdentifier() -> String {
        return NSStringFromClass(self)
    }
    
    func forceAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
