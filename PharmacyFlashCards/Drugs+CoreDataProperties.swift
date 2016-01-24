//
//  Drugs+CoreDataProperties.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Drugs {

    @NSManaged var generic: String?
    @NSManaged var brand: String?
    @NSManaged var classification: String?
    @NSManaged var indication: String?
    @NSManaged var dosage_min_mg: NSNumber?
    @NSManaged var dosage_max_mg: NSNumber?
    @NSManaged var special_dosing: String?

}
