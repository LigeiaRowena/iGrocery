//
//  Item+CoreDataProperties.swift
//  Grocery
//
//  Created by Francesca Corsini on 12/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var text: String?

}
