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
    
    static func preloadData(file: String, withExtension: String, managedObjectContext: NSManagedObjectContext?) -> [[String]]?{
        var rows:[[String]]? = nil
        // Retrieve data from the source file
        if let contentsOfURL = NSBundle.mainBundle().URLForResource(file, withExtension: withExtension) {
         //   do{
                let fetchRequest = NSFetchRequest(entityName: "Drugs")
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
    
    static func parseCsv(contentsOfURL: NSURL) -> [[String]]?{
        var rows:[[String]]? = nil
        do{
            let content = try String(contentsOfURL: contentsOfURL, encoding: NSUTF8StringEncoding)
            let csv = CSwiftV(String: content)
            rows = csv.rows;
        }
        catch{
            print("Parsing CSV error")
        }
        return rows;
    }
    
    static func clearEntity(fetchRequest: NSFetchRequest, managedObjectContext: NSManagedObjectContext) -> Bool{
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        var success = false
        
        do {
            try managedObjectContext.executeRequest(deleteRequest)
            success = true
        } catch{
            print("Unable to clear entity")
        }
        return success
    }
}