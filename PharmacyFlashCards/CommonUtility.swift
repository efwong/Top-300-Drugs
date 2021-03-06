//
//  CommonUtility.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/21/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import UIKit

class CommonUtility{
    
    static let service = CommonUtility()
    static let maxCountQuestionType:Int = 5
    
    var darkRedColor:UIColor? = nil
    var lightRedColor:UIColor? = nil
    var pinkColor:UIColor? = nil
    var AppConfig:NSDictionary? = nil
    
    fileprivate init(){
        self.darkRedColor = GetDarkRedColor()
        self.lightRedColor = GetLightRedColor()
        self.pinkColor = GetPinkColor()
        self.AppConfig = loadAppConfig()
    }
    
    fileprivate func GetDarkRedColor() -> UIColor{
        return UIColor(red: 200.0/255, green: 40.0/255, blue: 52.0/255, alpha: 0.5)
    }
    
    fileprivate func GetLightRedColor() -> UIColor{
        return UIColor(red: 220.0/255, green: 113.0/255, blue: 121.0/255, alpha: 0.5)
    }
    
    fileprivate func GetPinkColor() -> UIColor{
        return UIColor(red: 252.0/255, green: 192.0/255, blue: 197.0/255, alpha: 0.5)
    }
    
    fileprivate func loadAppConfig() -> NSDictionary?{
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "AppConfig", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        return myDict
    }
}
