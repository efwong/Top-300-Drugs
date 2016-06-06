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
    let drugThreeConstantKey = "DrugSetThree"
    private let hideFlashCardInstructionKey = "HideFlashCardInstructionKey"
    private let hideGameInstructionKey = "HideGameInstructionKey"
    
    private init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        // set defaults if they dont exist
        if defaults.objectForKey(drugOneConstantKey) == nil {
            defaults.setBool(true, forKey: drugOneConstantKey)
        }
        if defaults.objectForKey(drugTwoConstantKey) == nil{
            defaults.setBool(true, forKey: drugTwoConstantKey)
        }
        if defaults.objectForKey(drugTwoConstantKey) == nil{
            defaults.setBool(false, forKey: drugThreeConstantKey)
        }
        if defaults.objectForKey(hideFlashCardInstructionKey) == nil{
            defaults.setBool(false, forKey: hideFlashCardInstructionKey)
        }
        if defaults.objectForKey(hideGameInstructionKey) == nil{
            defaults.setBool(false, forKey: hideGameInstructionKey)
        }
    }
    
    // is drug(1,2,3) selected
    func isDrugSelected(key: String) -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        let status = defaults.boolForKey(key)
        return status
    }
    
    // saves drug(1,2,3) setting
    func saveDrugStatus(key: String, status:Bool){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(status, forKey: key)
    }
    
    // true -> hide flash card instruction
    func isFlashCardInstructionsHidden() -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        let status = defaults.boolForKey(hideFlashCardInstructionKey)
        return status
    }
    
    // permanently hide flash card instructions
    func hideFlashCardInstructions() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: hideFlashCardInstructionKey)
    }
    
    // true -> hide flash card instruction
    func isGameInstructionsHidden() -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        let status = defaults.boolForKey(hideGameInstructionKey)
        return status
    }
    
    // permanently hide flash card instructions
    func hideGameInstructions() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: hideGameInstructionKey)
    }
}