//
//  Account+CoreDataProperties.swift
//  Banking With Biometrics
//
//  Created by Navpreet Brar on 2016-02-21.
//  Copyright © 2016 319ProjectTeam4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Account {

    @NSManaged var name: String?
    @NSManaged var transactions: NSSet?
    @NSManaged var user: User?

}
