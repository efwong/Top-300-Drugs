//
//  IDataRepository.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import CoreData

protocol IDataRepository {
    func insert(entity: NSEntityDescription?, managedObject: NSManagedObject)
//    func update(managedObject: NSManagedObject)
//    func delete(managedObject: NSManagedObject)
}