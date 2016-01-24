//
//  PharmQuestionService.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import CoreData
import CSwiftV
class PharmQuestionService {
//    override init(dataRepository: IDataRepository?){
//        super.init(dataRepository: dataRepository);
//    }
    
    var managedContext: NSManagedObjectContext?
    var dataRepository: PharmQuestionRepository?
    
    init(dataRepository: PharmQuestionRepository?){
        self.dataRepository = dataRepository
        self.managedContext = CoreDataStackManager.sharedManager.managedObjectContext
    }
    
    func selectAll() -> [Drugs]{
        
        let request = NSFetchRequest(entityName: "Drugs")
        request.returnsObjectsAsFaults = false
        let results:[Drugs] = (self.dataRepository?.selectAll(request))!
        
        return results;
    }
    
    func bulkInsert(){
        //CSwiftV(
    }
}