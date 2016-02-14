//
//  BrandQuestion.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 2/7/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

class BrandQuestion: Question{
    
    // MARK: Properties
    override var question: String?{
        get{
            return String(format:self.questionTemplate, self.correctDrug.brand!)
        }
    }
    
    // MARK: Private Properties
    private let questionTemplate: String = "Choose the BRAND NAME for %@"
    
    
    
    // MARK: INIT
    override init(questionType: QuestionType, correctDrugIndex: Int, drugAnswers: [Drug]){
        super.init(questionType: questionType, correctDrugIndex: correctDrugIndex, drugAnswers: drugAnswers)
    }
    
    // MARK: Public Methods
    override func getDrugAnswerLabels() -> [String]{
        return self.drugAnswers.map(){
            if let localDrug = ($0 as Drug?){
                return localDrug.generic! as String
            }else{
                return ""
            }
        }
    }
    
    // MARK Private Methods
    
}
