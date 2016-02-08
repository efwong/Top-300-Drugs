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
    
    var correctDrug: Drug {
        get{
            return self.drugs[correctDrugIndex]
        }
    }
    
    var drugs: [Drug]
    
    // MARK: Private Properties
    private var correctDrugIndex: Int
    
    
    // MARK: INIT
    init(questionType: QuestionType, correctDrugIndex: Int, drugs: [Drug]){
        self.questionType = questionType
        self.correctDrugIndex = correctDrugIndex
        self.drugs = drugs
    }
    
    
    // MARK Methods
    func isCorrectDrug(selectedDrug:Drug) -> Bool{
        var success:Bool = false
        
        switch self.questionType{
        case .GenericName:
            if selectedDrug.generic == correctDrug.generic{
                success = true
            }
        case .BrandName:
            if selectedDrug.brand == correctDrug.brand{
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
