//
//  QuestionUtility.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/22/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

class QuestionUtility {
    
    static func GetRandomQuestionType() -> QuestionType?{
        let randomQuestonTypeInt = arc4random_uniform(UInt32(CommonUtility.maxCountQuestionType)); // random number from 0 to maxCountQuestionTYpe
        return QuestionType(rawValue: Int(randomQuestonTypeInt));
    }
    
}