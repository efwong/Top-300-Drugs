//
//  DataPreloader.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import CSwiftV

class DataPreloader{
    
    static func preloadData(file: String, withExtension: String){
        // Retrieve data from the source file
        if let contentsOfURL = NSBundle.mainBundle().URLForResource(file, withExtension: withExtension) {
            do{
                
               // let content2 = "Year,Make,Model,Description,Price\r\n1997,Ford,\"E350\",descrition,3000.00\r\n1999,Chevy,Venture,\"another, amazing, description\",4900.00"
                
                let content = try String(contentsOfURL: contentsOfURL, encoding: NSUTF8StringEncoding)
                //let content = "50,\"inj: 25-50 mgml, syrup: 10mg5ml\", dfjk"
                let csv = CSwiftV(String: content)
                let rows = csv.rows;
            }
            catch{
                print("error parsing file")
            }
        }
    }
}