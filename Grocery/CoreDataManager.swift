//
//  CoreDataManager.swift
//  Grocery
//
//  Created by Francesca Corsini on 12/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

import CoreData


// MARK: - CoreDataManager


class CoreDataManager {
    
    
    //MARK: Singleton creation

    
    static let sharedInstance: CoreDataManager = {
        let instance = CoreDataManager()
        return instance
    }()
    
    
    // MARK: Public
    
    
    func getItems() -> [Item] {
        // fetch persistent data
        var items = [Item]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            items = results as! [Item]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return items
    }
    
    
    func addItem(text: String) -> Item {
        // add item as persistent data
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: self.managedObjectContext) as! Item
        item.text = text
        self.saveContext()
        return item
    }
    
    
    func deleteItem(item: Item) {
        // delete item from persistent data
        self.managedObjectContext.delete(item)
        self.saveContext()
    }
    
    
    // MARK: CoreData

    
    lazy var applicationDocumentsDirectory: NSURL = {
        // gets the directory used by the app to store the Core Data store file
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex-1] as NSURL
    }()
    
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // gets the managed object model for the app
        let modelURL = Bundle.main.url(forResource: "Grocery", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // creates the persistent store coordinator for the app
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("Grocery.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // reports any error occurred
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // gets the managed object context for the app, bound to the persistent store coordinator
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Could not save \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
