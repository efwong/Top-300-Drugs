//
//  Question.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 2/7/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

enum QuestionType {
    case GenericName
    case BrandName
    case Classification
    case Dosage
    case Indication
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
    
    func getDrugByIndex(index:Int) -> Drug?{
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
    
    func isCorrectDrug(selectedDrug:Drug) -> Bool{
        var success:Bool = false
        
        switch self.questionType{
        case .GenericName:
            if selectedDrug.brand == correctDrug.brand{
                success = true
            }
        case .BrandName:
            if selectedDrug.generic == correctDrug.generic{
                success = true
            }
        case .Classification:
            if selectedDrug.classification == correctDrug.classification{
                success = true
            }
        case .Dosage:
            if selectedDrug.dosage == correctDrug.dosage{
                success = true
            }
        default:
            success = false
        }
        
        return success
    }
    
//    private func getQuestionByType() ->String{
//        var questionTemplate:String
//        switch self.questionType{
//        case .GenericName:
//            questionTemplate = "Choose the BRAND NAME for %@"
//        case .BrandName:
//            questionTemplate = "Choose the GENERIC NAME for %@"
//        case .Classification:
//            questionTemplate = "Choose the CLASSIFICATION for %@"
//        case .Dosage:
//            questionTemplate = "Choose the DOSAGE RANGE for %@"
//        default:
//            questionTemplate = "%@"
//        }
//        
//        return questionTemplate
//    }
    
}
