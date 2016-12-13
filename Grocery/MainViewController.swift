//
//  ViewController.swift
//  Grocery
//
//  Created by Francesca Corsini on 04/11/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

import UIKit


// MARK: - MainViewController


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // MARK: Properties

    
    @IBOutlet weak var tableView: UITableView!
    var items = [Item]()

    
    // MARK: Init/launch viewController

    
	override func viewDidLoad() {
		super.viewDidLoad()
        title = "Main List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.CellIdentifiers.mainCellIdentifier)
	}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // fetch persistent data
        items = CoreDataManager.sharedInstance.getItems()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.Segues.showEditSegue {
            let editViewController = segue.destination as! EditViewController
            let index = self.tableView.indexPathForSelectedRow?.row
            editViewController.item = items[index!]
            self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    
    // MARK: Actions
    
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alertView = UIAlertController(title: "New Item", message: "Add a new item", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler:{ (action:UIAlertAction) -> Void in
            let textField = alertView.textFields!.first
            // add item as persistent data
            let item = CoreDataManager.sharedInstance.addItem(text: textField!.text!)
            self.items.append(item)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifiers.mainCellIdentifier)
        let item = items[indexPath.row]
        cell!.textLabel!.text = item.text        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = items[indexPath.row]
            CoreDataManager.sharedInstance.deleteItem(item: item)
            items.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: UITableViewDelegate

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constant.Segues.showEditSegue, sender: nil)
    }
}

