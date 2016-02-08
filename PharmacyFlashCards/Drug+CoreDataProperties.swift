//
//  Drug+CoreDataProperties.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 2/7/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Drug {

    @NSManaged var brand: String?
    @NSManaged var classification: String?
    @NSManaged var dosage: String?
    @NSManaged var generic: String?
    @NSManaged var indication: String?
    @NSManaged var semester: NSNumber?

}
