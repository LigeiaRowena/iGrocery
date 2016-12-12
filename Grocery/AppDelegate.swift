//
//  AppDelegate.swift
//  Grocery
//
//  Created by Francesca Corsini on 04/11/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
	var window: UIWindow?
    
    
    // MARK: AppDelegate methods


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		return true
	}

    
	func applicationWillResignActive(_ application: UIApplication) {
	}

    
	func applicationDidEnterBackground(_ application: UIApplication) {
    }

    
	func applicationWillEnterForeground(_ application: UIApplication) {
	}

    
	func applicationDidBecomeActive(_ application: UIApplication) {
	}

    
	func applicationWillTerminate(_ application: UIApplication) {
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

