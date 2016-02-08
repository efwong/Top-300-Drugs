//
//  PharmQuestionService.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import CoreData


class DrugService {
//    override init(dataRepository: IDataRepository?){
//        super.init(dataRepository: dataRepository);
//    }

    // MARK: Public Properties
    var managedObjectContext: NSManagedObjectContext?
    var dataRepository: DrugRepository?
    
    // MARK: Private Properties
    private let entityName:String = "Drug"
    
    // MARK: Init
    init(dataRepository: DrugRepository?){
        self.dataRepository = dataRepository
        self.managedObjectContext = CoreDataStackManager.sharedManager.managedObjectContext
    }
    
    
    // MARK: Public Methods
    func selectAll() -> [Drug]{
        
        let request = NSFetchRequest(entityName: self.entityName)
        request.returnsObjectsAsFaults = false
        let results:[Drug] = (self.dataRepository?.selectAll(request))!
        
        return results;
    }
    
    func bulkInsert(itemList:[[String]]){
        
        managedObjectContext!.reset()
        
        for item in itemList {
            let drugObject = NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext: managedObjectContext!) as! Drug
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
        let data:[[String]]? = DataPreloader.preloadData("drugs", withExtension: "csv", managedObjectContext: managedObjectContext)
        
        if data != nil {
            bulkInsert(data!)
        }
        
    }
}