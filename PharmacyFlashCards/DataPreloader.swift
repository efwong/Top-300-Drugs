//
//  DataPreloader.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import CSwiftV
import CoreData

class DataPreloader{
    
    static func preloadData(_ file: String, withExtension: String, managedObjectContext: NSManagedObjectContext?) -> [[String]]?{
        var rows:[[String]]? = nil
        // Retrieve data from the source file
        if let contentsOfURL = Bundle.main.url(forResource: file, withExtension: withExtension) {
         //   do{
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Drug")
                // clear data
                if clearEntity(fetchRequest, managedObjectContext: managedObjectContext!) {
                    rows = parseCsv(contentsOfURL)
                }
                
               // let content2 = "Year,Make,Model,Description,Price\r\n1997,Ford,\"E350\",descrition,3000.00\r\n1999,Chevy,Venture,\"another, amazing, description\",4900.00"
           
           // }
           // catch{
           //     print("error parsing file")
           // }
        }
        return rows
    }
    
    static func parseCsv(_ contentsOfURL: URL) -> [[String]]?{
        var rows:[[String]]? = nil
        do{
            let content = try String(contentsOf: contentsOfURL, encoding: String.Encoding.utf8)
            let csv = CSwiftV(with: content)
            rows = csv.rows
        }
        catch{
            print("Parsing CSV error")
        }
        return rows;
    }
    
    static func clearEntity(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>, managedObjectContext: NSManagedObjectContext) -> Bool{
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        var success = false
        
        do {
            try managedObjectContext.execute(deleteRequest)
            success = true
        } catch{
            print("Unable to clear entity")
        }
        return success
    }
}
