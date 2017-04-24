//
//  GenericQuestion.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 3/6/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

class GenericQuestion: Question{
    
    // MARK: Properties
    override var question: String?{
        get{
            return String(format:self.questionTemplate, self.correctDrug.brand!)
        }
    }
    
    // MARK: Private Properties
    fileprivate let questionTemplate: String = "Choose the Generic Name for %@"
    
    
    
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
    
    override func getCorrectDrugLabel() -> String{
        if correctDrug.generic != nil {
            return correctDrug.brand!
        }
        return ""
    }
    // MARK Private Methods
    
}
