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
    fileprivate let questionTemplate: String = "Choose the Brand Name for %@"
    
    
    
    // MARK: INIT
    override init(questionType: QuestionType, correctDrugIndex: Int, drugAnswers: [Drug]){
        super.init(questionType: questionType, correctDrugIndex: correctDrugIndex, drugAnswers: drugAnswers)
    }
    
    // MARK: Public Methods
    override func getDrugAnswerLabels() -> [String]{
        return self.drugAnswers.map(){
            if let localDrug = ($0 as Drug?){
                return localDrug.brand! as String
            }else{
                return ""
            }
        }
    }
    
    override func getCorrectDrugLabel() -> String{
        if correctDrug.generic != nil {
            return correctDrug.generic!
        }
        return ""
    }
    
    // MARK Private Methods
    
}
