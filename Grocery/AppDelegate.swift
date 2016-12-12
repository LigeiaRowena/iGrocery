//
//  AppDelegate.swift
//  Grocery
//
//  Created by Francesca Corsini on 04/11/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

import UIKit


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
		CoreDataManager.sharedInstance.saveContext()
	}
}

