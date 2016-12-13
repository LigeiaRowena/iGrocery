//
//  EditViewController.swift
//  Grocery
//
//  Created by Francesca Corsini on 12/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

import UIKit


// MARK: - EditViewControllerDelegate


protocol EditViewControllerDelegate {
    func didEditItem(item: Item)
}


// MARK: - EditViewController


class EditViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: Properties
    public var item: Item!
    @IBOutlet weak var textField: UITextField!
    var delegate: EditViewControllerDelegate?

    
    // MARK: Init/launch viewController

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textField.text = self.item.text
    }
    
    
    // MARK: UITextFieldDelegate
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: Actions
    
    
    @IBAction func save(_ sender: Any) {
        self.textField.resignFirstResponder()
        self.item.text = self.textField.text
        CoreDataManager.sharedInstance.saveContext()
        self.delegate?.didEditItem(item: item)
        _ = self.navigationController?.popViewController(animated: true)
    }
}
