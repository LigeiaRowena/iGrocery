//
//  ViewController.swift
//  Grocery
//
//  Created by Francesca Corsini on 04/11/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

import UIKit
import CoreData


// MARK: - MainViewController


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var items = [NSManagedObject]()

    
    // MARK: Init/launch viewController

    
	override func viewDidLoad() {
		super.viewDidLoad()
        title = "Main List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
	}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // fetch persistent data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
        let results = try managedContext.fetch(fetchRequest)
        items = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: CoreData
    
    
    func saveItem(text: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        item.setValue(text, forKey: "text")
        appDelegate.saveContext()
        items.append(item)
    }
    
    
    // MARK: Actions
    
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alertView = UIAlertController(title: "New Item", message: "Add a new item", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler:{ (action:UIAlertAction) -> Void in
            let textField = alertView.textFields!.first
            self.saveItem(text: textField!.text!)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:{ (action:UIAlertAction) -> Void in
        })
        alertView.addTextField { (textField: UITextField) -> Void in
        }
        alertView.addAction(saveAction)
        alertView.addAction(cancelAction)
        present(alertView, animated: true, completion: nil)
    }
    
    
    // MARK: UITableViewDataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")
        let item = items[indexPath.row]
        cell!.textLabel!.text = item.value(forKey: "text") as? String
        
        return cell!
    }
    
    
    // MARK: UITableViewDelegate

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

