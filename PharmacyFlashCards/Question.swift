//
//  Question.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 2/7/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

enum QuestionType:Int {
    case genericName
    case brandName
    case classification
    case dosage
    case indication
}

class Question{
    
    // MARK: Properties
    var questionType: QuestionType
    
    var question: String?{
        get{
            return "Default Question"
        }
    }
    
    let correctDrugIndex: Int
    let drugAnswers: [Drug]
    var correctDrug: Drug{
        get{
            return self.drugAnswers[self.correctDrugIndex]
        }
    }
    
    fileprivate var _userAnswerDrugIndex: Int?
    fileprivate var _wasAnsweredCorrectly:Bool?
    var wasAnsweredCorrectly: Bool?{
        get{
            return _wasAnsweredCorrectly
        }
        set{
            // can only update answer correct status if question was never answered before
            if self._wasAnsweredCorrectly == nil && newValue != nil{
                self._wasAnsweredCorrectly = newValue
            }
        }
    }
    
    
    
    // MARK: INIT
    // Inputs:
    //      questionType -> type of question (Brand, Generic, etc)ß
    //      correctDrugIndex -> index in the drugs array of the correct drug
    //      drugs -> array of drugs
    init(questionType: QuestionType, correctDrugIndex: Int, drugAnswers: [Drug]){
        self.questionType = questionType
        self.correctDrugIndex = correctDrugIndex
        self.drugAnswers = drugAnswers
    }
    
    
    // MARK Methods
    
    func getDrugByIndex(_ index:Int) -> Drug?{
        if index < self.drugAnswers.count {
            return self.drugAnswers[index]
        }else{
            return nil
        }
    }
    
    func getCorrectDrugLabel() -> String{
        return ""
    }
    
    func getDrugAnswerLabels() -> [String]{
        return []
    }
    
    // validate if selected drug is correct
    func isCorrectDrug(_ selectedDrugIndex:Int) -> Bool{
        var success:Bool = false
        
        if let selectedDrug = getDrugByIndex(selectedDrugIndex){
            switch self.questionType{
            case .genericName:
                if selectedDrug.brand == correctDrug.brand{
                    success = true
                }
                setWasAnsweredCorrectly(success, selectedDrugIndex: selectedDrugIndex)
            case .brandName:
                if selectedDrug.generic == correctDrug.generic{
                    success = true
                }
                setWasAnsweredCorrectly(success, selectedDrugIndex: selectedDrugIndex)
            case .classification:
                if selectedDrug.classification == correctDrug.classification{
                    success = true
                }
                setWasAnsweredCorrectly(success, selectedDrugIndex: selectedDrugIndex)
            case .dosage:
                if selectedDrug.dosage == correctDrug.dosage{
                    success = true
                }
                setWasAnsweredCorrectly(success, selectedDrugIndex: selectedDrugIndex)
            case .indication:
                if selectedDrug.indication == correctDrug.indication{
                    success = true
                }
                setWasAnsweredCorrectly(success, selectedDrugIndex: selectedDrugIndex)
//            default:
//                success = false
//                setWasAnsweredCorrectly(success, selectedDrugIndex: selectedDrugIndex)
            }
        }
        
        return success
    }
    
    // set user answer
    fileprivate func setWasAnsweredCorrectly(_ status: Bool, selectedDrugIndex: Int){
        if self._wasAnsweredCorrectly == nil {
            self._userAnswerDrugIndex = selectedDrugIndex
            self.wasAnsweredCorrectly = status
        }
    }
    
    
}
