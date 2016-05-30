//
//  CommonExtensions.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/29/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

extension Double{
    func ToStringWithPrecision(min:Int, max:Int) -> String{
        let scoreFormatter = NSNumberFormatter()
        scoreFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        scoreFormatter.maximumFractionDigits = min
        scoreFormatter.minimumFractionDigits = max
        return scoreFormatter.stringFromNumber(self) ?? "0"
    }
}