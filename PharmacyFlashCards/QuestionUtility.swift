//
//  QuestionUtility.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/22/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation
import UIKit

class QuestionUtility {
    
    static func GetRandomQuestionType() -> QuestionType?{
        let randomQuestonTypeInt = arc4random_uniform(UInt32(CommonUtility.maxCountQuestionType)); // random number from 0 to maxCountQuestionTYpe
        return QuestionType(rawValue: Int(randomQuestonTypeInt));
    }
    
    static func getQuestionType(_ view: UIView) -> QuestionType?{
        var questionType: QuestionType? = nil
        
        if view.restorationIdentifier == "Generic" {
            questionType = QuestionType.genericName
        }
        else if view.restorationIdentifier == "Brand" {
            questionType = QuestionType.brandName
        }
        else if view.restorationIdentifier == "Classification" {
            questionType = QuestionType.classification
        }
        else if view.restorationIdentifier == "Dosage" {
            questionType = QuestionType.dosage
        }
        else if view.restorationIdentifier  == "Indication"{
            questionType = QuestionType.indication
        }else if view.restorationIdentifier == "Play"{
            // is play -> get random questionType
            questionType = QuestionUtility.GetRandomQuestionType()
        }else{
            // is settings
        }
        return questionType
    }
}
