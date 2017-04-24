//
//  CommonExtensions.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/29/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

extension Double{
    func ToStringWithPrecision(_ min:Int, max:Int) -> String{
        let scoreFormatter = NumberFormatter()
        scoreFormatter.numberStyle = NumberFormatter.Style.decimal
        scoreFormatter.maximumFractionDigits = min
        scoreFormatter.minimumFractionDigits = max
        
        return scoreFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
