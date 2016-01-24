//
//  PharmQuestionService.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import CoreData


class PharmQuestionService {
//    override init(dataRepository: IDataRepository?){
//        super.init(dataRepository: dataRepository);
//    }
    private let entityName:String = "Drugs"
    
    var managedObjectContext: NSManagedObjectContext?
    var dataRepository: PharmQuestionRepository?
    
    init(dataRepository: PharmQuestionRepository?){
        self.dataRepository = dataRepository
        self.managedObjectContext = CoreDataStackManager.sharedManager.managedObjectContext
    }
    
    func selectAll() -> [Drugs]{
        
        let request = NSFetchRequest(entityName: self.entityName)
        request.returnsObjectsAsFaults = false
        let results:[Drugs] = (self.dataRepository?.selectAll(request))!
        
        return results;
    }
    
    func bulkInsert(itemList:[[String]]){
        
        managedObjectContext!.reset()
        
        for item in itemList {
            let drugObject = NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext: managedObjectContext!) as! Drugs
            drugObject.generic = item[0]
            drugObject.brand = item[1]
            drugObject.classification = item[2]
            drugObject.indication = item[3]
            drugObject.dosage = item[4]
            drugObject.semester = Int(item[5])
        }
        
        // only save once per batch insert
        do {
            try managedObjectContext!.save()
        } catch {
            print("Error unable to bulk insert")
        }
        managedObjectContext!.reset()
    }
    
    func preloadData(){
        var data:[[String]]? = DataPreloader.preloadData("drugs", withExtension: "csv", managedObjectContext: managedObjectContext)
        
        if data != nil {
            bulkInsert(data!)
        }
        
    }
}