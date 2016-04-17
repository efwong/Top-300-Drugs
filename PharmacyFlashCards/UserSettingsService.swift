//
//  UserSettingsService.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 4/16/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

class UserSettingsService{
    
    static let service = UserSettingsService()
    
    let drugOneConstantKey = "DrugSetOne"
    let drugTwoConstantKey = "DrugSetTwo"
    
    private init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        // set defaults if they dont exist
        if defaults.objectForKey(drugOneConstantKey) == nil {
            defaults.setBool(true, forKey: drugOneConstantKey)
        }
        if defaults.objectForKey(drugTwoConstantKey) == nil{
            defaults.setBool(false, forKey: drugTwoConstantKey)
        }
    }
    
    func isDrugOneSelected() -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        let status = defaults.boolForKey(drugOneConstantKey)
        return status
    }
    
    func isDrugTwoSelected() -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        let status = defaults.boolForKey(drugTwoConstantKey)
        return status
    }
    
    func saveDrugOneStatus(status:Bool) -> Void{
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(status, forKey: drugOneConstantKey)
    }
    
    func saveDrugTwoStatus(status:Bool) -> Void{
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(status, forKey: drugTwoConstantKey)
    }
}