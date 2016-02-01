//
//  DataRepository.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//
//
//import Foundation
//import CoreData
//
//class DataRepository: IDataRepository{
//    
//    var managedObjectContext: NSManagedObjectContext?
//    
//    init(){
//        managedObjectContext = CoreDataStackManager.sharedManager.managedObjectContext
//    }
//    
//    func insert(entity: NSEntityDescription?, managedObject: NSManagedObject){
//        do{
//            if managedObjectContext!.hasChanges {
//                try managedObjectContext!.save()
//                print("Object Saved")
//            }
//        } catch{
//            print("Error: cannot save")
//        }
//
//    }
//    
//    func selectAll(request: NSFetchRequest) -> [AnyObject]{
//        var results:[AnyObject] = []
//        
//        do{
//            results = try managedObjectContext!.executeFetchRequest(request)
//            print("success")
//        }
//        catch{
//            results = []
//            print("error")
//        }
//
//        return results
//    }
//    
//}