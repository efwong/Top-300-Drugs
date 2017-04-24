//
//  PharmQuestionRepository.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import CoreData


class DrugRepository {
    var managedObjectContext: NSManagedObjectContext?
    init(){
        managedObjectContext = CoreDataStackManager.sharedManager.managedObjectContext
    }
    
    func selectAll(_ request: NSFetchRequest<NSFetchRequestResult>) -> [Drug]{
        var results:[Drug] = []
        
        do{
            results = try managedObjectContext!.fetch(request) as! [Drug]
        }
        catch{
            results = []
            print("error")
        }
        
        return results
    }
}
