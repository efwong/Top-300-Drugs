//
//  PharmQuestionRepository.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import CoreData


class PharmQuestionRepository: DataRepository {
    override init(){
        super.init()
    }
    
    func selectAll(request: NSFetchRequest) -> [Drugs]{
        var results:[Drugs] = []
        
        do{
            results = try managedObjectContext!.executeFetchRequest(request) as! [Drugs]
            print("success")
        }
        catch{
            results = []
            print("error")
        }
        
        return results
    }
}