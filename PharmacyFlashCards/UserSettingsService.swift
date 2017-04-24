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
    fileprivate let hideFlashCardInstructionKey = "HideFlashCardInstructionKey"
    fileprivate let hideGameInstructionKey = "HideGameInstructionKey"
    
    fileprivate init(){
        let defaults = UserDefaults.standard
        // set defaults if they dont exist
        if defaults.object(forKey: drugOneConstantKey) == nil {
            defaults.set(true, forKey: drugOneConstantKey)
        }
        if defaults.object(forKey: drugTwoConstantKey) == nil{
            defaults.set(true, forKey: drugTwoConstantKey)
        }
        if defaults.object(forKey: drugTwoConstantKey) == nil{
            defaults.set(false, forKey: drugThreeConstantKey)
        }
        if defaults.object(forKey: hideFlashCardInstructionKey) == nil{
            defaults.set(false, forKey: hideFlashCardInstructionKey)
        }
        if defaults.object(forKey: hideGameInstructionKey) == nil{
            defaults.set(false, forKey: hideGameInstructionKey)
        }
    }
    
    // is drug(1,2,3) selected
    func isDrugSelected(_ key: String) -> Bool{
        let defaults = UserDefaults.standard
        let status = defaults.bool(forKey: key)
        return status
    }
    
    // saves drug(1,2,3) setting
    func saveDrugStatus(_ key: String, status:Bool){
        let defaults = UserDefaults.standard
        defaults.set(status, forKey: key)
    }
    
    // true -> hide flash card instruction
    func isFlashCardInstructionsHidden() -> Bool{
        let defaults = UserDefaults.standard
        let status = defaults.bool(forKey: hideFlashCardInstructionKey)
        return status
    }
    
    // permanently hide flash card instructions
    func hideFlashCardInstructions() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: hideFlashCardInstructionKey)
    }
    
    // true -> hide flash card instruction
    func isGameInstructionsHidden() -> Bool{
        let defaults = UserDefaults.standard
        let status = defaults.bool(forKey: hideGameInstructionKey)
        return status
    }
    
    // permanently hide flash card instructions
    func hideGameInstructions() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: hideGameInstructionKey)
    }
}
