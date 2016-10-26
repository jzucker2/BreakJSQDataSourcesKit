//
//  ViewController.swift
//  BreakJSQ
//
//  Created by Jordan Zucker on 10/25/16.
//  Copyright © 2016 Stanera. All rights reserved.
//

import UIKit
import JSQDataSourcesKit
import CoreData

typealias TestObjectCellFactory = ViewFactory<TestObject, ObjectCollectionViewCell>
typealias TestObjectHeaderViewFactory = TitledSupplementaryViewFactory<TestObject>
typealias TestObjectFRC = FetchedResultsController<TestObject>

class ViewController: UIViewController {
    
    var dataSourceProvider: DataSourceProvider<FetchedResultsController<TestObject>, TestObjectCellFactory, TestObjectHeaderViewFactory>!
    
    var delegateProvider: FetchedResultsDelegateProvider<TestObjectCellFactory>!
    
    weak var createTestObjectTimer: Timer? {
        willSet {
            createTestObjectTimer?.invalidate()
        }
    }
    
    lazy var fetchedResultsController: TestObjectFRC = {
        let allResultsFetchRequest: NSFetchRequest<TestObject> = TestObject.fetchRequest()
        let creationDateSortDescriptor = NSSortDescriptor(key: #keyPath(TestObject.creationDate), ascending: false)
        allResultsFetchRequest.sortDescriptors = [creationDateSortDescriptor]
        let controller = TestObjectFRC(fetchRequest: allResultsFetchRequest, managedObjectContext: UIApplication.shared.persistentContainer.viewContext, sectionNameKeyPath: #keyPath(TestObject.creationDate), cacheName: nil)
        assert(self.delegateProvider != nil, "Delegate Provider must exist")
        controller.delegate = self.delegateProvider.collectionDelegate
        return controller
    }()
    
    func fetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var collectionView: UICollectionView!
    
    override func loadView() {
        let bounds = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        self.view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(ObjectCollectionViewCell.self, forCellWithReuseIdentifier: ObjectCollectionViewCell.reuseIdentifier())
        
        let cellFactory = ViewFactory(reuseIdentifier: ObjectCollectionViewCell.reuseIdentifier()) { (cell, model: TestObject?, type, collectionView, indexPath) -> ObjectCollectionViewCell in
            cell.update(object: model)
            return cell
        }
        
        let headerFactory = TitledSupplementaryViewFactory { (header, model: TestObject?, kind, collectionView, indexPath) -> TitledSupplementaryView in
            if let creationDate = model?.creationDate {
                header.label.text = "\(creationDate)"
            } else {
                header.label.text = "No date"
            }
            header.backgroundColor = .darkGray
            return header
        }
        
        self.delegateProvider = FetchedResultsDelegateProvider(cellFactory: cellFactory, collectionView: collectionView)
        self.dataSourceProvider = DataSourceProvider(dataSource: fetchedResultsController, cellFactory: cellFactory, supplementaryFactory: headerFactory)
        collectionView.dataSource = dataSourceProvider.collectionViewDataSource
        
        navigationItem.title = "Break It!"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTestObjectsButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Break", style: .plain, target: self, action: #selector(breakButtonTapped(sender:)))
        fetch()
        createTestObjectTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(createObjectTimerFired(timer:)), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    func addTestObjectsButtonTapped(sender: UIBarButtonItem) {
        for i in 0..<20 {
            let title = "Item \(i)"
            TestObject.saveObject(title: title)
        }
    }
    
    func createObjectTimerFired(timer: Timer) {
        let now = "\(Date())"
        TestObject.saveObject(title: now)
    }
    
    func concurrentCreate() {
        DispatchQueue.concurrentPerform(iterations: 5, execute: { (count) -> Void in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.1, execute: {
                let title = "Item \(count)"
                TestObject.saveObject(title: title)
            })
        })
    }
    
    func breakButtonTapped(sender: UIBarButtonItem) {
        
        DispatchQueue.concurrentPerform(iterations: 20, execute: { (count) -> Void in
            self.concurrentCreate()
        })
    }


}

